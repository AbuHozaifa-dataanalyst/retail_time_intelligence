/* =============================================
   02_load_data.sql
   Retail Time Intelligence Project
   Load CSV data into tables: dim_date, dim_store, dim_product, fact_sales
   Author: Abu Hozaifa
   ============================================= */

/* ==========================
   1. Load dim_date
   ========================== */
BULK INSERT dim_date
FROM "D:\GitHub\Retail_Time_Intelligence_Sql\data\dim_date.csv"
WITH (
    FIRSTROW = 2,               -- Skip header row
    FIELDTERMINATOR = ',',      -- CSV separator
    ROWTERMINATOR = '\n',
    TABLOCK
);

/* ==========================
   2. Load dim_store
   ========================== */
BULK INSERT dim_store
FROM 'C:\path_to_csv\dim_store.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

/* ==========================
   3. Load dim_product
   ========================== */
BULK INSERT dim_product
FROM 'C:\path_to_csv\dim_product.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

/* ==========================
   4. Load fact_sales
   ========================== */
BULK INSERT fact_sales
FROM 'C:\path_to_csv\fact_sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

/* ==========================
   Notes:
   - Replace 'C:\path_to_csv\' with the actual folder path where CSVs are stored.
   - Make sure SQL Server has permissions to access the folder.
   - Ensure CSV columns match the table structure exactly.
   - If CSV uses quotes around text, you can add: FIELDQUOTE = '"'
========================== */
