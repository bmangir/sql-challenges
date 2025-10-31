-- QUESTION 1: Department Performance Analysis
-- List the average salary of employees in each department,
--      the highest salary,
--      and the percentage of employees in the department with a performance rating of 7 or higher.

WITH employee_performance AS (
    SELECT emp_id, performance_score
    FROM (
        SELECT emp_id, performance_score,
               ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY review_date DESC) rn
        FROM performance_reviews
    ) t
    WHERE rn = 1
)

SELECT
    D.dept_name,
    ROUND(AVG(E.salary), 2) AS avg_salary,
    MAX(E.salary) AS max_salary,
    ROUND(
        COALESCE(SUM(CASE WHEN EP.performance_score >= 7 THEN 1 ELSE 0 END) * 1.0 / COUNT(E.emp_id), 0),
        2
    ) AS high_performer_ratio
FROM employees E
JOIN departments D ON D.dept_id = E.dept_id
LEFT JOIN employee_performance EP ON EP.emp_id = E.emp_id
GROUP BY D.dept_name;