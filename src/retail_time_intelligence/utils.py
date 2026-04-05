"""
utils.py

Purpose:
Helper functions for debugging and analysis.
"""

import pandas as pd


def check_nulls(df: pd.DataFrame):
    print(df.isnull().sum())


def check_duplicates(df: pd.DataFrame):
    print("Duplicates:", df.duplicated().sum())


def df_info(df: pd.DataFrame):
    print(df.info())


def preview(df: pd.DataFrame, n=5):
    print(df.head(n))