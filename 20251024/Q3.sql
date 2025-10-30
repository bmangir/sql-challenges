-- QUESTION 3 – Most Loyal Players of the Last 7 Days
-- In the last 7 days:
--      Find the players who played the most different games and had the most sessions.
--      Calculate both the number of distinct games and the total duration.
--      First rank by number of games, then by total duration.

WITH player_activity AS (
	SELECT
		player_id,
		COUNT(DISTINCT game_id) AS distinct_game_play_cnt,
		SUM(duration_minutes) AS total_duration
	FROM sessions
	WHERE session_date >= CURRENT_DATE - INTERVAL '7 days'
	GROUP BY player_id
)
SELECT
	player_id,
	distinct_game_play_cnt,
	total_duration,
	DENSE_RANK() OVER (ORDER BY distinct_game_play_cnt DESC) AS rank_by_game_count,
	DENSE_RANK() OVER (ORDER BY total_duration DESC) AS rank_by_duration
FROM player_activity
WHERE distinct_game_play_cnt > 0
ORDER BY rank_by_game_count, rank_by_duration;

