-- QUESTION 2: Spend Analysis Based on Item Category
-- Calculate the total spend (category_total_spend) and
--      average spend per player (avg_spend_per_player) for each item category.
-- Find the categories whose total spend is above the overall average in that category and rank them from highest to lowest.

WITH player_cat_spend AS (
    SELECT
        item_category,
        player_id,
        SUM(price) AS player_spend
    FROM in_game_purchases
    GROUP BY item_category, player_id
),
cat_based_spend AS (
    SELECT
        item_category,
        SUM(player_spend)         AS total_cat_spend,
        ROUND(AVG(player_spend),2) AS avg_spend_per_player
    FROM player_cat_spend
    GROUP BY item_category
),
cat_stats AS (
    SELECT ROUND(AVG(total_cat_spend),2) AS avg_total_cat_spend
    FROM cat_based_spend
)
SELECT
    cbs.item_category,
    cbs.total_cat_spend,
    cbs.avg_spend_per_player,
    CASE
        WHEN cbs.total_cat_spend > cs.avg_total_cat_spend THEN 'Above Average'
        WHEN cbs.total_cat_spend < cs.avg_total_cat_spend THEN 'Below Average'
        ELSE 'Average'
    END AS category_label
FROM cat_based_spend cbs
CROSS JOIN cat_stats cs
ORDER BY cbs.total_cat_spend DESC;
