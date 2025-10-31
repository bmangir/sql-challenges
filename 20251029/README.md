# ABOUT
This directory contains SQL scripts for creating and populating tables related to shipment tracking and courier services. The scripts include the creation of `shipments` and `couriers` tables, along with sample data inserts for each table.

# TABLE CREATIONS AND DATA INSERTS
```
CREATE TABLE shipments (
shipment_id SERIAL PRIMARY KEY,
order_id INT,
courier_id INT,
ship_date DATE,
delivery_date DATE,
status VARCHAR(20)
);

INSERT INTO shipments (order_id, courier_id, ship_date, delivery_date, status) VALUES
(1, 201, '2025-10-01', '2025-10-03', 'Delivered'),
(2, 201, '2025-10-02', '2025-10-07', 'Delivered'),
(3, 202, '2025-10-04', NULL, 'In Transit'),
(4, 203, '2025-10-05', '2025-10-12', 'Delivered'),
(5, 201, '2025-10-06', NULL, 'Lost'),
(6, 202, '2025-10-08', '2025-10-09', 'Delivered'),
(7, 204, '2025-10-09', '2025-10-13', 'Delivered'),
(8, 202, '2025-10-10', NULL, 'In Transit');
```
```
CREATE TABLE couriers (
courier_id INT PRIMARY KEY,
courier_name VARCHAR(50),
region VARCHAR(50)
);

INSERT INTO couriers (courier_id, courier_name, region) VALUES
(201, 'FastTrack', 'Marmara'),
(202, 'CargoJet', 'Ege'),
(203, 'ShipNow', 'Akdeniz'),
(204, 'ExpressGo', 'İç Anadolu');
```