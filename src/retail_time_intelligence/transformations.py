"""
transformations.py

Purpose:
Handle validation, cleaning, merging, and feature engineering.
"""

import pandas as pd


# ---------------------------------
# VALIDATION
# ---------------------------------
def validate_df(df: pd.DataFrame, name: str):
    print(f"\n🔍 Validating {name}")
    print("Shape:", df.shape)
    print("Missing:\n", df.isnull().sum())
    print("Duplicates:", df.duplicated().sum())


# ---------------------------------
# CLEANING
# ---------------------------------
def clean_sales(df: pd.DataFrame) -> pd.DataFrame:
    df = df.drop_duplicates()

    df["sales_amount"] = pd.to_numeric(df["sales_amount"], errors="coerce").fillna(0)
    df["cost_amount"] = pd.to_numeric(df["cost_amount"], errors="coerce").fillna(0)
    df["quantity_sold"] = df["quantity_sold"].fillna(0)

    return df


def clean_date(df: pd.DataFrame) -> pd.DataFrame:
    df["full_date"] = pd.to_datetime(df["full_date"], errors="coerce")
    return df


# ---------------------------------
# MERGE (STAR SCHEMA JOIN)
# ---------------------------------
def merge_data(data: dict) -> pd.DataFrame:
    df = (
        data["sales"]
        .merge(data["date"], on="date_key", how="left")
        .merge(data["store"], on="store_id", how="left")
        .merge(data["product"], on="product_id", how="left")
    )
    return df


# ---------------------------------
# FEATURE ENGINEERING
# ---------------------------------
def create_features(df: pd.DataFrame) -> pd.DataFrame:
    df["profit"] = df["sales_amount"] - df["cost_amount"]

    df["margin_pct"] = (df["profit"] / df["sales_amount"]) * 100
    df["margin_pct"] = df["margin_pct"].fillna(0)

    df["year"] = df["full_date"].dt.year
    df["month"] = df["full_date"].dt.month

    return df