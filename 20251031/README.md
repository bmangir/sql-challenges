# ABOUT
This repository contains SQL scripts to create and populate a database for an online learning platform. The database includes tables for users, courses, enrollments, and course reviews.

# TABLE CREATION AND DATA INSERTION SCRIPTS
```
CREATE TABLE users (
user_id INT PRIMARY KEY,
user_name VARCHAR(100),
registration_date DATE
);

CREATE TABLE courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(100),
category VARCHAR(50)
);

CREATE TABLE enrollments (
enrollment_id SERIAL PRIMARY KEY,
user_id INT,
course_id INT,
enroll_date DATE,
completion_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE course_reviews (
review_id SERIAL PRIMARY KEY,
user_id INT,
course_id INT,
rating INT CHECK (rating BETWEEN 1 AND 5),
review_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```
```
INSERT INTO users VALUES
(1, 'Alice', '2024-12-01'),
(2, 'Bob', '2025-01-10'),
(3, 'Charlie', '2025-02-15'),
(4, 'Diana', '2025-03-05'),
(5, 'George', '2025-04-15'),
(6, 'Hannah', '2025-05-01');

INSERT INTO courses VALUES
(101, 'Python for Beginners', 'Programming'),
(102, 'Advanced SQL', 'Data'),
(103, 'Machine Learning', 'AI'),
(104, 'UI/UX Design', 'Design');

INSERT INTO enrollments (user_id, course_id, enroll_date, completion_date) VALUES
(1, 101, '2025-01-01', '2025-01-15'),
(1, 103, '2025-02-10', NULL),
(2, 101, '2025-02-01', '2025-02-25'),
(2, 104, '2025-03-01', NULL),
(3, 102, '2025-03-05', '2025-03-20'),
(3, 103, '2025-03-25', NULL),
(4, 104, '2025-03-10', '2025-03-25'),
(1, 104, '2025-04-01', '2025-04-15'),
(2, 102, '2025-04-10', NULL),
(3, 104, '2025-05-05', '2025-05-20'),  
(4, 101, '2025-05-15', '2025-05-30'),  
(4, 103, '2025-06-01', NULL),          
(5, 101, '2025-05-01', '2025-05-18'),
(5, 103, '2025-05-20', NULL),        
(5, 102, '2025-06-05', '2025-06-25'),
(6, 104, '2025-05-10', '2025-05-25'),
(6, 101, '2025-06-01', NULL),        
(6, 102, '2025-06-15', '2025-07-01'),
(1, 102, '2025-06-20', NULL);

INSERT INTO course_reviews (user_id, course_id, rating, review_date) VALUES
(1, 101, 5, '2025-01-16'),
(1, 103, 4, '2025-02-28'),
(2, 101, 4, '2025-02-28'),
(3, 102, 5, '2025-03-21'),
(4, 104, 3, '2025-03-27'),
(1, 104, 5, '2025-04-16'),
(3, 104, 4, '2025-05-21'),
(4, 101, 5, '2025-06-01'),
(5, 101, 4, '2025-05-19'),
(5, 102, 5, '2025-06-26'),
(6, 104, 5, '2025-05-26'),
(6, 102, 4, '2025-07-02'),
(2, 104, 3, '2025-04-05'),
(3, 103, 4, '2025-04-10'),
(5, 103, 3, '2025-06-10');
```