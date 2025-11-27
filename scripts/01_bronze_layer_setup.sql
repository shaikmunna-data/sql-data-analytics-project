/*
=============================================================
 Bronze Layer Tables (Raw Data)
=============================================================

Purpose:
--------
Bronze layer stores raw CSV data with minimal structure.
No transformations are applied here.
*/

-- Switch to newly created database
USE DataWarehouseAnalytics;

PRINT '--------------------------------';
PRINT '*****Creating Bronze Tables*****';
PRINT '--------------------------------';
-- -----------------------------
-- bronze.crm_cust_info
-- -----------------------------
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL DROP TABLE bronze.crm_cust_info;
GO
CREATE TABLE bronze.crm_cust_info(
	cst_id				INT,
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		DATE
);

-- -----------------------------
-- bronze.crm_prd_info
-- -----------------------------
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL DROP TABLE bronze.crm_prd_info;
GO
CREATE TABLE bronze.crm_prd_info(
	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	DATETIME,
	prd_end_dt		DATETIME
);

-- -----------------------------
-- bronze.crm_sales_details
-- NOTE: Dates stored as INT (raw form), will convert later
-- -----------------------------
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL DROP TABLE bronze.crm_sales_details;
GO
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAR(50),
	sls_cust_id		INT,
	sls_order_dt	INT,
	sls_ship_dt		INT,
	sls_due_dt		INT,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT
);

-- -----------------------------
-- bronze.erp_cust_az12
-- -----------------------------
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL DROP TABLE bronze.erp_cust_az12;
GO
CREATE TABLE bronze.erp_cust_az12(
	cid		NVARCHAR(50),
	bdate	DATE,
	gen		NVARCHAR(50)
);

-- -----------------------------
-- bronze.erp_loc_a101
-- -----------------------------
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL DROP TABLE bronze.erp_loc_a101;
GO
	CREATE TABLE bronze.erp_loc_a101(
	cid		NVARCHAR(50),
	cntry	NVARCHAR(50)
);

-- -----------------------------
-- bronze.erp_px_cat_g1v2
-- -----------------------------
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL DROP TABLE bronze.erp_px_cat_g1v2;
GO
CREATE TABLE bronze.erp_px_cat_g1v2(
	id				NVARCHAR(50),
	cat				NVARCHAR(50),
	subcat			NVARCHAR(50),
	maintenance		NVARCHAR(50)
);

/*
=============================================================
BULK INSERT INTO Bronze Layer
=============================================================

Purpose:
--------
Load raw CSV data into the bronze tables using BULK INSERT.

NOTE:
   The file paths in the BULK INSERT section are system-specific.
   Update the paths if the CSV files are located in a different folder.

*/

PRINT '---------------------------------------------';
PRINT '*****Inserting Data Into Bronze Tables*****';
PRINT '---------------------------------------------';

--------------------------------------------------
-- Load bronze.crm_cust_info
--------------------------------------------------
PRINT '>>Truncating Table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;
PRINT '>>Inserting Data Into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\bronze\bronze.crm_cust_info.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load bronze.crm_prd_info
--------------------------------------------------
PRINT '>>Truncating Table: bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;
PRINT '>>Inserting Data Into: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\bronze\bronze.crm_prd_info.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load bronze.crm_sales_detils
--------------------------------------------------
PRINT '>>Truncating Table: bronze.crm_sales_details';
TRUNCATE TABLE bronze.crm_sales_details;
PRINT '>>Inserting Data Into: bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\bronze\bronze.crm_sales_details.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load bronze.erp_cust_az12
--------------------------------------------------
PRINT '>>Truncating Table: bronze.erp_cust_az12';
TRUNCATE TABLE bronze.erp_cust_az12;
PRINT '>>Inserting Data Into: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\bronze\bronze.erp_cust_az12.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load bronze.erp_loc_a101
--------------------------------------------------
PRINT '>>Truncating Table: bronze.erp_loc_a101';
TRUNCATE TABLE bronze.erp_loc_a101;
PRINT '>>Inserting Data Into: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\bronze\bronze.erp_loc_a101.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

--------------------------------------------------
-- Load bronze.erp_px_cat_g1v2
--------------------------------------------------
PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
PRINT '>>Inserting Data Into: bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\bronze\bronze.erp_px_cat_g1v2.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);


