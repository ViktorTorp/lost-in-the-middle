#!/usr/bin/env python3
import numpy as np
import pandas as pd


def reposition_df(idx, acc): 
    """
    Find the new reposition ideces of documents
    based on their accuracy scores

    Parameters
    ----------
    idx : list
        List of indices of the documents of interest
    acc : list
        List of accuracy scores of the documents of interest
    
    Returns
    -------
    df : pandas.DataFrame
        DataFrame with the original and new positions of the documents of interest  
    
    Examples
    --------
    >>> idx = [0, 2, 4, 6, 8]
    >>> acc = [0.1, 0.3, 0.5, 0.7, 0.9]
    >>> reposition(idx, acc)
       original_position  acc  new_position
    8                  8  0.9             0
    6                  6  0.7             2
    4                  4  0.5             4
    2                  2  0.3             6
    0                  0  0.1             8
    """
    df = pd.DataFrame({"original_position":idx, "acc":acc})
    df = df.sort_values("acc")[::-1]
    df["original_position"] = df["original_position"].astype("int")
    df["new_position"] = np.sort(df["original_position"])
    return df


def reordering(documents, reorder_df):
    """
    Reorders the documents of interest from their original to their new positions

    Parameters
    ----------
    documents : list
        List of documents
    reorder_df : pandas.DataFrame
        DataFrame with the original and new positions of the documents of interest
    
    Returns
    -------
    new_documents : list
        List of documents in their new positions
    
    Examples
    --------
    >>> documents = ["doc1", "doc2", "doc3", "doc4", "doc5"]
    >>> reorder_df = pd.DataFrame({"original_position":[0, 4], "new_position":[4, 0]})
    >>> reordering(documents, reorder_df)
    ["doc5", "doc2", "doc3", "doc4", "doc0"]
    """
    new_documents = documents.copy()
    original_positions = reorder_df["original_position"].values
    new_positions = reorder_df["new_position"].values
    # Reorder the documents of interest from their original to their new positions
    for i, pos in enumerate(new_positions):
        new_documents[pos] = documents[original_positions[i]]
    return new_documents