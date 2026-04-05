# Retail Time Intelligence SQL Portfolio

## Project Overview
This project demonstrates advanced **Retail Time Intelligence** using SQL. It simulates a real-world retail business operating multiple stores across different regions and selling multiple products. 

The goal is to perform **time-based analytics**, including MTD, YTD, MoM, YoY, rolling aggregates, same-store comparisons, and holiday/fiscal analysis — all essential for a retail analyst portfolio.

---

## Dataset
The project uses a **star schema** with the following tables:

| Table Name   | Description |
|--------------|-------------|
| `dim_date`   | Calendar table with daily date info, fiscal periods, holidays, weekends |
| `dim_store`  | Store dimension with region, city, and store type |
| `dim_product`| Product dimension with category, sub-category, brand, launch date |
| `fact_sales` | Fact table with daily sales, quantity, cost, discount, and calculated sales amount |

**CSV files** are stored in the `data/` folder.

---

## Folder Structure

retail-time-intelligence-sql/
│
├── data/ # CSV files
│ ├── dim_date.csv
│ ├── dim_store.csv
│ ├── dim_product.csv
│ └── fact_sales.csv
│
├── sql/ # SQL scripts
│ ├── 01_create_tables.sql
│ ├── 02_load_data.sql
│ ├── 03_time_intelligence_queries.sql
│ └── 04_cte_window_queries.sql
│
├── docs/ # Documentation
│ ├── business_context.md
│ ├── data_dictionary.md
│ └── sql_queries_documentation.md
│
├── README.md
└── LICENSE



---

## SQL Scripts

1. **01_create_tables.sql** – Creates all tables (fact + dimensions) with primary & foreign keys.  
2. **02_load_data.sql** – Loads CSV files into the SQL database.  
3. **03_time_intelligence_queries.sql** – Contains 25 advanced time intelligence queries.  
4. **04_cte_window_queries.sql** – Additional queries demonstrating CTEs, window functions, and rankings.  

---

## How to Run

1. Create a new database in SQL Server (or PostgreSQL/MySQL).  
2. Open `01_create_tables.sql` and run it to create tables.  
3. Open `02_load_data.sql` and update CSV paths to match your local folder.  
4. Run `02_load_data.sql` to load the dataset.  
5. Explore queries in `03_time_intelligence_queries.sql` for advanced time intelligence insights.

---

## Key Time Intelligence Metrics

- Daily, Weekly, Monthly, Quarterly, YTD, MTD, QTD sales  
- Rolling 7, 30, and 90-day aggregates  
- MoM & YoY growth  
- Same-store sales comparison  
- Holiday vs Non-holiday analysis  
- Fiscal calendar performance  
- Top products/stores analysis  

---

## Notes

- Designed for **SQL Server**, minor changes may be needed for PostgreSQL/MySQL.  
- Perfect for demonstrating retail analytics skills in a portfolio.  
- Includes business assumptions and edge cases for realistic analysis.  


{\rtf1}