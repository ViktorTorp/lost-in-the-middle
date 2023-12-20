#!/usr/bin/env python3
"""Given a data file with LM QA predictions, evaluate the predictions.
"""
import argparse
import json
import logging
import statistics
import sys
from copy import deepcopy
import pandas as pd

from tqdm import tqdm
from xopen import xopen
import sys
sys.path.append('./src')
from lost_in_the_middle.metrics import best_subspan_em

logger = logging.getLogger(__name__)

METRICS = [
    (best_subspan_em, "best_subspan_em"),
]

import numpy as np

def bootstrap_accuracy(y_pred, n_iterations=2700, ci=95):
    """
    Estimate the uncertainty of accuracy using bootstrapping.

    Parameters:
    - y_pred: List of subspan_em scores.
    - n_iterations: Number of bootstrap iterations.
    - ci: Desired confidence interval (e.g., 95 for 95% CI).

    Returns:
    - (lower_bound, upper_bound): Tuple of lower and upper bounds for the confidence interval.
    """

    # Convert input to numpy arrays for easier manipulation
    y_pred = np.array(y_pred)

    n_samples = y_pred.shape[0]
    micro_accuracy = np.mean(y_pred)
    accuracies = []
    for _ in range(n_iterations):
        # Resample with replacement
        indices = np.random.choice(np.arange(n_samples), size=n_samples, replace=True)
        sampled_y_pred = y_pred[indices]
        accuracy = np.mean(sampled_y_pred)
        # Compute accuracy for this sample and store
        accuracies.append(accuracy)

    # Compute confidence interval bounds
    lower_bound = np.percentile(accuracies, (100-ci)/2)
    upper_bound = np.percentile(accuracies, 100 - (100-ci)/2)

    return (lower_bound, upper_bound, micro_accuracy, accuracies)


def main(
    input_path,
    position_file,
    position_idx=0
):
    assert position_file is not None, "Must provide position csv"
    all_examples = []
    with xopen(input_path) as fin:
        for line in tqdm(fin):
            try:
                input_example = json.loads(line)
                all_examples.append(input_example)
            except Exception as e:
                print(e)

    all_scores = []
    for example in all_examples:
        all_scores.append(example[f"metric_best_subspan_em"])
    lower_bound, upper_bound, accuracy, accuracies = bootstrap_accuracy(all_scores)
    new_filename = position_file.split(".csv")[0] + "_uncertainity.csv"
    if str(position_idx) == "0":
        new_position_csv = pd.DataFrame(columns=['position', 'metric', 'lower_bound', 'upper_bound'])
        acc_df = pd.DataFrame(columns=['position','accuracy'])
    else:
        new_position_csv = pd.read_csv(new_filename)
        acc_df = pd.read_csv(new_filename.split(".csv")[0] + "_accs.csv")
    temp_df = pd.DataFrame({'position':[position_idx]*len(accuracies), 'accuracy':accuracies})
    acc_df = acc_df.append(temp_df, ignore_index=True)
    new_position_csv.loc[len(new_position_csv)] = [position_idx, accuracy, lower_bound, upper_bound]
    new_position_csv.to_csv(new_filename, index=False)
    acc_df.to_csv(new_filename.split(".csv")[0] + "_accs.csv", index=False)
    print(f"Accuracy: {accuracy:.3f} ({lower_bound:.3f}, {upper_bound:.3f})")
    logger.info(f"Accuracy: {accuracy:.3f} ({lower_bound:.3f}, {upper_bound:.3f})")

    

    
if __name__ == "__main__":
    logging.basicConfig(format="%(asctime)s - %(module)s - %(levelname)s - %(message)s", level=logging.INFO)
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-path", help="Path to data with model predictions and answers.", required=True)
    parser.add_argument("--position-csv", help="Path to position results csv", required=True)
    parser.add_argument("--position-idx", help="Index of position in csv.", default=0)
    args = parser.parse_args()

    logger.info("running %s", " ".join(sys.argv))
    main(
        args.input_path,
        args.position_csv,
        args.position_idx)
    logger.info("finished running %s", sys.argv[0])

