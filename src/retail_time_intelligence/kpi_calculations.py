"""
kpi_calculations.py

Purpose:
Business KPIs (profit, margin, growth).
"""

import pandas as pd


def calculate_profit(df: pd.DataFrame) -> pd.DataFrame:
    df["profit"] = df["sales_amount"] - df["cost_amount"]
    return df


def calculate_margin(df: pd.DataFrame) -> pd.DataFrame:
    df["margin_pct"] = (df["profit"] / df["sales_amount"]) * 100
    df["margin_pct"] = df["margin_pct"].fillna(0)
    return df


def monthly_growth(df: pd.DataFrame) -> pd.DataFrame:
    monthly = df.groupby(["year", "month"])["sales_amount"].sum().reset_index()

    monthly["growth_pct"] = monthly["sales_amount"].pct_change() * 100

    return monthly


def top_stores(df: pd.DataFrame, n=10):
    return df.groupby("store_name")["profit"].sum().nlargest(n)


def top_products(df: pd.DataFrame, n=10):
    return df.groupby("product_name")["sales_amount"].sum().nlargest(n)