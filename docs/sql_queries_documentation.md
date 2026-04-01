# Retail Time Intelligence SQL Project  
## SQL Queries Documentation (25 Advanced Queries)

This document explains all SQL queries developed for advanced retail time intelligence analysis.

Each query includes:
- Purpose
- Business Insight
- SQL Code
- Sample Output

The dataset follows a star schema:
- fact_sales
- dim_date
- dim_store
- dim_product

---

## 1️⃣ Total Sales by Day

**Purpose:** Calculate total daily sales across all stores and products.

**Business Insight:** Helps identify peak sales days and daily performance trends.

```sql
SELECT d.full_date, SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;
Sample Output:

full_date	total_sales
2022-01-01	12,500.00
2022-01-02	14,300.50

## 2️⃣ Total Sales by Month
Purpose: Aggregate daily sales into monthly totals.

Business Insight: Useful for identifying seasonal patterns and monthly growth.

SELECT d.year, d.month_name, SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month_name
ORDER BY d.year, d.month;
Sample Output:

year	month_name	total_sales
2022	January	350,000.00

## 3️⃣ Month-to-Date (MTD) Sales
Purpose: Cumulative sales within the current month.

Business Insight: Tracks progress against monthly sales targets.

SELECT d.full_date,
       SUM(SUM(f.sales_amount)) OVER (PARTITION BY d.year, d.month ORDER BY d.full_date) AS mtd_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date, d.year, d.month;
Sample Output: full_date | mtd_sales

## 4️⃣ Year-to-Date (YTD) Sales
Purpose: Cumulative sales from start of year.

Business Insight: Measures annual performance progression.

SELECT d.full_date,
       SUM(SUM(f.sales_amount)) OVER (PARTITION BY d.year ORDER BY d.full_date) AS ytd_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date, d.year;
## 5️⃣ Week-over-Week Sales Change
Purpose: Compare weekly sales to previous week.

Business Insight: Detects short-term performance changes.

Columns: year | week_number | total_weekly_sales | week_over_week_change

## 6️⃣ Month-over-Month (MoM) Growth %
Purpose: Measure monthly percentage growth.

Business Insight: Evaluates month performance improvement.

Column: mom_growth_pct

## 7️⃣ Year-over-Year (YoY) Growth %
Purpose: Compare same month vs previous year.

Business Insight: Measures long-term growth trend.

Column: yoy_growth_pct

8️⃣ Rolling 7-Day Sales
Purpose: Calculate moving weekly total.

Business Insight: Smooths daily fluctuations.

Column: rolling_7d_sales

9️⃣ Rolling 30-Day Sales
Purpose: Calculate moving monthly total.

Business Insight: Detects longer-term sales trend.

🔟 Same Store Year-over-Year Sales
Purpose: Compare performance of same store across years.

Business Insight: Measures true store growth without expansion impact.

11️⃣ Sales by Store
Purpose: Total sales per store.

Business Insight: Identifies top-performing locations.

12️⃣ Sales by Product
Purpose: Total sales per product.

Business Insight: Detects best-selling products.

13️⃣ Sales by Category
Purpose: Category-level revenue breakdown.

Business Insight: Helps category managers allocate inventory.

14️⃣ Profit by Product
Purpose: Calculate total profit per product.

Business Insight: Identifies high-margin items.

15️⃣ Profit Margin %
Purpose: Compute profit percentage.

Business Insight: Determines pricing efficiency.

16️⃣ Weekend vs Weekday Sales
Purpose: Compare weekend and weekday performance.

Business Insight: Supports staffing and promotions planning.

17️⃣ Holiday vs Non-Holiday Sales
Purpose: Compare sales performance during holidays.

Business Insight: Measures promotion effectiveness.

18️⃣ Quarterly Sales
Purpose: Sales by quarter.

Business Insight: Used for executive reporting.

19️⃣ Top 5 Products per Month
Purpose: Rank products by sales.

Business Insight: Identifies seasonal bestsellers.

20️⃣ Bottom 5 Products per Month
Purpose: Identify lowest-performing products.

Business Insight: Helps in discontinuation decisions.

21️⃣ Store Ranking by Sales
Purpose: Rank stores using window functions.

Business Insight: Competitive benchmarking.

22️⃣ Daily Sales Variance
Purpose: Compare daily sales difference.

Business Insight: Detect anomalies or sudden spikes.

23️⃣ Cumulative Profit
Purpose: Running profit total over time.

Business Insight: Tracks profitability trend.

24️⃣ Average Order Value
Purpose: Calculate average sales per transaction.

Business Insight: Measures customer spending behavior.

25️⃣ Sales Contribution %
Purpose: Percentage contribution of store/product to total sales.

Business Insight: Identifies revenue concentration.

