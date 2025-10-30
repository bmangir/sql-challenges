-- QUESTION 2: Most Loyal Viewers
-- Find the following based on users' viewing habits:
--  User(s) who watched the most minutes in the last 7 days
--  Total number of movies watched
--  Average viewing time (per movie)

WITH user_stats AS(
	SELECT
		WH.user_id,
		COUNT(DISTINCT WH.movie_id) as movie_cnt,
		SUM(WH.watch_duration) as total_duration,
		ROUND(AVG(WH.watch_duration), 2) as avg_watching_duration
	FROM watch_history WH
	WHERE WH.watch_date >= '2025-10-04'::date - INTERVAL '7 days'  -- CURRENT_DATE is assumed to be '2025-10-04' to match the dataset
	GROUP BY WH.user_id
)

SELECT
	U.user_id,
	U.user_name,
	DENSE_RANK() OVER(ORDER BY US.movie_cnt DESC) as rnk_watched_movie_cnt,
	DENSE_RANK() OVER(ORDER BY US.total_duration DESC) as rnk_total_duration,
	DENSE_RANK() OVER(ORDER BY US.avg_watching_duration DESC) as rnk_avg_wathing_duration
FROM Users U
INNER JOIN user_stats US ON U.user_id = US.user_id;