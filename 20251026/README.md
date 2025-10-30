# ABOUT
This folder contains SQL code to create and populate tables for a gaming platform. The tables include players, game sessions, and in-game purchases, with sample data for each.

# TABLE CREATION AND DATA INSERTS
```
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS game_sessions;
DROP TABLE IF EXISTS in_game_purchases;

CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

CREATE TABLE game_sessions (
    session_id SERIAL PRIMARY KEY,
    player_id INT,
    game_mode VARCHAR(30),
    duration_minutes INT,
    level_reached INT,
    session_date DATE,
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);

CREATE TABLE in_game_purchases (
    purchase_id SERIAL PRIMARY KEY,
    player_id INT,
    item_name VARCHAR(50),
    item_category VARCHAR(30),
    price DECIMAL(10,2),
    purchase_date DATE,
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);
```
```
INSERT INTO players (player_name, country, signup_date) VALUES
('Alice', 'USA', '2025-09-01'),
('Bob', 'Germany', '2025-08-20'),
('Charlie', 'USA', '2025-07-11'),
('Diana', 'Japan', '2025-06-14'),
('Ethan', 'Turkey', '2025-10-01');

INSERT INTO game_sessions (player_id, game_mode, duration_minutes, level_reached, session_date) VALUES
(1, 'Survival', 45, 8, '2025-10-25'),
(1, 'Adventure', 60, 10, '2025-10-27'),
(2, 'Survival', 30, 6, '2025-10-20'),
(2, 'Adventure', 40, 8, '2025-10-23'),
(3, 'Survival', 55, 9, '2025-10-21'),
(3, 'Adventure', 70, 11, '2025-10-28'),
(4, 'Survival', 20, 4, '2025-10-19'),
(5, 'Adventure', 80, 13, '2025-10-26'),
(5, 'Survival', 35, 7, '2025-10-24');

INSERT INTO in_game_purchases (player_id, item_name, item_category, price, purchase_date) VALUES
(1, 'Sword of Valor', 'Weapon', 14.99, '2025-10-27'),
(1, 'Healing Potion', 'Consumable', 4.99, '2025-10-27'),
(2, 'Bow of Wind', 'Weapon', 12.49, '2025-10-23'),
(3, 'Magic Staff', 'Weapon', 16.99, '2025-10-28'),
(3, 'Mana Potion', 'Consumable', 5.99, '2025-10-21'),
(4, 'Health Potion', 'Consumable', 3.99, '2025-10-19'),
(5, 'Dragon Armor', 'Armor', 19.99, '2025-10-26'),
(5, 'Shield', 'Armor', 9.99, '2025-10-24');
```