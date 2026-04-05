from retail_time_intelligence.data_loader import load_all_data
from retail_time_intelligence.transformations import (
    validate_df, clean_sales, clean_date, merge_data, create_features
)
from retail_time_intelligence.time_intelligence import calculate_mtd
from retail_time_intelligence.kpi_calculations import monthly_growth

# Load
data = load_all_data()

# Validate
for name, df in data.items():
    validate_df(df, name)

# Clean
data["sales"] = clean_sales(data["sales"])
data["date"] = clean_date(data["date"])

# Merge
df = merge_data(data)

# Features
df = create_features(df)

# Time Intelligence
df = calculate_mtd(df)

# KPIs
growth = monthly_growth(df)

print(df.head())
print(growth.head())