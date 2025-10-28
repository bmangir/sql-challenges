-- QUESTION 2
-- Find the average sales amount for each product category.
-- Then compare each product to this average:
--      If the product is above the average, write "Above Average."
--      If it is below, write "Below Average."
--      If it is equal, write "Average."

-- MY ANSWER
WITH category_revenue AS (
SELECT
	category,
	AVG(O.total_amount) as avg_amount
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


-- REAL ANSWER
WITH category_revenue AS (
    SELECT
        P.category,
        AVG(O.total_amount) AS avg_sales_amount
    FROM products P
    LEFT JOIN orders O ON P.product_id = O.product_id
    GROUP BY P.category
)
SELECT
    P.product_id,
    P.product_name,
    P.category,
    P.price,
    category_revenue.avg_sales_amount,
    CASE
        WHEN P.price > category_revenue.avg_sales_amount THEN 'Above Average'
        WHEN P.price < category_revenue.avg_sales_amount THEN 'Below Average'
        ELSE 'Average'
    END AS status
FROM products P
LEFT JOIN category_revenue ON P.category = category_revenue.category;


-- EXPLANATION/RESULTS
-- The only difference is that here, AVG(O.total_amount) gives the order-based average, but you use P.price for the comparison.
-- In this case, the meaning is: how does the product's price compare to the average order amount in its category?
-- COALESCE can also be added for NULL values (e.g., products that have never received an order).