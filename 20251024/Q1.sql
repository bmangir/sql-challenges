-- QUESTION 1: Player Income and Activity Ranking
-- For a player:
--      Calculate their total spending,
--      Total number of games played,
--      Average session duration,
--      Then rank the players based on their total spending and the ranking of the games they played.

WITH spend_per_player AS (
	SELECT player_id, SUM(amount) AS total_spend
	FROM transactions
	GROUP BY player_id
),
session_stats AS (
	SELECT
		player_id,
		COUNT(DISTINCT game_id) AS distinct_game_play_cnt,
		ROUND(AVG(duration_minutes), 2) AS avg_play_duration
	FROM sessions
	GROUP BY player_id
)
SELECT
	P.player_id,
	COALESCE(SP.total_spend, 0) AS total_spend,
	COALESCE(SS.distinct_game_play_cnt, 0) AS distinct_game_play_cnt,
	COALESCE(SS.avg_play_duration, 0) AS avg_play_duration,
	RANK() OVER(ORDER BY COALESCE(SP.total_spend, 0) DESC) AS rank_by_spend,
	RANK() OVER(ORDER BY COALESCE(SS.distinct_game_play_cnt, 0) DESC) AS rank_by_game_count
FROM players P
LEFT JOIN spend_per_player SP ON P.player_id = SP.player_id
LEFT JOIN session_stats SS ON P.player_id = SS.player_id
ORDER BY rank_by_spend;


