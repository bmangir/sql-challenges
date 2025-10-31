-- QUESTION 1: Course Popularity Analysis
-- For each category, in the last 360 days: (The dataset is small, to match the date it is 360 not 60 or 90 etc.)
--      How many unique users have enrolled in at least one course?
--      How many courses have been completed?
--      What is the average course rating?

SELECT
	C.category,
	COUNT(DISTINCT E.user_id) AS active_user_cnt,
	SUM(CASE WHEN E.completion_date IS NOT NULL THEN 1 ELSE 0 END) AS completed_course_cnt,
	ROUND(COALESCE(AVG(CR.rating), 0), 2) AS avg_rating
FROM courses C
LEFT JOIN enrollments E ON E.course_id = C.course_id
LEFT JOIN course_reviews CR ON CR.course_id = C.course_id
WHERE E.enroll_date >= CURRENT_DATE - INTERVAL '360 days'
GROUP BY C.category
ORDER BY C.category;
