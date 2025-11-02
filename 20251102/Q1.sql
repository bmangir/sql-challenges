-- QUESTION 1: Cargo Shipments Analysis
-- For each courier company (courier_name):
--  Total number of delivered shipments
--  Average delivery time (days)
--  Delivery rate (delivered / total)
--  Number of deliveries in the last 90 days
--  Average delivery time by month and difference from the previous month (month_over_month_diff)
--  Performance score = performance_score = (delivery_rate * 100) - (avg_delivery_days * 2)
--  Performance ranking

-- CTEs to structure the query
WITH base AS (
    SELECT
        courier_name,
        delivery_id,
        status,
        shipped_date,
        delivered_date
    FROM Deliveries
    WHERE shipped_date IS NOT NULL
),
delivery_stats AS (
    SELECT
        courier_name,
        COUNT(delivery_id) AS total_shipments_cnt,
        SUM(CASE WHEN status IN ('Delivered', 'Returned') THEN 1 ELSE 0 END) AS delivered_shipments_cnt,
        AVG(delivered_date - shipped_date) AS avg_delivery_days,
        SUM(CASE WHEN delivered_date >= CURRENT_DATE - INTERVAL '90 days' AND status IN ('Delivered', 'Returned') THEN 1 ELSE 0 END) AS last90_days_delivery_cnt
    FROM base
    GROUP BY courier_name
),
delivery_performance AS (
    SELECT
        courier_name,
        total_shipments_cnt,
        delivered_shipments_cnt,
        last90_days_delivery_cnt,
        ROUND(delivered_shipments_cnt * 1.0 / NULLIF(total_shipments_cnt, 0), 2) AS delivery_rate,
        CASE
            WHEN total_shipments_cnt = 0 THEN 0.00
            ELSE
                ((ROUND(delivered_shipments_cnt * 1.0 / NULLIF(total_shipments_cnt, 0), 2) * 100)
                 - (COALESCE(avg_delivery_days, 0) * 2))
        END AS performance_score
    FROM delivery_stats
),
monthly_stats AS (
    SELECT
        courier_name,
        DATE_TRUNC('month', delivered_date) AS month,
        ROUND(AVG(delivered_date - shipped_date), 2) AS avg_delivery_time_by_month
    FROM base
    WHERE delivered_date IS NOT NULL
    GROUP BY courier_name, DATE_TRUNC('month', delivered_date)
)

-- Month performance
SELECT
    courier_name,
    month,
    avg_delivery_time_by_month,
    LAG(avg_delivery_time_by_month, 1) OVER(PARTITION BY courier_name ORDER BY month) AS prev_month_avg,
    (avg_delivery_time_by_month - LAG(avg_delivery_time_by_month, 1) OVER(PARTITION BY courier_name ORDER BY month)) AS change_vs_prev_month
FROM monthly_stats
ORDER BY courier_name, month;

-- Performance analysis
SELECT
    courier_name,
    total_shipments_cnt,
    delivered_shipments_cnt,
    last90_days_delivery_cnt,
    delivery_rate,
    ROUND(performance_score, 2) AS performance_score,
    RANK() OVER(ORDER BY performance_score DESC) AS performance_rnk
FROM delivery_performance
ORDER BY performance_score DESC;

-- You need to run the two final SELECT statements separately to get the monthly performance and overall performance analysis.