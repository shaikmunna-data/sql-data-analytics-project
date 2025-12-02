/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - Calculate aggregated metrics (totals, averages, counts).
    - Understand overall business performance at a glance.

SQL Functions Used:
    - COUNT()
    - SUM()
    - AVG()
===============================================================================
*/
--Find the Total Sales
SELECT 
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

--Find How Many Items are Sold
SELECT 
	SUM(quantity) AS total_quantity
FROM gold.fact_sales;

--Find the Average Selling Price
SELECT 
	AVG(price) AS avg_price
FROM gold.fact_sales;

--Find the Total number of Orders
SELECT 
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

--Find the Total number of Products
SELECT
	COUNT(product_name) AS total_products
FROM gold.dim_products;

--Find the Total number of Customers
SELECT 
	COUNT(customer_key) AS total_customers
FROM gold.dim_customers;

-- Total Number of Customers Who Placed an Order
SELECT 
	COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales;

-- Summary Report of All Key Metrics
SELECT 
	'Total Sales' AS measure_name,
	SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
	'Total Quantity',
	SUM(quantity)
FROM gold.fact_sales
UNION ALL
SELECT 
	'Average Price',
	AVG(price) 
FROM gold.fact_sales
UNION ALL
SELECT
	'Total Orders',
	COUNT(DISTINCT order_number)
FROM gold.fact_sales
UNION ALL
SELECT
	'Total Products',
	COUNT(DISTINCT product_name)
FROM gold.dim_products
UNION ALL
SELECT
	'Total Customers',
	COUNT(customer_key)
FROM gold.dim_customers;
	