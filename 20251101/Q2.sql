-- QUESTION 2: Cargo Preference Analysis
-- For each courier company (courier_name):
--      Total number of deliveries
--      Average delivery time (delivered_date - shipped_date)
--      Undelivered (pending or canceled) rate
--      Performance tag:
--              Reliable → Non-delivery rate < 0.2
--              Moderate → 0.2 ≤ rate ≤ 0.4
--              Low Performance → > 0.4

WITH delivery_stats AS(
	SELECT
		courier_name,
		COUNT(delivery_id) as total_shipments,
		ROUND(SUM(CASE WHEN status IN ('Pending', 'Cancelled') THEN 1 ELSE 0 END) / COUNT(delivery_id), 2) as undelivered_ratio,
		COALESCE(ROUND(AVG(delivered_date - shipped_date), 2), NULL) as avg_delivery_days
	FROM deliveries
	GROUP BY courier_name
)
SELECT
	*,
	CASE
		WHEN DS.undelivered_ratio > 0.40 THEN 'Low Performance'
		WHEN DS.undelivered_ratio < 0.20 THEN 'Reliable'
		ELSE 'Moderate'
	END as performance_label
FROM delivery_stats DS;