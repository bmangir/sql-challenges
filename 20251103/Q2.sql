-- QUESTION 2: Courier-based income contribution nd delivery quality
-- For each courier:
--      Total number of orders carried
--      Total sales amount (total_amount in the Orders table)
--      Percentage of orders delivered (based on Delivered status)
--      Average delivery time (delivered_date - shipped_date)
--      Performance label based on these two metrics:
--          Delivery percentage > 0.85 and average delivery time < 3 → 'Top Courier'
--          Delivery percentage < 0.6 → 'Low Performer'
--          Others → 'Moderate'

-- Assuming that the courier_id in the orders table is not one-to-one related to each delivery
-- (for example, if an order contains more than one delivery like 2 parts delivery),
-- to avoid from there may be a risk of double counting in the SUM(O.total_amount).
WITH courier_stats AS(
	SELECT
		C.courier_id,
		COUNT(D.delivery_id) as total_shipments,
		COALESCE(SUM(O.total_amount), 0) as total_amount,
		SUM(CASE WHEN D.status IN ('Delivered') THEN 1 ELSE 0 END) as delivered_shipments,
		ROUND(AVG(CASE WHEN D.status = 'Delivered' THEN (D.delivered_date - D.shipped_date) END), 2) as avg_shipment_days
	FROM couriers C
	LEFT JOIN deliveries D ON C.courier_id = D.courier_id
	LEFT JOIN orders O ON O.courier_id = C.courier_id
	GROUP BY C.courier_id
),
courier_stats_with_ratios AS(
	SELECT
		*,
		CASE WHEN total_shipments != 0 THEN ROUND((delivered_shipments * 1.0 / total_shipments), 2)
			 ELSE 0
		END as delivery_ratio
	FROM courier_stats
)

SELECT
	CS.courier_id,
	C.courier_name,
	CS.total_shipments,
	CS.delivered_shipments,
	CS.total_amount,
	CS.avg_shipment_days,
	CS.delivery_ratio,
	CASE
		WHEN CS.delivery_ratio > 0.85 AND CS.avg_shipment_days < 3 THEN 'Top Courier'
		WHEN CS.delivery_ratio < 0.60 THEN 'Low Performer'
		ELSE 'Moderate'
	END as performance_label
FROM courier_stats_with_ratios CS
LEFT JOIN couriers C ON C.courier_id = CS.courier_id;