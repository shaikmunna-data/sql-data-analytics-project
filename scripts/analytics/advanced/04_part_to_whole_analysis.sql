/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To understand the contribution of each segment (category/country)
      to the overall business performance.
    - Helps identify major revenue drivers.
    - Useful for strategic planning and resource allocation.

SQL Functions Used:
    - SUM(), ROUND(): Aggregate and mathematical operations
    - Window Functions: SUM() OVER() for computing overall totals
===============================================================================
*/
---------------------------------
-- 🔹 Category Contribution
---------------------------------
WITH category_sales AS(
SELECT
	dp.category,
	SUM(fs.sales_amount) AS total_sales
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
	ON fs.product_key = dp.product_key
GROUP BY dp.category
)
SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND(CAST(total_sales AS FLOAT) / SUM(total_sales) OVER() * 100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;

---------------------------------
-- 🔹 Category Contribution
---------------------------------
WITH country_sales AS(
SELECT
	dc.country,
	SUM(fs.sales_amount) AS total_sales
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_customers AS dc
	ON fs.customer_key = dc.customer_key
GROUP BY dc.country
)
SELECT
	country,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND(CAST(total_sales AS FLOAT) / SUM(total_sales) OVER() * 100, 2), '%') AS percentage_of_total
FROM country_sales
ORDER BY total_sales DESC;
