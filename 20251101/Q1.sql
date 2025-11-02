-- QUESTION 1: Region-based sales & customer analysis
-- Generate the following metrics for each region:
--      Total Total number of customers
--      Total number of orders placed in the last 60 days
--      Total Total sales share (SUM(total_amount))
--      Average order split (AVG(total_amount))

WITH last360_days_orders AS(
	SELECT
		*
	FROM orders O
	WHERE O.order_date >= CURRENT_DATE - INTERVAL '360 days'
)

SELECT
	C.region,
	COUNT(DISTINCT LDO.customer_id) as total_customers, -- count active user (C.customer_id is meant to be num of registered users)
	COUNT(LDO.order_id) as total_orders,
	COALESCE(SUM(LDO.total_amount), 0) as total_sales,
	ROUND(COALESCE(AVG(LDO.total_amount), 0), 2) as avg_total_value
FROM Customers C
LEFT JOIN last360_days_orders LDO ON LDO.customer_id = C.customer_id
GROUP BY C.region
ORDER BY total_sales;