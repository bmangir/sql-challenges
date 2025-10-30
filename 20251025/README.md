# ABOUT
This folder contains SQL code to create and populate tables for a movie streaming platform. The tables include users, movies, watch history, and ratings, with sample data for each.

# TABLE CREATIONS AND DATA INSERTS

```
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS watch_history;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(50),
    region VARCHAR(20),
    join_date DATE
);

CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(30),
    release_year INT,
    duration INT -- minutes
);

CREATE TABLE watch_history (
    watch_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    movie_id INT REFERENCES movies(movie_id),
    watch_date DATE,
    watch_duration INT -- minutes
);

CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    movie_id INT REFERENCES movies(movie_id),
    rating DECIMAL(2,1),
    rating_date DATE
);
```

```
-- USERS
INSERT INTO users (user_name, region, join_date) VALUES
('Alice', 'NA', '2024-01-05'),
('Bob', 'EU', '2023-12-01'),
('Charlie', 'ASIA', '2024-02-10'),
('Diana', 'EU', '2024-03-20'),
('Eve', 'NA', '2024-04-15'),
('Frank', 'ASIA', '2024-05-01');

-- MOVIES
INSERT INTO movies (title, genre, release_year, duration) VALUES
('The Space Odyssey', 'Sci-Fi', 2023, 140),
('Love & Code', 'Romance', 2024, 120),
('Fast Streets', 'Action', 2022, 110),
('Puzzle Town', 'Mystery', 2023, 95),
('Dream Machine', 'Sci-Fi', 2024, 130),
('Battle Ground', 'Action', 2021, 150);

-- WATCH HISTORY
INSERT INTO watch_history (user_id, movie_id, watch_date, watch_duration) VALUES
(1, 1, '2025-10-01', 120),
(1, 5, '2025-10-02', 130),
(2, 2, '2025-10-01', 100),
(2, 3, '2025-10-03', 90),
(3, 4, '2025-10-01', 95),
(3, 5, '2025-10-04', 100),
(4, 6, '2025-10-01', 140),
(4, 1, '2025-10-03', 130),
(5, 3, '2025-10-02', 110),
(5, 5, '2025-10-04', 130),
(6, 2, '2025-10-01', 100),
(6, 6, '2025-10-03', 150);

-- RATINGS
INSERT INTO ratings (user_id, movie_id, rating, rating_date) VALUES
(1, 1, 4.5, '2025-10-02'),
(1, 5, 4.8, '2025-10-03'),
(2, 2, 3.9, '2025-10-02'),
(2, 3, 4.2, '2025-10-04'),
(3, 4, 4.0, '2025-10-03'),
(3, 5, 3.8, '2025-10-05'),
(4, 6, 4.6, '2025-10-02'),
(4, 1, 4.7, '2025-10-04'),
(5, 3, 3.5, '2025-10-03'),
(5, 5, 4.0, '2025-10-05'),
(6, 2, 4.3, '2025-10-02'),
(6, 6, 4.9, '2025-10-04');
```