/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - Rank items (products, customers, etc.) based on performance metrics.
    - Identify top performers and lowest performers.

SQL Functions Used:
    - Window Functions: RANK(), DENSE_RANK(), ROW_NUMBER()
    - TOP
    - GROUP BY
    - ORDER BY
===============================================================================
*/
-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT TOP 5
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT 
* 
FROM(
SELECT 
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue,
    RANK() OVER(ORDER BY SUM(fs.sales_amount) DESC) AS rank_products
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_name
) AS ranked_products 
WHERE rank_products <= 5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    dm.customer_key,
    dm.first_name,
    dm.last_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_customers AS dm
    ON fs.customer_key = dm.customer_key
GROUP BY 
    dm.customer_key,
    dm.first_name,
    dm.last_name
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
    dc.customer_key,
    dc.first_name,
    dc.last_name,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_customers AS dc
    ON fs.customer_key = dc.customer_key
GROUP BY 
    dc.customer_key,
    dc.first_name,
    dc.last_name
ORDER BY total_orders ;
