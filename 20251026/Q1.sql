-- QUESTION 1: Player Performance Segmentation
-- For each player:
--      Calculate the average playing time (avg_session_duration) over the last 7 days
--      Average level reached (avg_level)
--      Total spend (total_spend).
--      Then label the players as follows:
--      If both average level and average time are above the average of all players → 'High Performer'
--      If only one is above → 'Moderate Performer'
--      If both are below → 'Low Performer'

WITH global_game_stat AS(
	SELECT
		ROUND(COALESCE(AVG(GS.duration_minutes), 0), 2) as avg_global_duration,
		ROUND(COALESCE(AVG(GS.level_reached), 0), 0) as avg_global_level
	FROM game_sessions GS
),
player_game_stats AS(
	SELECT
		GS.player_id,
		ROUND(COALESCE(AVG(GS.duration_minutes), 0), 2) as avg_play_duration,
		ROUND(COALESCE(AVG(GS.level_reached), 0), 0) as avg_reached_level
	FROM game_sessions GS
	WHERE GS.session_date >= CURRENT_DATE - INTERVAL '7 days'
	GROUP BY GS.player_id
),
player_purchase_stats AS(
	SELECT
		IGP.player_id,
		COALESCE(SUM(IGP.price), 0) as total_spend
	FROM in_game_purchases IGP
	WHERE IGP.purchase_date >= CURRENT_DATE - INTERVAL '7 days'
	GROUP BY IGP.player_id
)

SELECT
	P.player_id,
	P.player_name,
	PGS.avg_play_duration,
	PGS.avg_reached_level,
	PPS.total_spend,
	CASE
		WHEN PGS.avg_play_duration > GGS.avg_global_duration
			AND PGS.avg_reached_level > GGS.avg_global_level THEN 'High Performer'
		WHEN PGS.avg_play_duration > GGS.avg_global_duration
			AND PGS.avg_reached_level < GGS.avg_global_level THEN 'Moderate Performer'
		WHEN PGS.avg_play_duration < GGS.avg_global_duration
			AND PGS.avg_reached_level > GGS.avg_global_level THEN 'Moderate Performer'
		ELSE 'Low Performer'
	END as performance_label
FROM Players P
INNER JOIN player_game_stats PGS ON PGS.player_id = P.player_id
INNER JOIN player_purchase_stats PPS ON PPS.player_id = P.player_id
CROSS JOIN global_game_stat GGS;