# ABOUT
This SQL script creates and populates a sample database for an e-commerce platform. The database consists of four tables: `customers`, `orders`, `deliveries`, and `order_items`. Each table is designed to store relevant information about customers, their orders, delivery details, and the items included in each order.

# TABLE CREATIONS AND DATA INSERTIONS

```
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    registration_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2),
    delivery_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    courier_name VARCHAR(50),
    shipped_date DATE,
    delivered_date DATE,
    status VARCHAR(20), -- 'Delivered', 'Pending', 'Cancelled'
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_category VARCHAR(50),
    quantity INT,
    price NUMERIC(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
```
```
INSERT INTO customers VALUES
(1, 'Alice', 'Europe', '2024-10-01'),
(2, 'Bob', 'Europe', '2024-12-05'),
(3, 'Charlie', 'Asia', '2025-01-15'),
(4, 'Diana', 'America', '2025-02-10');

INSERT INTO orders VALUES
(1001, 1, '2025-03-01', 120.00, 501),
(1002, 1, '2025-03-12', 200.00, 502),
(1003, 2, '2025-03-20', 350.00, 503),
(1004, 3, '2025-03-25', 150.00, 504),
(1005, 4, '2025-04-02', 400.00, 505),
(1006, 2, '2025-04-10', 50.00, 506),
(1007, 4, '2025-04-15', 800.00, 507),
(1008, 1, '2025-04-20', 45.00, 508),
(1009, 3, '2025-04-22', 90.00, 509),
(1010, 2, '2025-05-01', 150.00, 510),
(1011, 4, '2025-05-05', 210.00, 511),
(1012, 1, '2025-05-10', 320.00, 512),
(1013, 3, '2025-05-15', 60.00, 513),
(1014, 2, '2025-05-20', 110.00, 514),
(1015, 4, '2025-05-25', 180.00, 515);

INSERT INTO deliveries VALUES
(501, 1001, 'DHL', '2025-03-02', '2025-03-05', 'Delivered'),
(502, 1002, 'UPS', '2025-03-13', '2025-03-25', 'Delivered'),
(503, 1003, 'FedEx', '2025-03-22', NULL, 'Pending'),
(504, 1004, 'DHL', '2025-03-26', '2025-03-30', 'Delivered'),
(505, 1005, 'UPS', '2025-04-03', '2025-04-15', 'Delivered'),
(506, 1006, 'FedEx', '2025-04-11', '2025-04-13', 'Delivered'),
(507, 1007, 'DHL', '2025-04-16', NULL, 'Pending'),
(508, 1008, 'UPS', '2025-04-21', '2025-04-28', 'Delivered'),
(509, 1009, 'DHL', '2025-04-23', '2025-04-26', 'Delivered'),
(510, 1010, 'FedEx', '2025-05-02', '2025-05-07', 'Delivered'),
(512, 1012, 'DHL', '2025-05-11', '2025-05-15', 'Delivered'),
(513, 1013, 'FedEx', '2025-05-16', '2025-05-19', 'Delivered'),
(514, 1014, 'UPS', '2025-05-21', NULL, 'Pending'),
(515, 1015, 'DHL', '2025-05-26', '2025-05-29', 'Delivered');

INSERT INTO order_items (order_id, product_category, quantity, price) VALUES
(1001, 'Electronics', 1, 120.00),
(1002, 'Clothing', 2, 100.00),
(1003, 'Electronics', 3, 100.00),
(1004, 'Home', 2, 75.00),
(1005, 'Electronics', 4, 100.00),
(1005, 'Clothing', 1, 50.00),
(1006, 'Clothing', 1, 50.00),
(1007, 'Electronics', 2, 400.00), -- Toplam 800.00
(1008, 'Home', 1, 45.00),
(1009, 'Books', 3, 30.00),
(1010, 'Electronics', 1, 150.00),
(1011, 'Clothing', 3, 70.00),
(1012, 'Home', 2, 160.00),
(1013, 'Books', 2, 30.00),
(1014, 'Clothing', 1, 110.00),
(1015, 'Electronics', 1, 180.00);

```
