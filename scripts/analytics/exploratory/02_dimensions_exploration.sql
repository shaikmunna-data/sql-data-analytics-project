/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
-- Unique list of customer countries
SELECT DISTINCT 
    country
FROM gold.dim_customers;

-- Unique list of customer genders
SELECT DISTINCT 
    gender
FROM gold.dim_customers;

-- Unique list of customer marital statuses
SELECT DISTINCT 
    marital_status
FROM gold.dim_customers;

-- Unique list of product lines
SELECT DISTINCT 
    product_line
FROM gold.dim_products;

-- Unique list of categories, subcategories, and products
SELECT DISTINCT 
    category, 
    sub_category, 
    product_name
FROM gold.dim_products
ORDER BY category, sub_category, product_name;
