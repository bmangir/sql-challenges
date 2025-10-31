-- QUESTION 1: COURIER DELIVERY PERFORMANCE

WITH courier_performance AS (
    SELECT
        courier_id,
        COUNT(*) AS total_shipments,
        SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_cnt,
        SUM(CASE WHEN status IN ('In Transit', 'Lost') THEN 1 ELSE 0 END) AS non_delivered_cnt,   -- When 'Return' status may be added later, to avoid it in 'Non-delivered status'
        ROUND(AVG(CASE
				  	WHEN status = 'Delivered' THEN (delivery_date - ship_date)
                  END), 1) AS avg_delivery_days,
        ROUND(SUM(CASE WHEN status IN ('In Transit', 'Lost') THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS undelivered_ratio
    FROM shipments
    GROUP BY courier_id
)
SELECT
    c.courier_id,
    c.courier_name,
    c.region,
    cp.delivered_cnt,
    cp.avg_delivery_days,
    cp.undelivered_ratio,
    CASE
        WHEN cp.undelivered_ratio < 0.2 THEN 'Reliable'
        WHEN cp.undelivered_ratio > 0.4 THEN 'Low Performance'
        ELSE 'Moderate'
    END AS performance_label
FROM courier_performance cp
JOIN couriers c ON c.courier_id = cp.courier_id;