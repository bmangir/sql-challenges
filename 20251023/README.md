# ABOUT
This folder contains SQL code to create and populate tables for an e-commerce platform. The tables include sellers, products, and orders, with sample data for each.

# TABLE CREATIONS AND DATA INSERTS

```
-- DROP IF EXISTS TABLES
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sellers;
```

```
-- SELLERS table
CREATE TABLE sellers (
seller_id SERIAL PRIMARY KEY,
seller_name VARCHAR(100),
join_date DATE,
region VARCHAR(50)
);

INSERT INTO sellers (seller_name, join_date, region) VALUES
('TechStore', '2021-03-10', 'Marmara'),
('HomeDecor', '2022-01-15', 'Ege'),
('GadgetWorld', '2021-11-01', 'İç Anadolu'),
('FashionPoint', '2020-06-25', 'Marmara'),
('KitchenPro', '2023-02-01', 'Akdeniz');
```

```
-- PRODUCTS table
CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
seller_id INT REFERENCES sellers(seller_id),
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);

INSERT INTO products (seller_id, product_name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 250),
(1, 'Mechanical Keyboard', 'Electronics', 900),
(2, 'Ceramic Vase', 'Home Decor', 350),
(3, 'Smart Watch', 'Electronics', 1200),
(3, 'Bluetooth Speaker', 'Electronics', 700),
(4, 'Leather Jacket', 'Fashion', 1500),
(4, 'Sneakers', 'Fashion', 950),
(5, 'Blender', 'Kitchen', 800),
(5, 'Coffee Machine', 'Kitchen', 2500);
```

```
-- ORDERS table
CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
product_id INT REFERENCES products(product_id),
customer_id INT,
order_date DATE,
quantity INT,
total_amount DECIMAL(10,2)
);

INSERT INTO orders (product_id, customer_id, order_date, quantity, total_amount) VALUES
(1, 101, '2024-12-10', 2, 500),
(1, 102, '2025-01-05', 1, 250),
(2, 103, '2025-02-18', 1, 900),
(3, 104, '2025-02-20', 3, 1050),
(3, 105, '2025-03-02', 1, 350),
(4, 106, '2025-03-10', 2, 2400),
(5, 107, '2025-03-15', 1, 700),
(6, 108, '2025-04-02', 1, 1500),
(7, 109, '2025-04-10', 2, 1900),
(8, 110, '2025-04-22', 1, 800),
(8, 111, '2025-05-01', 2, 1600),
(9, 112, '2025-05-05', 1, 2500),
(9, 113, '2025-05-12', 2, 5000);
```
