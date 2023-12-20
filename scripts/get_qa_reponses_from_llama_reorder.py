#!/usr/bin/env python3
"""Given a data file with questions and retrieval results to use, run MPT to get responses.

Currently supports `mosaicml/mpt-30b-instruct` and `mosaicml/mpt-30b`.

The retrieval results are used in the exact order that they're given.
"""
import argparse
import dataclasses
import json
import logging
import math
import pathlib
import random
import sys
from copy import deepcopy
from dotenv import load_dotenv
from transformers import AutoTokenizer
from huggingface_hub import InferenceClient
from tqdm import tqdm
import os
import pandas as pd
from xopen import xopen
from sklearn.model_selection import KFold
import time



from tenacity import (
    retry,
    stop_after_attempt,
    wait_random_exponential,
)  # for exponential backoff



sys.path.append("./src")


from lost_in_the_middle.prompting import (
    Document,
    get_closedbook_qa_prompt,
    get_qa_prompt,
)
from lost_in_the_middle.reordering import reposition_df, reordering


logger = logging.getLogger(__name__)
random.seed(0)
HUGGINGFACEHUB_API_TOKEN = "HUGGINGFACEHUB_API_TOKEN"
HF_HUB_MODELS = {
    "llama-2-70b": "meta-llama/Llama-2-70b-chat-hf",
    "llama-2-13b": "meta-llama/Llama-2-13b-chat-hf",
    "llama-2-7b": "meta-llama/Llama-2-7b-chat-hf",
}
kf = KFold(n_splits=10, shuffle=True, random_state=42)

def main(
    input_path,
    model_name,
    temperature,
    closedbook,
    prompt_mention_random_ordering,
    use_random_ordering,
    query_aware_contextualization,
    cot_prompting,
    chain_prompting,
    tot_prompting,
    llama_prompting,
    max_new_tokens,
    output_path,
    position_csv,
):
    # Create directory for output path if it doesn't exist.
    pathlib.Path(output_path).parent.mkdir(parents=True, exist_ok=True)
    position_csv = pd.read_csv(position_csv)
    llm = InferenceClient(
        model=HF_HUB_MODELS[model_name],
        token=HUGGINGFACEHUB_API_TOKEN,
    )
    # Fetch all of the prompts
    with xopen(input_path) as fin:
        # kfold stuff
        all_examples = []
        for line in tqdm(list(fin)):
            input_example = json.loads(line)
            all_examples.append(input_example)
            # Get the prediction for the input example
        examples = [None] * len(all_examples)
        prompts = [None] * len(all_examples)
        all_model_documents = [None] * len(all_examples)
        did_format_warn = False
        # split examples into 5 folds
        for fold, (train_index, test_index) in enumerate(kf.split(all_examples)):
            tmp_position_csv = position_csv[position_csv['fold'].astype(int) == fold]
            reordering_df = reposition_df(tmp_position_csv["position"], tmp_position_csv["metric"])
            print(reordering_df)
            for idx in test_index:
                input_example = all_examples[idx]
                # Get the prediction for the input example
                question = input_example["question"]
                if closedbook:
                    documents = []
                else:
                    documents = []
                    for ctx in deepcopy(input_example["ctxs"]):
                        documents.append(Document.from_dict(ctx))
                    if not documents:
                        raise ValueError(f"Did not find any documents for example: {input_example}")

                if use_random_ordering:
                    # Randomly order only the distractors (isgold is False), keeping isgold documents
                    # at their existing index.
                    (original_gold_index,) = [idx for idx, doc in enumerate(documents) if doc.isgold is True]
                    original_gold_document = documents[original_gold_index]
                    distractors = [doc for doc in documents if doc.isgold is False]
                    random.shuffle(distractors)
                    distractors.insert(original_gold_index, original_gold_document)
                    documents = distractors
                old_docs = [doc for doc in documents]
                old_docs = [doc.title for doc in documents]
                documents = reordering(documents, reordering_df)
                new_docs = [doc.title for doc in documents]

                if closedbook:
                    prompt = get_closedbook_qa_prompt(question)
                else:
                    prompt = get_qa_prompt(
                        question,
                        documents,
                        mention_random_ordering=prompt_mention_random_ordering,
                        query_aware_contextualization=query_aware_contextualization,
                        cot_prompting=cot_prompting,
                        chain_prompting=chain_prompting,
                        tot_prompting=tot_prompting,
                        llama_prompting=llama_prompting,
                    )

                if "instruct" in model_name:
                    if did_format_warn is False:
                        logger.warning(f"Model {model_name} appears to be an instruct model, applying instruct formatting")
                        did_format_warn = True
                    prompt = format_instruct_prompt(prompt)
                prompts[idx] = prompt
                examples[idx] = deepcopy(input_example)
                all_model_documents[idx] = documents

    responses = []
    missing_responses = []
    with xopen(output_path, "a") as f:
        for i in tqdm(range(len(prompts))):
            response = ""
            example, model_documents, prompt = examples[i], all_model_documents[i], prompts[i]
            count = 0
            sleep_time = 1
            if i == 0:
                print(prompt)
            while len(response) == 0 and count < 5:
                try:
                    response = llm.text_generation(prompt, max_new_tokens=max_new_tokens, temperature=temperature)
                except Exception as e:
                    print(e)
                    time.sleep(sleep_time)
                    count += 1
                    sleep_time *= 2
            if len(response) == 0:
                logger.error(f"Error generating response for prompt: {prompt}")
                missing_responses.append(prompt)
            else:
                responses.append(response)

            print(len(missing_responses))


            output_example = deepcopy(example)
            # Add some extra metadata to the output example
            output_example["model_prompt"] = prompt
            output_example["model_documents"] = [dataclasses.asdict(document) for document in model_documents]
            output_example["model_answer"] = response
            output_example["model"] = model_name
            output_example["model_temperature"] = temperature
            output_example["model_top_p"] = 0
            output_example["model_prompt_mention_random_ordering"] = prompt_mention_random_ordering
            output_example["model_use_random_ordering"] = use_random_ordering
            f.write(json.dumps(output_example) + "\n")



def format_instruct_prompt(instruction):
    INSTRUCTION_KEY = "### Instruction:"
    RESPONSE_KEY = "### Response:"
    INTRO_BLURB = (
        "Below is an instruction that describes a task. Write a response that appropriately completes the request."
    )
    PROMPT_FOR_GENERATION = "{intro}\n{instruction_key}\n{instruction}\n{response_key}\n".format(
        intro=INTRO_BLURB,
        instruction_key=INSTRUCTION_KEY,
        instruction=instruction,
        response_key=RESPONSE_KEY,
    )
    return PROMPT_FOR_GENERATION


if __name__ == "__main__":
    logging.basicConfig(format="%(asctime)s - %(module)s - %(levelname)s - %(message)s", level=logging.INFO)
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-path", help="Path to data with questions and documents to use.", required=True)
    parser.add_argument(
        "--model",
        help="Model to use in generating responses",
        required=True,
        choices=["llama-2-70b", "llama-2-13b", "llama-2-7b"],
    )
    parser.add_argument("--temperature", help="Temperature to use in generation", type=float, default=0.6)
    parser.add_argument(
        "--closedbook", action="store_true", help="Run the model in closed-book mode (i.e., don't use documents).",
        default=False
    )
    parser.add_argument(
        "--prompt-mention-random-ordering",
        action="store_true",
        help="Mention that search results are ordered randomly in the prompt",
        default=False
    )
    parser.add_argument(
        "--use-random-ordering",
        action="store_true",
        help="Randomize the ordering of the distractors, rather than sorting by relevance.",
        default=False
    )
    parser.add_argument(
        "--query-aware-contextualization",
        action="store_true",
        help="Place the question both before and after the documents.",
        default=False
    )
    parser.add_argument(
        "--cot-prompting",
        action="store_true",
        help="Utilize Chain of thought prompting.",
        default=False
    )
    parser.add_argument(
        "--chain-prompting",
        action="store_true",
        help="Utilize retrieval chain prompting.",
        default=False
    )
    parser.add_argument(
        "--tot-prompting",
        action="store_true",
        help="Utilize tot prompting.",
        default=False
    )
    parser.add_argument(
        "--llama-prompting",
        action="store_true",
        help="Use llama prompts.",
        default=False
    )    
    parser.add_argument("--output-path", help="Path to write output file of generated responses", required=True)
    parser.add_argument("--position-csv", help="Path to write output file of generated responses", required=True)
    parser.add_argument(
        "--max-new-tokens",
        help="Maximum number of new tokens to generate",
        type=int,
        default=100,
    )
    args = parser.parse_args()

    logger.info("running %s", " ".join(sys.argv))
    main(
        args.input_path,
        args.model,
        args.temperature,
        args.closedbook,
        args.prompt_mention_random_ordering,
        args.use_random_ordering,
        args.query_aware_contextualization,
        args.cot_prompting,
        args.chain_prompting,
        args.tot_prompting,
        args.llama_prompting,
        args.max_new_tokens,
        args.output_path,
        args.position_csv
    )
    logger.info("finished running %s", sys.argv[0])


# python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-0613 --output-path qa_predictions/20_total_documents/nq-open-20_total_documents_gold_at_0_predictions.jsonl.gz
