-- QUESTION 1: Region based sales and delivery performance
-- Calculate the following metrics for each customer region:
--      Total number of orders
--      Total sales amount
--      Ratio of delivered orders (delivered_orders / total_orders)
--      Average delivery time (delivered_date - shipped_date for delivered orders)
--      Classify performance based on these ratios:
--          Delivered rate > 0.8 → 'High Delivery Success'
--          Delivered rate < 0.5 → 'Low Delivery Success'
--          Others → 'Moderate Delivery Success'

WITH order_stats AS(
	SELECT
		C.region,
		COUNT(O.order_id) as total_orders,
		COALESCE(SUM(O.total_amount), 0) as total_amount,
		SUM(CASE WHEN D.status IN ('Delivered') THEN 1 ELSE 0 END) as delivered_order_cnt,
		ROUND(AVG(CASE WHEN D.status = 'Delivered' THEN (D.delivered_date - D.shipped_date) END), 2) as avg_delivery_days
	FROM Orders O
	JOIN Deliveries D ON O.order_id = D.order_id
	JOIN Customers C ON C.customer_id = O.customer_id
	GROUP BY C.region
),
order_stats_with_ratio AS(
	SELECT
		*,
		CASE
			WHEN OS.total_orders != 0 THEN ROUND((OS.delivered_order_cnt * 1.0 / OS.total_orders), 2)
			ELSE 0
		END AS delivery_ratio

	FROM order_stats OS
)

SELECT
    OS.region,
    OS.total_orders,
    OS.delivered_order_cnt,
    OS.delivery_ratio,
    CASE
        WHEN OS.delivery_ratio > 0.8 THEN 'High Delivery Success'
        WHEN OS.delivery_ratio < 0.5 THEN 'Low Delivery Success'
        ELSE 'Moderate Delivery Success'
    END AS performance_label
FROM order_stats_with_ratio OS;