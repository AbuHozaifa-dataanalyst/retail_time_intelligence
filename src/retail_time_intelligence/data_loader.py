"""
data_loader.py

Purpose:
Load raw CSV data using pathlib (portable + clean).
"""

import pandas as pd
from pathlib import Path

# ---------------------------------
# Base path (works in scripts & notebooks)
# ---------------------------------
try:
    BASE_DIR = Path(__file__).resolve().parents[2]
except NameError:
    BASE_DIR = Path.cwd().parent

RAW_PATH = BASE_DIR / "data" / "raw"


def load_csv(file_path: Path) -> pd.DataFrame:
    try:
        df = pd.read_csv(file_path, encoding="latin1")
        print(f"✅ Loaded: {file_path.name}")
        return df
    except Exception as e:
        print(f"❌ Error loading {file_path.name}: {e}")
        return None


def load_all_data() -> dict:
    return {
        "sales": load_csv(RAW_PATH / "fact_sales.csv"),
        "date": load_csv(RAW_PATH / "dim_date.csv"),
        "store": load_csv(RAW_PATH / "dim_store.csv"),
        "product": load_csv(RAW_PATH / "dim_product.csv"),
    }