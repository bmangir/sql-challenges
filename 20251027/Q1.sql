-- QUESTION 1: CUSTOMER FINANCIAL ACTIVITY ANALYSIS
-- Calculate the customer-based financial behavior score for the last 60 days.
-- Retrieve the last 60 days of transactions for each customer.
-- Calculate the following metrics:
--      Total number of transactions
--      Total transaction amount (without distinction between positive and negative)
--      Average transaction amount
--      Monthly trend → Difference between total amount of the last 2 months (e.g., October and September)
-- Calculate the Behavior_Score using these metrics:
--      Behavior_Score = (total_amount / average_amount) + (trend_difference / 100)
-- Segment the customer based on the Behavior_Score using RANK() and NTILE(3).
-- (1: High Value, 2: Medium Value, 3: Low Value)

WITH filtered_tx AS (
    SELECT
        t.*,
        DATE_TRUNC('month', t.transaction_date) AS tx_month
    FROM transactions t
    WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '60 days'
),
monthly_stats AS (
    SELECT
        customer_id,
        tx_month,
        SUM(amount) AS monthly_total
    FROM filtered_tx
    GROUP BY customer_id, tx_month
),
trend_diff AS (
    SELECT
        customer_id,
        tx_month,
        monthly_total,
        (monthly_total - LAG(monthly_total) OVER (PARTITION BY customer_id ORDER BY tx_month)) AS diff_from_prev_month
    FROM monthly_stats
),
customer_agg AS (
    SELECT
        f.customer_id,
        COUNT(*) AS total_tx,
        SUM(f.amount) AS total_amount,
        ROUND(AVG(f.amount), 2) AS avg_amount
    FROM filtered_tx f
    GROUP BY f.customer_id
),
last_trend AS (
    SELECT DISTINCT ON (customer_id)
        customer_id,
        diff_from_prev_month AS trend_diff
    FROM trend_diff
    WHERE diff_from_prev_month IS NOT NULL
    ORDER BY customer_id, tx_month DESC
)

SELECT
    c.customer_id,
    c.customer_name,
    ca.total_tx,
    ca.total_amount,
    ca.avg_amount,
    COALESCE(lt.trend_diff, 0) AS trend_diff,
    ROUND((ca.total_amount / ca.avg_amount) + (COALESCE(lt.trend_diff, 0) / 100), 2) AS behavior_score,
    RANK() OVER (ORDER BY (ca.total_amount / ca.avg_amount) + (COALESCE(lt.trend_diff, 0) / 100) DESC) AS rnk,
    NTILE(3) OVER (ORDER BY (ca.total_amount / ca.avg_amount) + (COALESCE(lt.trend_diff, 0) / 100) DESC) AS ntile_segment,
    CASE
        WHEN NTILE(3) OVER (ORDER BY (ca.total_amount / ca.avg_amount) + (COALESCE(lt.trend_diff, 0) / 100) DESC) = 1 THEN 'High Value'
        WHEN NTILE(3) OVER (ORDER BY (ca.total_amount / ca.avg_amount) + (COALESCE(lt.trend_diff, 0) / 100) DESC) = 2 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment_label
FROM customers c
JOIN customer_agg ca ON c.customer_id = ca.customer_id
LEFT JOIN last_trend lt ON c.customer_id = lt.customer_id
ORDER BY behavior_score DESC;