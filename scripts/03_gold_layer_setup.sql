/*
=============================================================
Gold Layer Tables (Final Analytical Tables)
=============================================================

Purpose:
--------
Gold layer contains cleaned, conformed, analytics-ready data.
Used by BI tools & dashboards.

*/

-- Switch to newly created database
USE DataWarehouseAnalytics;


PRINT '--------------------------------';
PRINT '*****Creating Gold Tables*****';
PRINT '--------------------------------';
-- -----------------------------
-- gold.dim_customers 
-- -----------------------------
IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL DROP TABLE  gold.dim_customers;
GO
CREATE TABLE gold.dim_customers (
	customer_key    INT,
	customer_id		INT,
	customer_number NVARCHAR(50),
	first_name		NVARCHAR(50),
	last_name		NVARCHAR(50),
	country			NVARCHAR(50),
	marital_status	NVARCHAR(50),
	gender			NVARCHAR(50),
	birthdate		DATE,
	create_date		DATE
); 

-- -----------------------------
--gold.dim_products
-- -----------------------------
IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL DROP TABLE gold.dim_products;
GO
CREATE TABLE gold.dim_products(
	product_key		INT,
	product_id		INT,
	product_number	NVARCHAR(50),
	product_name	NVARCHAR(50),
	category_id		NVARCHAR(50),
	category		NVARCHAR(50),
	sub_category	NVARCHAR(50),
	maintenance		NVARCHAR(50),
	cost			INT,
	product_line	NVARCHAR(50),
	start_date		DATE
);

-- -----------------------------
--  gold.fact_sales
-- -----------------------------
IF OBJECT_ID('gold.fact_sales', 'U') IS NOT NULL DROP TABLE gold.fact_sales;
GO
CREATE TABLE gold.fact_sales(
	order_number	NVARCHAR(50),
	product_key		INT,
	customer_key	INT,
	order_date		DATE,
	shipping_date	DATE,
	due_date		DATE,
	sales_amount	INT,
	quantity		TINYINT,
	price			INT
);

/*
=============================================================
BULK INSERT INTO GOLD TABLES
=============================================================

Purpose:
--------
Load final model-ready data into the gold layer.
These CSVs are already cleansed and dimension-model ready.
NOTE:
   The file paths in the BULK INSERT section are system-specific.
   Update the paths if the CSV files are located in a different folder.
*/

PRINT '---------------------------------------------';
PRINT '*****Inserting Data Into Gold Tables*****';
PRINT '---------------------------------------------';

--------------------------------------------------
-- Load gold.dim_customers
--------------------------------------------------
PRINT '>>Truncating Table: gold.dim_customers';
TRUNCATE TABLE gold.dim_customers;
PRINT '>>Inserting Data Into:gold.dim_customers ';
BULK INSERT gold.dim_customers
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\gold\gold.dim_customers.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load gold.dim_products
--------------------------------------------------
PRINT '>>Truncating Table: gold.dim_products';
TRUNCATE TABLE gold.dim_products;
PRINT '>>Inserting Data Into: gold.dim_products ';
BULK INSERT gold.dim_products 
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\gold\gold.dim_products.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load gold.fact_sales
--------------------------------------------------
PRINT '>>Truncating Table: gold.fact_sales';
TRUNCATE TABLE gold.fact_sales;
PRINT '>>Inserting Data Into: gold.fact_sales';
BULK INSERT  gold.fact_sales
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\gold\gold.fact_sales.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);