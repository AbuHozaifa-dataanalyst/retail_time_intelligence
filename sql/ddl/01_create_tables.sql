/* =============================================
   01_create_tables.sql
   Retail Time Intelligence Project
   Create tables for fact_sales, dim_date, dim_store, dim_product
   Author: Abu Hozaifa
   ============================================= */

/* ==========================
   1. dim_date (Calendar Table)
   ========================== */
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,        -- Format: YYYYMMDD
    full_date DATE NOT NULL,
    day INT,
    day_name VARCHAR(10),
    month INT,
    month_name VARCHAR(15),
    quarter INT,
    year INT,
    week_number INT,
    fiscal_month INT,
    fiscal_quarter INT,
    fiscal_year INT,
    is_weekend BIT,
    is_holiday BIT,
    holiday_name VARCHAR(100)
);

/* ==========================
   2. dim_store (Store Dimension)
   ========================== */
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    region VARCHAR(50),
    store_type VARCHAR(50),  -- Mall / Standalone / Online
    open_date DATE
);

/* ==========================
   3. dim_product (Product Dimension)
   ========================== */
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    brand VARCHAR(50),
    launch_date DATE
);

/* ==========================
   4. fact_sales (Fact Table)
   ========================== */
CREATE TABLE fact_sales (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,  -- optional if transaction-level data
    date_key INT NOT NULL,       -- FK to dim_date
    store_id INT NOT NULL,       -- FK to dim_store
    product_id INT NOT NULL,     -- FK to dim_product
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    sales_amount DECIMAL(12,2),
    cost_amount DECIMAL(12,2),

    CONSTRAINT FK_fact_date FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    CONSTRAINT FK_fact_store FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    CONSTRAINT FK_fact_product FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);


