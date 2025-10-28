-- QUESTION 2
-- Find the average sales amount for each product category.
-- Then compare each product to this average:
--      If the product is above the average, write "Above Average."
--      If it is below, write "Below Average."
--      If it is equal, write "Average."


WITH category_revenue AS (
SELECT
	category,
	COALESCE(AVG(O.total_amount), 0) AS avg_amount
FROM Products P
LEFT JOIN Orders O ON O.product_id = P.product_id
GROUP BY category
)

SELECT
	P.product_id,
	P.product_name,
	P.category,
	P.price,
	category_revenue.avg_amount,
	CASE
		WHEN P.price > category_revenue.avg_amount THEN 'Above Average'
		WHEN P.price < category_revenue.avg_amount THEN 'Below Average'
		ELSE 'Average'
	END as status
FROM Products P
LEFT JOIN category_revenue ON P.category = category_revenue.category;