"""
time_intelligence.py

Purpose:
Time-based analytics (MTD, YTD, rolling).
"""

import pandas as pd


def calculate_mtd(df: pd.DataFrame) -> pd.DataFrame:
    df = df.sort_values("full_date")

    df["mtd_sales"] = df.groupby(
        [df["year"], df["month"]]
    )["sales_amount"].cumsum()

    return df


def calculate_ytd(df: pd.DataFrame) -> pd.DataFrame:
    df = df.sort_values("full_date")

    df["ytd_sales"] = df.groupby("year")["sales_amount"].cumsum()

    return df


def rolling_sales(df: pd.DataFrame, window: int = 7) -> pd.DataFrame:
    df = df.sort_values("full_date")

    df[f"rolling_{window}_sales"] = df["sales_amount"].rolling(window).sum()

    return df