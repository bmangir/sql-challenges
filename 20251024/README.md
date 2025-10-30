# ABOUT
This folder contains SQL code to create and populate tables for a gaming platform. The tables include players, games, sessions, and transactions, with sample data for each.

# TABLE CREATIONS AND DATA INSERTS

```
-- DROP TABLES
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS players;
```

```
-- PLAYERS tablosu
CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(100),
    join_date DATE,
    region VARCHAR(50)
);

INSERT INTO players (player_name, join_date, region) VALUES
('Alice', '2023-01-15', 'NA'),
('Bob', '2022-11-10', 'EU'),
('Charlie', '2023-03-05', 'ASIA'),
('Diana', '2021-08-20', 'NA'),
('Eve', '2022-05-17', 'EU'),
('Frank', '2023-02-28', 'ASIA'),
('Grace', '2023-04-01', 'NA'),
('Hank', '2022-12-15', 'EU'),
('Ivy', '2023-03-25', 'ASIA'),
('Jack', '2023-01-30', 'NA');
```

```
-- GAMES tablosu
CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    game_name VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO games (game_name, genre, price) VALUES
('Space Adventure', 'Action', 50),
('Puzzle Quest', 'Puzzle', 20),
('Racing Fever', 'Racing', 40),
('Mystery Manor', 'Adventure', 30),
('Battle Royale', 'Action', 60),
('Word Wizard', 'Puzzle', 15),
('Speed Racer', 'Racing', 35),
('Dragon Realm', 'Adventure', 55),
('Galaxy Shooter', 'Action', 45),
('Maze Runner', 'Puzzle', 25);
```

```
-- SESSIONS tablosu (oyuncu oyun oturumları)
CREATE TABLE sessions (
    session_id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players(player_id),
    game_id INT REFERENCES games(game_id),
    session_date DATE,
    duration_minutes INT
);

INSERT INTO sessions (player_id, game_id, session_date, duration_minutes) VALUES
(1, 1, '2025-10-01', 120),
(1, 2, '2025-10-03', 60),
(2, 1, '2025-09-30', 90),
(2, 3, '2025-10-02', 45),
(3, 4, '2025-10-05', 80),
(3, 5, '2025-10-06', 150),
(4, 1, '2025-10-03', 60),
(4, 6, '2025-10-04', 70),
(5, 2, '2025-10-07', 30),
(5, 7, '2025-10-08', 40),
(6, 3, '2025-10-01', 100),
(6, 8, '2025-10-02', 110),
(7, 4, '2025-10-05', 55),
(7, 9, '2025-10-06', 75),
(8, 5, '2025-10-07', 60),
(8, 10, '2025-10-08', 35),
(9, 6, '2025-10-03', 90),
(9, 1, '2025-10-04', 85),
(10, 7, '2025-10-05', 45),
(10, 8, '2025-10-06', 95);
```

```
-- TRANSACTIONS tablosu (oyuncu oyun içi satın alımlar)
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players(player_id),
    game_id INT REFERENCES games(game_id),
    transaction_date DATE,
    amount DECIMAL(10,2),
    item_type VARCHAR(50)
);

INSERT INTO transactions (player_id, game_id, transaction_date, amount, item_type) VALUES
(1, 1, '2025-10-01', 5, 'Skin'),
(1, 2, '2025-10-03', 2, 'Boost'),
(2, 1, '2025-09-30', 10, 'Skin'),
(2, 3, '2025-10-02', 3, 'Coin'),
(3, 4, '2025-10-05', 4, 'Boost'),
(3, 5, '2025-10-06', 8, 'Skin'),
(4, 1, '2025-10-03', 6, 'Skin'),
(4, 6, '2025-10-04', 3, 'Boost'),
(5, 2, '2025-10-07', 1, 'Coin'),
(5, 7, '2025-10-08', 2, 'Skin'),
(6, 3, '2025-10-01', 5, 'Coin'),
(6, 8, '2025-10-02', 7, 'Skin'),
(7, 4, '2025-10-05', 2, 'Boost'),
(7, 9, '2025-10-06', 6, 'Skin'),
(8, 5, '2025-10-07', 3, 'Skin'),
(8, 10, '2025-10-08', 4, 'Coin'),
(9, 6, '2025-10-03', 5, 'Boost'),
(9, 1, '2025-10-04', 8, 'Skin'),
(10, 7, '2025-10-05', 3, 'Coin'),
(10, 8, '2025-10-06', 6, 'Skin');
```
