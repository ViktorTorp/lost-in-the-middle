#!/usr/bin/env python3
import pathlib
from copy import deepcopy
from typing import List, Optional, Tuple, Type, TypeVar

from pydantic.dataclasses import dataclass

PROMPTS_ROOT = (pathlib.Path(__file__).parent / "prompts").resolve()

T = TypeVar("T")


@dataclass(frozen=True)
class Document:
    title: str
    text: str
    id: Optional[str] = None
    score: Optional[float] = None
    hasanswer: Optional[bool] = None
    isgold: Optional[bool] = None
    original_retrieval_index: Optional[int] = None

    @classmethod
    def from_dict(cls: Type[T], data: dict) -> T:
        data = deepcopy(data)
        if not data:
            raise ValueError("Must provide data for creation of Document from dict.")
        id = data.pop("id", None)
        score = data.pop("score", None)
        # Convert score to float if it's provided.
        if score is not None:
            score = float(score)
        return cls(**dict(data, id=id, score=score))


def get_gpt_prompt(
        question: str, documents: List[Document], mention_random_ordering: bool, query_aware_contextualization: bool, cot_prompting: bool = False, tot_prompting: bool = False
):
    if not question:
        raise ValueError(f"Provided `question` must be truthy, got: {question}")
    if not documents:
        raise ValueError(f"Provided `documents` must be truthy, got: {documents}")

    elif query_aware_contextualization:
        system_prompt = "system_qa.prompt"
        user_prompt = "qa_with_query_aware_contextualization.prompt"
    elif tot_prompting:
        system_prompt = "tot.prompt"
        user_prompt = "qa_tot.prompt"
    else:
        if cot_prompting:
            system_prompt = "cot.prompt"
            user_prompt = "user_cot.prompt"
        else:
            system_prompt = "system_qa.prompt"
            user_prompt = "user_qa.prompt"

    with open(PROMPTS_ROOT / system_prompt) as f:
        system_prompt = f.read().rstrip("\n")
    
    with open(PROMPTS_ROOT / user_prompt) as f:
        user_prompt = f.read().rstrip("\n")

    # Format the documents into strings
    formatted_documents = []
    for document_index, document in enumerate(documents):
        formatted_documents.append(f"Document [{document_index+1}](Title: {document.title}) {document.text}")
    return system_prompt, user_prompt.format(question=question, search_results="\n".join(formatted_documents))
    

def get_qa_prompt(
    question: str, documents: List[Document], mention_random_ordering: bool, query_aware_contextualization: bool, cot_prompting: bool = False, tot_prompting: bool = False, mapreduce_prompting = False,llama_prompting: bool = False
):
    if not question:
        raise ValueError(f"Provided `question` must be truthy, got: {question}")
    if not documents:
        raise ValueError(f"Provided `documents` must be truthy, got: {documents}")

    if mention_random_ordering and query_aware_contextualization:
        raise ValueError("Mentioning random ordering cannot be currently used with query aware contextualization")


    if query_aware_contextualization:
        prompt_filename = "qa_with_query_aware_contextualization.prompt"

    elif tot_prompting:
        prompt_filename = "qa_tot.prompt"
    else:
        if cot_prompting:
            prompt_filename = "qa_cot.prompt"
        else:
            prompt_filename = "qa.prompt"
    if llama_prompting:
        prompt_filename = "llama_" + prompt_filename
        
    with open(PROMPTS_ROOT / prompt_filename) as f:
        prompt_template = f.read().rstrip("\n")

    # Format the documents into strings
    formatted_documents = []
    for document_index, document in enumerate(documents):
        formatted_documents.append(f"Document [{document_index+1}](Title: {document.title}) {document.text}")
    return prompt_template.format(question=question, search_results="\n".join(formatted_documents))


def get_reduce_prompt(question: str, map_output: str, llama_prompting: bool = False, tot_prompting: bool = False):
    file_name = "reduce.prompt"
    if llama_prompting:
        if tot_prompting:
            file_name = "tot_" + file_name
        file_name = "llama_" + file_name
        with open(PROMPTS_ROOT / file_name) as f:
            prompt_template = f.read().rstrip("\n")
        return prompt_template.format(question=question, map_output=map_output)
    else:
        if tot_prompting:
            file_name = "tot_" + file_name
        system_file_name = "system_" + file_name
        user_file_name = "user_" + file_name
        with open(PROMPTS_ROOT / system_file_name) as f:
            system_prompt = f.read().rstrip("\n")
        
        with open(PROMPTS_ROOT / user_file_name) as f:
            user_prompt = f.read().rstrip("\n")
        return system_prompt, user_prompt.format(question=question, map_output=map_output)


def get_closedbook_qa_prompt(question: str, gpt=True, tot_prompting=False, cot_prompting=False):
    if not question:
        raise ValueError(f"Provided `question` must be truthy, got: {question}")
    
    if gpt:
        if tot_prompting:
            with open(PROMPTS_ROOT / "closedbook_qa_tot.prompt") as f:
                prompt_template = f.read().rstrip("\n")
        elif cot_prompting:
            with open(PROMPTS_ROOT / "closedbook_qa_cot.prompt") as f:
                prompt_template = f.read().rstrip("\n")
        else:
            with open(PROMPTS_ROOT / "closedbook_qa.prompt") as f:
                prompt_template = f.read().rstrip("\n")

        return prompt_template.format(question=question)
    else:
        if tot_prompting:
            with open(PROMPTS_ROOT / "closedbook_qa_tot_llama.prompt") as f:
                prompt_template = f.read().rstrip("\n")
        elif cot_prompting:
            with open(PROMPTS_ROOT / "closedbook_qa_cot_llama.prompt") as f:
                prompt_template = f.read().rstrip("\n")
        else:
            with open(PROMPTS_ROOT / "closedbook_qa_llama.prompt") as f:
                prompt_template = f.read().rstrip("\n")

        return prompt_template.format(question=question)

