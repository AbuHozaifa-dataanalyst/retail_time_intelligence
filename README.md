# 🏪 Retail Time Intelligence Analytics Project

## 📌 Overview

This project demonstrates an **end-to-end retail analytics solution** focused on **time intelligence using SQL** and supported by **Python-based data pipelines**.

It simulates a real-world analytics environment where raw transactional data is transformed into **business insights** using:

- SQL (core analytics)
- Python (data pipeline & feature engineering)
- Data modeling (Star Schema)
- Data validation (quality checks)
- Business reporting (insights & recommendations)

---

## 🎯 Objectives

- Analyze retail sales performance over time
- Build reusable **time intelligence metrics** (MTD, YTD, rolling)
- Generate **business KPIs** (revenue, profit, growth)
- Design a **scalable analytics architecture**
- Ensure **data quality and reliability**

---

## 🧠 Key Concepts Covered

- Time Intelligence (MTD, YTD, Rolling Metrics)
- Window Functions & CTEs
- Star Schema Data Modeling
- ETL Pipeline Design
- Data Quality Validation
- Business KPI Analysis
- Analytical SQL Optimization

---

## 🏗️ Project Architecture

This project follows a **modular and production-style design**:


Raw Data → SQL Tables → Transformations → Analytics → Reports → Insights


- **SQL Layer** → Core analytics (main focus)
- **Python Layer** → Data processing & automation
- **Docs Layer** → Business + technical explanation
- **Reports Layer** → Final outputs & insights

---

## 📂 Project Structure


retail-time-intelligence/

├── src/ # Python analytics layer
├── sql/ # Core SQL scripts (MAIN FOCUS)
├── notebooks/ # Exploratory analysis
├── data/ # Raw & processed data
├── docs/ # Business + technical documentation
├── reports/ # Outputs & insights
├── dashboards/ # BI dashboards (optional)
├── tests/ # Data quality validation
├── main.py # Pipeline entry point
├── requirements.txt
└── README.md


---

## 🧾 Data Model (Star Schema)

The project uses a **Star Schema**:

- **Fact Table**
  - `fact_sales` → transactional data

- **Dimension Tables**
  - `dim_date`
  - `dim_store`
  - `dim_product`

     dim_date
        |

dim_store — fact_sales — dim_product


---

## ⚙️ How to Run the Project

### 1️⃣ Clone the repository

```bash
git clone https://github.com/AbuHozaifa-dataanlyst/retail-time-intelligence.git
cd retail-time-intelligence
2️⃣ Install dependencies (optional)
pip install -r requirements.txt
3️⃣ Run the pipeline
python main.py
4️⃣ Run SQL scripts

Execute SQL files in order:

sql/ddl/ → Create tables
sql/dml/ → Load data
sql/transformations/ → Create views
sql/analytics/ → Run analysis
📊 Key SQL Analyses
Total Sales by Day / Month
Month-to-Date (MTD) Sales
Year-to-Date (YTD) Sales
Rolling 7-day / 30-day Sales
Month-over-Month Growth
Store Performance Ranking
Product Performance Analysis
🧪 Data Quality Checks

Located in:

tests/data_quality_checks.sql

Includes:

NULL value checks
Duplicate detection
Foreign key validation
Business rule validation
📓 Notebooks (Storytelling Layer)
01_project_overview.ipynb → Business understanding
02_data_validation.ipynb → Data exploration & cleaning
03_time_analysis.ipynb → Time-based analytics
04_business_insights.ipynb → Final insights
📚 Documentation

Located in docs/:

Business Context
Data Dictionary
SQL Query Explanations
Architecture Design
Insights
📈 Key Insights
Sales peak during weekends and Q4
A small number of products drive most revenue (Pareto principle)
Certain stores consistently outperform others
Growth trends highlight seasonal patterns
💡 Business Recommendations
Increase inventory before peak seasons
Focus marketing on top-performing products
Improve underperforming store operations
Use rolling metrics for trend monitoring
📊 Reports

Located in reports/:

Query outputs (CSV & screenshots)
Executive summary
Detailed analysis
Business recommendations
🧰 Tech Stack
SQL (SQL Server / PostgreSQL)
Python (Pandas, Pathlib)
Jupyter Notebooks
Git & GitHub
Power BI / Tableau (optional)
🚀 Project Highlights
End-to-end analytics pipeline
Real-world retail use case
Modular and scalable design
Production-style data validation
Business-focused insights
📌 Future Improvements
Automate pipeline with scheduling (Airflow)
Add real-time data ingestion
Integrate cloud data warehouse (Snowflake / BigQuery)
Enhance dashboard layer
👤 Author

Abu Hozaifa
Retail Data Analyst | SQL | Python | Data Analytics
