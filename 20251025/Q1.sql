-- QUESTION 1: Genre-Based Weighted Rating Comparison
-- Find the average rating for each movie genre (genre).
-- Then, classify the movie based on your viewing experience as follows:
--      "Above Average in Genre"
--      "Below Average in Genre"
--      "Equal to Average in Genre"

WITH avg_genre_rating AS(
	SELECT
		M.genre,
		ROUND(COALESCE(AVG(R.rating), 0), 2) as avg_rating
	FROM movies M
	LEFT JOIN ratings R ON M.movie_id = R.movie_id
	GROUP BY M.genre
),
movie_rating_stats AS(
	SELECT
		M.movie_id,
		ROUND(COALESCE(AVG(R.rating), 0),2) as movie_avg_rating
	FROM movies M
	LEFT JOIN ratings R ON M.movie_id = R.movie_id
	GROUP BY M.movie_id
)

SELECT
	M.movie_id,
	M.genre,
	CASE
		WHEN MRS.movie_avg_rating > AGR.avg_rating THEN 'Above Genre Average'
		WHEN MRS.movie_avg_rating < AGR.avg_rating THEN 'Below Genre Average'
		ELSE 'Equal to Genre Average'
	END as label
FROM Movies M
LEFT JOIN avg_genre_rating AGR ON AGR.genre = M.genre
LEFT JOIN movie_rating_stats MRS ON MRS.movie_id = M.movie_id;