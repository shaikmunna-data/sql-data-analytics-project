/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/
---------------------------------------
-- 1. LIST ALL TABLES IN THE DATABASE
---------------------------------------
SELECT 
	TABLE_CATALOG,
	TABLE_SCHEMA,
	TABLE_NAME,
	TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-----------------------------------------------------------
-- 2. VIEW COLUMN DETAILS FOR A SPECIFIC TABLE
--    (Example: 'dim_customers')
-----------------------------------------------------------
SELECT 
	ORDINAL_POSITION,
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';



