-- =========================
-- 01. Total Sales by Day
-- =========================
SELECT 
    d.full_date,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;

-- =========================
-- 02. Total Sales by Month
-- =========================
SELECT 
    d.year, d.month_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month_name
ORDER BY d.year, d.month;

-- =========================
-- 03. Month-to-Date (MTD) Sales
-- =========================
SELECT 
    d.full_date,
    SUM(SUM(f.sales_amount)) OVER (PARTITION BY d.year, d.month ORDER BY d.full_date) AS mtd_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date, d.year, d.month
ORDER BY d.full_date;

-- =========================
-- 04. Year-to-Date (YTD) Sales
-- =========================
SELECT 
    d.full_date,
    SUM(SUM(f.sales_amount)) OVER (PARTITION BY d.year ORDER BY d.full_date) AS ytd_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date, d.year
ORDER BY d.full_date;

-- =========================
-- 05. Week-over-Week Sales Change
-- =========================
WITH weekly_sales AS (
    SELECT
        d.year,
        d.week_number,
        SUM(f.sales_amount) AS total_weekly_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.week_number
)
SELECT 
    ws.*,
    ws.total_weekly_sales - LAG(ws.total_weekly_sales) OVER (ORDER BY ws.year, ws.week_number) AS week_over_week_change
FROM weekly_sales ws;

-- =========================
-- 06. Month-over-Month (MoM) Growth %
-- =========================
WITH monthly_sales AS (
    SELECT d.year, d.month, SUM(f.sales_amount) AS total_monthly_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month
)
SELECT 
    *,
    (total_monthly_sales - LAG(total_monthly_sales) OVER (ORDER BY year, month)) * 100.0 / 
    LAG(total_monthly_sales) OVER (ORDER BY year, month) AS mom_growth_pct
FROM monthly_sales;

-- =========================
-- 07. Year-over-Year (YoY) Growth %
-- =========================
WITH monthly_sales AS (
    SELECT d.year, d.month, SUM(f.sales_amount) AS total_monthly_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month
)
SELECT 
    ms.*,
    (ms.total_monthly_sales - prev.total_monthly_sales) * 100.0 / prev.total_monthly_sales AS yoy_growth_pct
FROM monthly_sales ms
LEFT JOIN monthly_sales prev
    ON ms.month = prev.month AND ms.year = prev.year + 1;

-- =========================
-- 08. Rolling 7-Day Sales
-- =========================
SELECT
    d.full_date,
    SUM(SUM(f.sales_amount)) OVER (ORDER BY d.full_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7d_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;

-- =========================
-- 09. Rolling 30-Day Sales
-- =========================
SELECT
    d.full_date,
    SUM(SUM(f.sales_amount)) OVER (ORDER BY d.full_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS rolling_30d_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;

-- =========================
-- 10. Same Store Sales Comparison (YoY)
-- =========================
WITH store_monthly AS (
    SELECT 
        f.store_id,
        d.year,
        d.month,
        SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY f.store_id, d.year, d.month
)
SELECT 
    curr.store_id, curr.year, curr.month, curr.total_sales,
    prev.total_sales AS prev_year_sales,
    (curr.total_sales - prev.total_sales) * 100.0 / prev.total_sales AS yoy_growth_pct
FROM store_monthly curr
LEFT JOIN store_monthly prev
    ON curr.store_id = prev.store_id AND curr.month = prev.month AND curr.year = prev.year + 1;

-- =========================
-- 11. Daily Sales for Holidays vs Non-Holidays
-- =========================
SELECT 
    d.is_holiday,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_holiday;

-- =========================
-- 12. Peak Sales by Store
-- =========================
SELECT 
    f.store_id,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
GROUP BY f.store_id
ORDER BY total_sales DESC;

-- =========================
-- 13. Product Category Sales Trends
-- =========================
SELECT 
    p.category,
    d.month,
    SUM(f.sales_amount) AS monthly_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY p.category, d.month
ORDER BY p.category, d.month;

-- =========================
-- 14. Cumulative Sales by Product
-- =========================
SELECT 
    f.product_id,
    SUM(SUM(f.sales_amount)) OVER (PARTITION BY f.product_id ORDER BY d.full_date) AS cumulative_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY f.product_id, d.full_date;

-- =========================
-- 15. Sales by Weekday
-- =========================
SELECT 
    d.day_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.day_name
ORDER BY d.day_of_week;

-- =========================
-- 16. Top 5 Products by Revenue Each Month
-- =========================
WITH monthly_product_sales AS (
    SELECT 
        d.year, d.month, f.product_id, SUM(f.sales_amount) AS total_sales,
        RANK() OVER (PARTITION BY d.year, d.month ORDER BY SUM(f.sales_amount) DESC) AS rank
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month, f.product_id
)
SELECT *
FROM monthly_product_sales
WHERE rank <= 5
ORDER BY year, month, rank;

-- =========================
-- 17. Average Daily Sales per Store
-- =========================
SELECT 
    f.store_id,
    AVG(daily_sales) AS avg_daily_sales
FROM (
    SELECT f.store_id, d.full_date, SUM(f.sales_amount) AS daily_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY f.store_id, d.full_date
) AS t
GROUP BY f.store_id;

-- =========================
-- 18. Sales Distribution by Region
-- =========================
SELECT 
    s.region,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.region;

-- =========================
-- 19. Top 3 Stores by Quarterly Sales
-- =========================
WITH quarterly_sales AS (
    SELECT 
        f.store_id, d.year, d.quarter,
        SUM(f.sales_amount) AS total_sales,
        RANK() OVER (PARTITION BY d.year, d.quarter ORDER BY SUM(f.sales_amount) DESC) AS rank
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY f.store_id, d.year, d.quarter
)
SELECT *
FROM quarterly_sales
WHERE rank <= 3
ORDER BY year, quarter, rank;

-- =========================
-- 20. Sales vs Cost Analysis
-- =========================
SELECT 
    d.full_date,
    SUM(f.sales_amount) AS total_sales,
    SUM(f.cost_amount) AS total_cost,
    SUM(f.sales_amount - f.cost_amount) AS profit
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;

-- =========================
-- 21. Average Sales per Product Category
-- =========================
SELECT 
    p.category,
    AVG(f.sales_amount) AS avg_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category;

-- =========================
-- 22. Identify Sales Spike Days
-- =========================
WITH daily_sales AS (
    SELECT d.full_date, SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.full_date
)
SELECT *
FROM daily_sales
WHERE total_sales > (SELECT AVG(total_sales)*1.5 FROM daily_sales);

-- =========================
-- 23. Cumulative Profit YTD
-- =========================
SELECT 
    d.full_date,
    SUM(SUM(f.sales_amount - f.cost_amount)) OVER (PARTITION BY d.year ORDER BY d.full_date) AS ytd_profit
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.full_date, d.year
ORDER BY d.full_date;

-- =========================
-- 24. Compare Weekend vs Weekday Sales
-- =========================
SELECT 
    d.is_weekend,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_weekend;

-- =========================
-- 25. Fiscal Quarter Performance
-- =========================
SELECT 
    d.fiscal_year, d.fiscal_quarter,
    SUM(f.sales_amount) AS total_sales,
    SUM(f.sales_amount - f.cost_amount) AS total_profit
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.fiscal_year, d.fiscal_quarter
ORDER BY d.fiscal_year, d.fiscal_quarter;

