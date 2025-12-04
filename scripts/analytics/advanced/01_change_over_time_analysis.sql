/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - Track trends, growth, and changes in key metrics over time.
    - Perform time-series analysis and identify seasonality patterns.
    - Measure growth or decline across different time periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Sales performance over time (Year + Month)
SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date) ASC;

-- Sales performance using DATETRUNC() for month-level aggregation
SELECT 
	DATETRUNC(MONTH, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date) ASC;

-- Sales performance with formatted month labels
SELECT 
	FORMAT(order_date, 'yyy-MMM') AS order_date,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyy-MMM') 
ORDER BY FORMAT(order_date, 'yyy-MMM')  ASC;