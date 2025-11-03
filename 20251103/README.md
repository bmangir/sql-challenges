# ABOUT
This folder contains SQL scripts to create and populate a sample database for an e-commerce delivery system in Turkey. The database includes tables for Customers, Couriers, Orders, and Deliveries, along with sample data to illustrate various scenarios such as delivered, pending, cancelled, and returned orders.

# TABLE CREATIONS AND DATA INSERTIONS

```
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Ali Yılmaz', 'Marmara'),
(2, 'Ayşe Demir', 'Ege'),
(3, 'Burak Can', 'İç Anadolu'),
(4, 'Ceren Koç', 'Akdeniz'),
(5, 'Emre Şen', 'Karadeniz'),
(6, 'Deniz Arı', 'Marmara'),
(7, 'Gamze Öztürk', 'Ege'),
(8, 'Tolga Aydın', 'Doğu Anadolu');
```
```
CREATE TABLE Couriers (
    courier_id INT PRIMARY KEY,
    courier_name VARCHAR(100),
    region VARCHAR(50)
);

INSERT INTO Couriers VALUES
(1, 'Trendyol Express', 'Marmara'),
(2, 'Yurtiçi Kargo', 'Ege'),
(3, 'MNG Kargo', 'İç Anadolu'),
(4, 'Aras Kargo', 'Akdeniz');
```
```
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    courier_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders VALUES
(101, 1, 1, '2025-10-20', 450.50),
(102, 2, 2, '2025-10-21', 299.99),
(103, 3, 3, '2025-10-23', 120.00),
(104, 4, 4, '2025-10-25', 560.00),
(105, 5, 1, '2025-10-28', 750.00),
(106, 6, 2, '2025-10-30', 220.00),
(107, 7, 3, '2025-10-31', 130.00),
(108, 8, 4, '2025-11-01', 499.99),
(109, 1, 1, '2025-11-02', 330.00),
(110, 2, 2, '2025-11-02', 250.00),
(111, 3, 3, '2025-11-03', 999.00),
(112, 4, 4, '2025-11-03', 660.00);
```
```
CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    courier_id INT,
    shipped_date DATE,
    delivered_date DATE,
    status VARCHAR(30)
);

INSERT INTO Deliveries VALUES
(1, 101, 1, '2025-10-21', '2025-10-23', 'Delivered'),
(2, 102, 2, '2025-10-22', '2025-10-24', 'Delivered'),
(3, 103, 3, '2025-10-24', NULL, 'Pending'),
(4, 104, 4, '2025-10-26', '2025-10-28', 'Delivered'),
(5, 105, 1, '2025-10-29', '2025-11-01', 'Delivered'),
(6, 106, 2, '2025-10-31', NULL, 'Cancelled'),
(7, 107, 3, '2025-11-01', NULL, 'Returned'),
(8, 108, 4, '2025-11-02', '2025-11-03', 'Delivered'),
(9, 109, 1, '2025-11-02', '2025-11-04', 'Delivered'),
(10, 110, 2, '2025-11-02', '2025-11-03', 'Delivered'),
(11, 111, 3, '2025-11-03', NULL, 'Pending'),
(12, 112, 4, '2025-11-03', '2025-11-05', 'Delivered');
```