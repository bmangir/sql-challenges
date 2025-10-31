-- QUESTION 2: Patient Visit and Billing Summary
-- Find patients who have been seen by at least two different doctors in the last 30 days.
-- Include the total billed amount and the percentage paid for these patients.

WITH patient_stats AS(
	SELECT
		A.patient_id,
		COUNT(DISTINCT A.doctor_id) as diff_dr_cnt,
		COALESCE(SUM(B.total_amount), 0) as total_bill,
		SUM(CASE WHEN B.paid THEN B.total_amount ELSE 0 END) as paid_bill
	FROM appointments A
	JOIN Bills B ON B.appointment_id = A.appointment_id
	WHERE A.appointment_date >= CURRENT_DATE - INTERVAL '30 days'
	GROUP BY A.patient_id
	HAVING COUNT(DISTINCT A.doctor_id) >= 2
)

SELECT
	patient_id,
	diff_dr_cnt,
	total_bill,
	paid_bill,
	ROUND(CASE WHEN total_bill = 0 THEN 0 ELSE paid_bill / total_bill END, 2) as bill_ratio
FROM patient_stats;