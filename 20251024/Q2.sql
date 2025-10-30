-- QUESTION 2 – Average Purchase and Above/Below Performance by Game
-- For each game:
--      Calculate the average transaction amount.
--      Compare each transaction to this average:
--      Above Average / Below Average / Average

WITH avg_per_game AS (
	SELECT
		game_id,
		AVG(amount) AS avg_amount
	FROM transactions
	GROUP BY game_id
)
SELECT
	T.transaction_id,
	T.game_id,
	T.amount,
	CASE
		WHEN T.amount > A.avg_amount THEN 'Above Average'
		WHEN T.amount < A.avg_amount THEN 'Below Average'
		ELSE 'Average'
	END AS comparison
FROM transactions T
JOIN avg_per_game A ON T.game_id = A.game_id
ORDER BY T.game_id, T.transaction_id;
