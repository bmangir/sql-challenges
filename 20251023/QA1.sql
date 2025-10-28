-- QUESTION 1
-- Find each seller's rank based on total sales revenue.
-- Also show the difference between each seller's sales and the previous seller (window function + lag).

-- MY ANSWER
SELECT
	P.seller_id,
	SUM(O.total_amount) as total_revenue,
	RANK() OVER (ORDER BY SUM(O.total_amount)) as rnk,
	SUM(O.total_amount) - LAG(SUM(O.total_amount), 1, 0) OVER (ORDER BY SUM(O.total_amount)) AS revenue_difference_from_previous
FROM orders O
LEFT JOIN products P ON O.product_id = P.product_id
GROUP BY P.seller_id;


-- REAL ANSWER
WITH seller_sales AS (
  SELECT
      P.seller_id,
      SUM(O.total_amount) AS total_revenue
  FROM orders O
  JOIN products P ON O.product_id = P.product_id
  GROUP BY P.seller_id
)
SELECT
    seller_id,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS rnk,
    total_revenue - LAG(total_revenue, 1, 0) OVER (ORDER BY total_revenue DESC) AS revenue_difference_from_previous
FROM seller_sales;



-- EXPLANATION/RESULTS
-- However, the aggregate function cannot be used directly in the ORDER BY SUM(O.total_amount) window function (it will give an error on some systems).
--      Instead, first calculate the sum within the CTE and then apply the window functions.
