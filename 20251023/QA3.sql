-- QUESTION 3
-- Find the customers who made the most purchases from different merchants in the last 90 days (example: count back 90 days from '2025-05-01').
-- Also return the total number of orders.

-- MY ANSWER
SELECT
	O.customer_id,
	COUNT(DISTINCT P.seller_id) as num_of_distinct_sellers,
	COUNT(O.order_id) as num_of_orders
FROM Orders O
LEFT JOIN Products P ON O.product_id = P.product_id
WHERE O.order_date >= '2025-05-01'::date - INTERVAL '90 days'
GROUP BY O.customer_id;


-- REAL ANSWER
SELECT
	O.customer_id,
	COUNT(DISTINCT P.seller_id) as num_of_distinct_sellers,
	COUNT(O.order_id) as num_of_orders
FROM Orders O
INNER JOIN Products P ON O.product_id = P.product_id
WHERE O.order_date >= '2025-05-01'::date - INTERVAL '90 days'
GROUP BY O.customer_id;



-- EXPLANATION/RESULTS
-- Both answers are correct.
-- For optimization purposes, only INNER JOIN is sufficient because orders already contain product_id.
