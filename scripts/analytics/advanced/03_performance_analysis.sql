/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses the previous row's value.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

-- Year-over-year product performance analysis
/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */
-- Comparing:
--   1. Current year sales vs product's average sales
--   2. Current year sales vs previous year (YoY)
WITH yearly_product_sales AS (
SELECT 
	YEAR(order_date) AS order_date,
	dp.product_name,
	SUM(fs.sales_amount) AS current_sales
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
	ON fs.product_key = dp.product_key
WHERE order_date IS NOT NULL
GROUP BY 
	YEAR(order_date),
	dp.product_name
)
SELECT 
	order_date,
	product_name,
	current_sales,
	   -- Average Sales per Product (overall)
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	   -- Difference from avg
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
	CASE
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
		ELSE 'Avg'
	END AS avg_change,
	    -- Previous Year Sales
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_date) AS py_sales,
	  -- Difference from previous year
	current_sales - 	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_date) AS diff_py,
	CASE 
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_date) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_date) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS py_change
FROM yearly_product_sales
ORDER BY product_name ASC, order_date ASC
;