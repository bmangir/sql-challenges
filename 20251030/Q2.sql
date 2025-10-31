-- QUESTION 2: Employee Performance Analysis
--  Find each employee's average performance score over the last two years.
--  Then, display the average employee performance by department, along with the department's overall average salary.

WITH employee_stats AS (
    SELECT
        E.emp_id,
        E.dept_id,
        ROUND(AVG(PR.performance_score), 2) AS avg_performance_last2yrs,
        E.salary
    FROM employees E
    JOIN performance_reviews PR ON PR.emp_id = E.emp_id
    WHERE PR.review_date >= CURRENT_DATE - INTERVAL '2 years'
    GROUP BY E.emp_id, E.dept_id, E.salary
)
SELECT
    D.dept_name,
    ROUND(AVG(ES.avg_performance_last2yrs), 2) AS avg_performance_last2yrs,
    ROUND(AVG(ES.salary), 2) AS avg_salary
FROM employee_stats ES
JOIN departments D ON D.dept_id = ES.dept_id
GROUP BY D.dept_name;