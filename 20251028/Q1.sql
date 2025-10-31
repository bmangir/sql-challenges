-- QUESTION 1: Doctor Revenue Performance
-- Calculate each doctor's total billing revenue, outstanding billing amount, and overall revenue ratio (paid/total).
-- Additionally,
--      if the paid revenue ratio is above 70%, classify it as "Reliable,"
--      if between 50% and 70%, as "Moderate,"
--      if below 50%, as "Low Collection."

WITH doctor_bill_stats AS(
	SELECT
		D.doctor_id,
		SUM(B.total_amount) as total_billing,
		SUM(CASE WHEN B.paid THEN B.total_amount ELSE 0 END) as paid_billing,
		SUM(CASE WHEN B.paid = false THEN B.total_amount ELSE 0 END) as outstanding_billing
	FROM doctors D
	JOIN appointments A ON D.doctor_id = A.doctor_id
	JOIN bills B ON A.appointment_id = B.appointment_id
	GROUP BY D.doctor_id
),
doctor_revenue_ratios AS(
	SELECT
		doctor_id,
		ROUND(COALESCE(paid_billing/total_billing, 0), 2) as revenue_ratio
	FROM doctor_bill_stats
)

SELECT
	DBS.doctor_id,
	DBS.total_billing,
	DBS.paid_billing,
	DBS.outstanding_billing,
	DRR.revenue_ratio,
	CASE
		WHEN DRR.revenue_ratio > 0.7 THEN 'Reliable'
		WHEN DRR.revenue_ratio < 0.5 THEN 'Low Collection'
		ELSE 'Moderate'
	END as doctor_performance
FROM doctor_bill_stats DBS
INNER JOIN doctor_revenue_ratios DRR ON DBS.doctor_id = DRR.doctor_id;