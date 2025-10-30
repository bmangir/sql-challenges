# ABOUT
This SQL script creates two tables: `customers` and `transactions`. The `customers` table stores information about customers, while the `transactions` table records various financial transactions associated with these customers. Sample data is inserted into both tables to facilitate testing and demonstration of SQL queries.

# TABLE CREATION AND DATA INSERTS
```
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS transactions;
```
```
-- Customers Table
CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
join_date DATE
);

INSERT INTO customers (customer_name, city, join_date) VALUES
('Ali Yılmaz', 'Ankara', '2022-01-15'),
('Ayşe Demir', 'İstanbul', '2023-03-10'),
('Mehmet Kaya', 'İzmir', '2023-07-01'),
('Elif Çetin', 'Bursa', '2024-01-05'),
('Burak Arslan', 'Ankara', '2024-05-12');
```
```

-- Transactions Table
CREATE TABLE transactions (
transaction_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(customer_id),
amount DECIMAL(10,2),
transaction_type VARCHAR(20),  -- 'deposit', 'withdrawal', 'payment', 'transfer'
transaction_date DATE
);

INSERT INTO transactions (customer_id, amount, transaction_type, transaction_date) VALUES
(1, 1200, 'deposit', '2024-10-01'),
(1, 200, 'withdrawal', '2024-10-05'),
(1, 400, 'payment', '2024-10-12'),
(1, 800, 'deposit', '2024-11-01'),
(2, 1500, 'deposit', '2024-10-03'),
(2, 300, 'payment', '2024-10-10'),
(2, 400, 'transfer', '2024-10-20'),
(3, 2000, 'deposit', '2024-09-25'),
(3, 100, 'withdrawal', '2024-10-15'),
(3, 700, 'payment', '2024-10-22'),
(4, 900, 'deposit', '2024-10-02'),
(4, 500, 'payment', '2024-10-05'),
(4, 400, 'withdrawal', '2024-10-10'),
(5, 1800, 'deposit', '2024-10-08'),
(5, 300, 'withdrawal', '2024-10-12'),
(5, 200, 'transfer', '2024-10-15'),
(5, 700, 'deposit', '2024-11-01'),
(1, 1500, 'deposit', '2025-08-20'),
(2, 350, 'withdrawal', '2025-08-23'),
(3, 550, 'payment', '2025-08-26'),
(4, 950, 'deposit', '2025-08-30'),
(5, 120, 'transfer', '2025-09-02'),
(1, 420, 'payment', '2025-09-05'),
(2, 800, 'deposit', '2025-09-08'),
(3, 220, 'withdrawal', '2025-09-11'),
(4, 630, 'payment', '2025-09-15'),
(5, 1100, 'deposit', '2025-09-18'),
(1, 280, 'transfer', '2025-09-22'),
(2, 510, 'payment', '2025-09-25'),
(3, 1750, 'deposit', '2025-09-28'),
(4, 150, 'withdrawal', '2025-10-02'),
(5, 660, 'payment', '2025-10-05'),
(1, 750, 'deposit', '2025-10-10'),
(2, 390, 'withdrawal', '2025-10-14'),
(3, 920, 'transfer', '2025-10-19'),
(4, 1300, 'deposit', '2025-10-24'),
(5, 480, 'payment', '2025-10-30');
```