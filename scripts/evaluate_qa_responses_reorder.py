#!/usr/bin/env python3
"""Given a data file with LM QA predictions, evaluate the predictions.
"""
import argparse
import json
import logging
import statistics
import sys
from copy import deepcopy
import pandas  as pd
from tqdm import tqdm
from sklearn.model_selection import KFold
from xopen import xopen
import sys
sys.path.append('./src')
from lost_in_the_middle.metrics import best_subspan_em

logger = logging.getLogger(__name__)

METRICS = [
    (best_subspan_em, "best_subspan_em"),
]


def main(
    input_path,
    output_path,
    position_csv=None,
    position_idx=0
):
    all_examples = []
    with xopen(input_path) as fin:
        for line in tqdm(fin):
            input_example = json.loads(line)
            all_examples.append(input_example)

    # Compute normal metrics in parallel, if applicable
    logger.info("Computing metrics")
    all_example_metrics = []
    for example in tqdm(all_examples):
        all_example_metrics.append(get_metrics_for_example(example))

    kf = KFold(n_splits=10, shuffle=True, random_state=42)
    # Average metrics across examples
    for (_, metric_name) in METRICS:
        for fold, (train_index, test_index) in enumerate(kf.split(all_example_metrics)):
            train_metrics = [all_example_metrics[i][0][metric_name] for i in train_index]
            average_metric_value = statistics.mean(train_metrics
            )
            logger.info(f"{metric_name} at fold {fold} : {average_metric_value}")
            if len(position_csv) > 0:
                if (int(position_idx) == 0 and fold == 0):
                    print(position_idx, fold)
                    res_df = pd.DataFrame(columns=['position', 'fold', 'metric'])
                else:
                    res_df = pd.read_csv(position_csv)
                res_df.loc[len(res_df)] = [position_idx, fold, average_metric_value]
                res_df.to_csv(position_csv, index=False)


def get_metrics_for_example(example):
    gold_answers = example["answers"]
    model_answer = example["model_answer"]
    if type(model_answer) == dict:
        model_answer = model_answer['choices'][0]['message']['content']

    # NOTE: we take everything up to the first newline, since otherwise models could hack
    # the metric by simply copying te input context (as the gold answer is guaranteed
    # to occur in the input context).
    model_answer = model_answer.split("\n")[0].strip()

    example_metrics = {}
    for (metric, metric_name) in METRICS:
        example_metrics[metric_name] = metric(prediction=model_answer, ground_truths=gold_answers)
    return (example_metrics, example)


if __name__ == "__main__":
    logging.basicConfig(format="%(asctime)s - %(module)s - %(levelname)s - %(message)s", level=logging.INFO)
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-path", help="Path to data with model predictions and answers.", required=True)
    parser.add_argument(
        "--output-path",
        help="Path to write data with model predictions, answers, and scores.",
    )
    parser.add_argument("--position-csv", help="Path to position results csv", required=True)
    parser.add_argument("--position-idx", help="Index of position in csv.", default=0)
    args = parser.parse_args()

    logger.info("running %s", " ".join(sys.argv))
    main(
        args.input_path,
        args.output_path,
        args.position_csv,
        args.position_idx
    )
    logger.info("finished running %s", sys.argv[0])
