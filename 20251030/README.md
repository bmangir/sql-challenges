# ABOUT
This repository contains SQL scripts to create and populate a sample database for an employee management system. The database includes tables for departments, employees, and performance reviews.

# TABLE CREATION AND DATA INSERTION SCRIPTS
```
CREATE TABLE departments (
dept_id SERIAL PRIMARY KEY,
dept_name VARCHAR(100)
);

CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
emp_name VARCHAR(100),
dept_id INT,
hire_date DATE,
salary DECIMAL(10,2),
manager_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE performance_reviews (
review_id SERIAL PRIMARY KEY,
emp_id INT,
review_date DATE,
performance_score INT CHECK (performance_score BETWEEN 1 AND 10),
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
```
```
INSERT INTO departments (dept_name) VALUES
('Engineering'), ('HR'), ('Sales'), ('Marketing');

INSERT INTO employees (emp_name, dept_id, hire_date, salary, manager_id) VALUES
('Alice', 1, '2020-01-10', 7000, NULL),
('Bob', 1, '2021-03-15', 5000, 1),
('Charlie', 1, '2022-06-01', 4500, 1),
('Diana', 2, '2019-08-25', 6000, NULL),
('Eva', 2, '2021-01-05', 4200, 4),
('Frank', 3, '2018-04-17', 6500, NULL),
('Grace', 3, '2021-09-12', 4800, 6),
('Helen', 4, '2020-02-10', 5500, NULL);

INSERT INTO performance_reviews (emp_id, review_date, performance_score) VALUES
(1, '2023-01-10', 9), (1, '2024-01-10', 8),
(2, '2023-03-01', 6), (2, '2024-03-01', 7),
(3, '2024-01-20', 5),
(4, '2023-02-15', 8), (4, '2024-02-15', 9),
(5, '2024-01-10', 6),
(6, '2023-03-10', 7), (6, '2024-03-10', 8),
(7, '2024-01-05', 5),
(8, '2024-02-01', 7);
```