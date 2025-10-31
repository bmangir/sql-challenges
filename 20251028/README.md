# ABOUT
This SQL script sets up a simple healthcare database with tables for patients, doctors, appointments, and bills. It also populates these tables with sample data to facilitate testing and development.

# TABLE CREATIONS AND DATA INSERTS

```
DROP TABLE IF EXISTS patients, doctors, appointments, bills CASCADE;

CREATE TABLE patients (
patient_id SERIAL PRIMARY KEY,
patient_name VARCHAR(100),
gender VARCHAR(10),
birth_date DATE
);

CREATE TABLE doctors (
doctor_id SERIAL PRIMARY KEY,
doctor_name VARCHAR(100),
specialty VARCHAR(50)
);

CREATE TABLE appointments (
appointment_id SERIAL PRIMARY KEY,
patient_id INT REFERENCES patients(patient_id),
doctor_id INT REFERENCES doctors(doctor_id),
appointment_date DATE,
diagnosis VARCHAR(100)
);

CREATE TABLE bills (
bill_id SERIAL PRIMARY KEY,
appointment_id INT REFERENCES appointments(appointment_id),
total_amount NUMERIC(10,2),
paid BOOLEAN
);
```
```
INSERT INTO patients (patient_name, gender, birth_date) VALUES
('Ahmet Yılmaz', 'Male', '1987-03-12'),
('Ayşe Demir', 'Female', '1993-07-21'),
('Mehmet Kaya', 'Male', '1979-10-09'),
('Elif Çelik', 'Female', '2000-11-15'),
('Ali Can', 'Male', '1990-05-05');

INSERT INTO doctors (doctor_name, specialty) VALUES
('Dr. Hakan Öz', 'Cardiology'),
('Dr. Selin Taş', 'Dermatology'),
('Dr. Kerem Er', 'Neurology'),
('Dr. Gül Kılıç', 'Pediatrics');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis) VALUES
(1, 1, '2025-10-20', 'Hypertension'),
(2, 2, '2025-10-22', 'Eczema'),
(3, 1, '2025-10-25', 'Heart Disease'),
(4, 4, '2025-10-26', 'Flu'),
(5, 3, '2025-10-27', 'Migraine'),
(1, 3, '2025-10-28', 'Headache'),
(2, 1, '2025-10-29', 'Chest Pain'),
(3, 4, '2025-10-30', 'Allergy'),
(4, 2, '2025-10-31', 'Skin Rash');

INSERT INTO bills (appointment_id, total_amount, paid) VALUES
(1, 250.00, TRUE),
(2, 120.00, TRUE),
(3, 400.00, FALSE),
(4, 80.00, TRUE),
(5, 180.00, TRUE),
(6, 220.00, FALSE),
(7, 300.00, TRUE),
(8, 150.00, FALSE),
(9, 100.00, TRUE);
```