/* 
=============================================================
 Silver Layer Tables (Standard, Clean Data)
=============================================================
   Purpose:
     - Create TEMP (Staging) tables for raw CSV ingestion.
     - Load raw CSV data into TEMP tables using BULK INSERT.
     - Create SILVER tables (cleaned/typed dataset).
     - Transform and insert prepared data from TEMP Tables to SILVER layer.

   Notes:
     - TEMP tables (NVARCHAR) keep raw untyped CSV values.
     - SILVER tables convert to correct datatypes (INT, DATE, DATETIME).
      
 */

/*
============================================================================================
   Create Temporary (Silver Intermediate) Tables
============================================================================================ 
*/
-- Switch to newly created database
USE DataWarehouseAnalytics;

PRINT '--------------------------------';
PRINT '*****Creating Temp Tables*****';
PRINT '--------------------------------';
--------------------------------------------------
-- Temp table: crm_cust_info  
--------------------------------------------------
IF OBJECT_ID('tempdb..#crm_cust_info', 'U') IS NOT NULL DROP TABLE #crm_cust_info;
GO
CREATE TABLE #crm_cust_info(
    cst_id                NVARCHAR(50),
    cst_key               NVARCHAR(50),
    cst_firstname         NVARCHAR(50),
    cst_lastname          NVARCHAR(50),
    cst_marital_status    NVARCHAR(50),
    cst_gndr              NVARCHAR(50),
    cst_create_date       NVARCHAR(50)
);


--------------------------------------------------
-- Temp table: crm_prd_info 
--------------------------------------------------
IF OBJECT_ID('tempdb..#crm_prd_info', 'U') IS NOT NULL DROP TABLE #crm_prd_info;
GO
CREATE TABLE #crm_prd_info(
    prd_id        NVARCHAR(50),
    cat_id        NVARCHAR(50),
    prd_key       NVARCHAR(50),
    prd_nm        NVARCHAR(50),
    prd_cost      NVARCHAR(50),
    prd_line      NVARCHAR(50),
    prd_start_dt  NVARCHAR(50),
    prd_end_dt    NVARCHAR(50)
);


--------------------------------------------------
-- Temp table: crm_sales_details
--------------------------------------------------
IF OBJECT_ID('tempdb..#crm_sales_details', 'U') IS NOT NULL DROP TABLE #crm_sales_details;
GO
CREATE TABLE #crm_sales_details(
    sls_ord_num   NVARCHAR(50),
    sls_prd_key   NVARCHAR(50),
    sls_cust_id   NVARCHAR(50),
    sls_order_dt  NVARCHAR(50),
    sls_ship_dt   NVARCHAR(50),
    sls_due_dt    NVARCHAR(50),
    sls_sales     NVARCHAR(50),
    sls_quantity  NVARCHAR(50),
    sls_price     NVARCHAR(50)
);


--------------------------------------------------
-- Temp table: erp_cust_az12
--------------------------------------------------
IF OBJECT_ID('tempdb..#erp_cust_az12', 'U') IS NOT NULL DROP TABLE #erp_cust_az12;
GO
CREATE TABLE #erp_cust_az12(
    cid      NVARCHAR(50),
    bdate    NVARCHAR(50),
    gen      NVARCHAR(50)
);


--------------------------------------------------
-- Temp table: erp_loc_a101
--------------------------------------------------
IF OBJECT_ID('tempdb..#erp_loc_a101', 'U') IS NOT NULL DROP TABLE #erp_loc_a101;
GO
CREATE TABLE #erp_loc_a101(
    cid      NVARCHAR(50),
    cntry    NVARCHAR(50)
);


--------------------------------------------------
-- Temp table: erp_px_cat_g1v2
--------------------------------------------------
IF OBJECT_ID('tempdb..#erp_px_cat_g1v2', 'U') IS NOT NULL DROP TABLE #erp_px_cat_g1v2;
GO
CREATE TABLE #erp_px_cat_g1v2(
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

/* 
============================================================================================
 Load CSV Data into Temp Tables (BULK INSERT)
============================================================================================ 
NOTE:
   The file paths in the BULK INSERT section are system-specific.
   Update the paths if the CSV files are located in a different folder.
*/

PRINT '---------------------------------------------';
PRINT '*****Inserting Data Into Temp Tables*****';
PRINT '---------------------------------------------';
--------------------------------------------------
-- Load #crm_cust_info
--------------------------------------------------
TRUNCATE TABLE #crm_cust_info;
BULK INSERT #crm_cust_info
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\silver\silver.crm_cust_info.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--------------------------------------------------
-- Load #crm_prd_info
--------------------------------------------------
TRUNCATE TABLE #crm_prd_info;
BULK INSERT #crm_prd_info
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\silver\silver.crm_prd_info.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--------------------------------------------------
-- Load #crm_sales_details
--------------------------------------------------
TRUNCATE TABLE #crm_sales_details;
BULK INSERT #crm_sales_details
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\silver\silver.crm_sales_details.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--------------------------------------------------
-- Load #erp_cust_az12
--------------------------------------------------
TRUNCATE TABLE #erp_cust_az12;
BULK INSERT #erp_cust_az12
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\silver\silver.erp_cust_az12.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--------------------------------------------------
-- Load #erp_loc_a101
--------------------------------------------------
TRUNCATE TABLE #erp_loc_a101;
BULK INSERT #erp_loc_a101
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\silver\silver.erp_loc_a101.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--------------------------------------------------
-- Load #erp_px_cat_g1v2
--------------------------------------------------
TRUNCATE TABLE #erp_px_cat_g1v2;
BULK INSERT #erp_px_cat_g1v2
FROM 'C:\Users\shaik\Desktop\SQL Files\sql-data-analytics-project\datasets\csv-files\silver\silver.erp_px_cat_g1v2.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

/*
=============================================================
Create Silver Layer (Cleaned Data)
=============================================================

Purpose:
--------
Silver layer contains cleaned, standardized data.
Correct types (INT, DATE, DATETIME) and audit columns added.
*/

PRINT '--------------------------------';
PRINT '*****Creating Silver Tables*****';
PRINT '--------------------------------';
-- -----------------------------
-- silver.crm_cust_info
-- -----------------------------
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL DROP TABLE silver.crm_cust_info;
GO
CREATE TABLE silver.crm_cust_info(
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);


-- -----------------------------
-- silver.crm_prd_info
-- -----------------------------
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL DROP TABLE silver.crm_prd_info;
GO
CREATE TABLE silver.crm_prd_info(
    prd_id        INT,
    cat_id        NVARCHAR(50),
    prd_key       NVARCHAR(50),
    prd_nm        NVARCHAR(50),
    prd_cost      INT,
    prd_line      NVARCHAR(50),
    prd_start_dt  DATETIME,
    prd_end_dt    DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);


-- -----------------------------
-- silver.crm_sales_details
-- -----------------------------
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL DROP TABLE silver.crm_sales_details;
GO
CREATE TABLE silver.crm_sales_details(
    sls_ord_num   NVARCHAR(50),
    sls_prd_key   NVARCHAR(50),
    sls_cust_id   INT,
    sls_order_dt  DATE,
    sls_ship_dt   DATE,
    sls_due_dt    DATE,
    sls_sales     INT,
    sls_quantity  INT,
    sls_price     INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- -----------------------------
-- silver.erp_cust_a212
-- -----------------------------
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL DROP TABLE silver.erp_cust_az12;
GO
CREATE TABLE silver.erp_cust_az12(
cid                 NVARCHAR(50),
bdate               DATE,
gen                 NVARCHAR(50),
dwh_create_date     DATETIME2 DEFAULT GETDATE()
);

-- -----------------------------
-- silver.erp_loc_a101
-- -----------------------------
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL DROP TABLE silver.erp_loc_a101;
GO
CREATE TABLE silver.erp_loc_a101(
cid                 NVARCHAR(50),
cntry               NVARCHAR(50),
dwh_create_date     DATETIME2 DEFAULT GETDATE()
);

-- -----------------------------
-- silver.erp_px_cat_g1v2
-- -----------------------------
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL DROP TABLE silver.erp_px_cat_g1v2;
GO
CREATE TABLE silver.erp_px_cat_g1v2(
id                  NVARCHAR(50),
cat                 NVARCHAR(50),
subcat              NVARCHAR(50),
maintenance         NVARCHAR(50),
dwh_create_date     DATETIME2 DEFAULT GETDATE()
);


/* 
============================================================================================
Load Data from TEMP Tables  ? SILVER Tables(Typed Insert)
============================================================================================ 
*/
PRINT '--------------------------------------------------------';
PRINT '*****Inserting Temp Tables Data Into Silver Tables*****';
PRINT '--------------------------------------------------------';
-------------------------------------------------------
-- Insert #crm_cust_info Data Into silver.crm_cust_info 
-------------------------------------------------------
PRINT '>>Truncating Table: silver.crm_cust_info';
TRUNCATE TABLE silver.crm_cust_info;
PRINT '>>Inserting Data Into: silver.crm_cust_info';
INSERT INTO silver.crm_cust_info
(cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date)
SELECT 
    cst_id,          
    cst_key,    
    cst_firstname,     
    cst_lastname,
    cst_marital_status,
    cst_gndr,  
    cst_create_date
FROM #crm_cust_info;

-------------------------------------------------------
-- Insert #crm_prd_info Data Into silver.crm_prd_info
-------------------------------------------------------
PRINT '>>Truncating Table: silver.crm_prd_info';
TRUNCATE TABLE silver.crm_prd_info;
PRINT '>>Inserting Data Into: silver.crm_prd_info';
INSERT INTO silver.crm_prd_info
(prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
SELECT 
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
FROM #crm_prd_info;

----------------------------------------------------------------
-- Insert #crm_sales_details Data Into silver.crm_sales_details
----------------------------------------------------------------
PRINT '>>Truncating Table: silver.crm_sales_details';
TRUNCATE TABLE silver.crm_sales_details;
PRINT '>>Inserting Data Into: silver.crm_sales_details';
INSERT INTO silver.crm_sales_details
(sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price)
SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM #crm_sales_details;

-------------------------------------------------------
-- Insert #erp_cust_az12 Into silver.erp_cust_az12
-------------------------------------------------------
PRINT '>>Truncating Table: silver.erp_cust_az12';
TRUNCATE TABLE silver.erp_cust_az12;
PRINT '>>Inserting Data Into: silver.erp_cust_az12';
INSERT INTO silver.erp_cust_az12
(cid, bdate, gen)
SELECT 
    cid,
    bdate,
    gen
FROM #erp_cust_az12;

-------------------------------------------------------
-- Insert #erp_loc_a101 Data Into silver.erp_loc_a101
-------------------------------------------------------
PRINT '>>Truncating Table: silver.erp_loc_a101';
TRUNCATE TABLE silver.erp_loc_a101;
PRINT '>>Inserting Data Into: silver.erp_loc_a101';
INSERT INTO silver.erp_loc_a101
(cid, cntry)
SELECT 
    cid,
    cntry
FROM #erp_loc_a101;

------------------------------------------------------------
-- Insert #erp_px_cat_g1v2 Data Into silver.erp_px_cat_g1v2
------------------------------------------------------------
PRINT '>>Truncating Table: silver.erp_px_cat_g1v2';
TRUNCATE TABLE silver.erp_px_cat_g1v2;
PRINT '>>Inserting Data Into: silver.erp_px_cat_g1v2';
INSERT INTO silver.erp_px_cat_g1v2
(id, cat, subcat, maintenance)
SELECT 
    id,
    cat,
    subcat,
    maintenance 
FROM #erp_px_cat_g1v2;