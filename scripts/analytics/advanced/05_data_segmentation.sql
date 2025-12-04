/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To classify data into meaningful groups for deeper insights.
    - Helps in customer segmentation, product pricing bands, and market analysis.

SQL Functions Used:
    - CASE: Builds custom segmentation rules.
    - Aggregates (SUM, COUNT)
    - Date Functions (DATEDIFF)
===============================================================================
*/

-----------------------------------------
--  Product Segmentation by Cost Range
-----------------------------------------
WITH product_segments AS(
SELECT
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'Below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM gold.dim_products
)
SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


-------------------------------------------------------
--  Customer Segmentation Based on Lifetime Spending
-------------------------------------------------------
/*
Segments:
    - VIP:     Lifespan ≥ 12 months AND spending > 5000
    - Regular: Lifespan ≥ 12 months AND spending ≤ 5000
    - New:     Lifespan < 12 months
*/

WITH customer_spending AS(
SELECT
	dc.customer_key,
	SUM(fs.sales_amount) AS total_sales,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_customers AS dc
	ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key
)
SELECT
	customer_segment,
	COUNT(customer_key) AS total_customers
FROM(
SELECT 
	customer_key,
	CASE
		WHEN life_span >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Normal'
		ELSE 'New'
	END AS customer_segment
FROM customer_spending
) t
GROUP BY customer_segment
ORDER BY total_customers DESC