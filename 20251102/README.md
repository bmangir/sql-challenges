# ABOUT
This SQL script sets up a simple database schema for managing customer orders and their deliveries. It includes the creation of three tables: `customers`, `orders`, and `deliveries`, along with sample data insertions.

# TABLE CREATIONS AND DATA INSERTIONS

```
DROP TABLE IF EXISTS deliveries;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    region VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10,2)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    courier_name VARCHAR(50),
    shipped_date DATE,
    delivered_date DATE,
    status VARCHAR(20)
);
```
```
INSERT INTO customers VALUES
(1, 'Marmara'), (2, 'Marmara'), (3, 'Ege'), (4, 'Ege'), (5, 'Karadeniz'),
(6, 'İç Anadolu'), (7, 'Akdeniz'), (8, 'Doğu Anadolu'), (9, 'Marmara'), (10, 'Ege');

INSERT INTO orders VALUES
(1001, 1, '2025-07-10', 150),
(1002, 2, '2025-07-18', 220),
(1003, 3, '2025-08-02', 130),
(1004, 4, '2025-08-15', 180),
(1005, 5, '2025-08-20', 90),
(1006, 6, '2025-09-01', 110),
(1007, 7, '2025-09-10', 250),
(1008, 8, '2025-09-15', 175),
(1009, 9, '2025-09-25', 95),
(1010, 10, '2025-10-01', 140),
(1011, 1, '2025-10-10', 210),
(1012, 2, '2025-10-12', 170),
(1013, 3, '2025-10-18', 300),
(1014, 4, '2025-10-20', 260),
(1015, 5, '2025-10-25', 200),
(1016, 6, '2025-10-28', 230),
(1017, 7, '2025-11-01', 180),
(1018, 8, '2025-11-02', 220),
(1019, 9, '2025-11-02', 150),
(1020, 10, '2025-11-02', 190);

INSERT INTO deliveries VALUES
(2001, 1001, 'Yurtici', '2025-07-11', '2025-07-13', 'Delivered'),
(2002, 1002, 'MNG', '2025-07-19', '2025-07-23', 'Delivered'),
(2003, 1003, 'Aras', '2025-08-03', '2025-08-07', 'Delivered'),
(2004, 1004, 'Trendyol Express', '2025-08-16', NULL, 'Pending'),
(2005, 1005, 'Yurtici', '2025-08-21', '2025-08-25', 'Delivered'),
(2006, 1006, 'MNG', '2025-09-02', '2025-09-06', 'Delivered'),
(2007, 1007, 'Aras', '2025-09-11', '2025-09-14', 'Delivered'),
(2008, 1008, 'Trendyol Express', '2025-09-16', NULL, 'Cancelled'),
(2009, 1009, 'Yurtici', '2025-09-26', '2025-09-29', 'Delivered'),
(2010, 1010, 'MNG', '2025-10-02', '2025-10-06', 'Delivered'),
(2011, 1011, 'Yurtici', '2025-10-11', '2025-10-13', 'Delivered'),
(2012, 1012, 'Trendyol Express', '2025-10-13', NULL, 'Pending'),
(2013, 1013, 'Aras', '2025-10-19', '2025-10-21', 'Delivered'),
(2014, 1014, 'Yurtici', '2025-10-21', '2025-10-23', 'Delivered'),
(2015, 1015, 'MNG', '2025-10-26', NULL, 'Cancelled'),
(2016, 1016, 'Yurtici', '2025-10-29', '2025-11-01', 'Delivered'),
(2017, 1017, 'Aras', '2025-11-01', NULL, 'Pending'),
(2018, 1018, 'Trendyol Express', '2025-11-02', NULL, 'Pending'),
(2019, 1019, 'MNG', '2025-11-02', '2025-11-02', 'Delivered'),
(2020, 1020, 'Yurtici', '2025-11-02', NULL, 'Pending');
```