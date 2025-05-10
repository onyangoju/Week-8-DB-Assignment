
-- ---------------------------------------------------
-- Clinic Booking System Database (MySQL)
-- ---------------------------------------------------

-- Drop the database if it exists
DROP DATABASE IF EXISTS clinic_booking_system;

-- Create the database
CREATE DATABASE clinic_booking_system;

-- Use the database
USE clinic_booking_system;

-- ---------------------------------------------------
-- Table: departments
-- ---------------------------------------------------
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- ---------------------------------------------------
-- Table: patients
-- ---------------------------------------------------
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- ---------------------------------------------------
-- Table: doctors
-- ---------------------------------------------------
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ---------------------------------------------------
-- Table: appointments
-- ---------------------------------------------------
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- ---------------------------------------------------
-- Table: bills
-- ---------------------------------------------------
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Pending') DEFAULT 'Pending',
    payment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- ---------------------------------------------------
-- Table: doctor_schedules
-- ---------------------------------------------------
CREATE TABLE doctor_schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    available_date DATETIME NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- ---------------------------------------------------
-- 🚧 TEST DATA BELOW (for verification only)
-- ---------------------------------------------------

-- Insert sample department
INSERT INTO departments (name, description) VALUES 
('General Medicine', 'General medical care');

-- Insert a doctor
INSERT INTO doctors (full_name, specialization, phone, email, department_id)
VALUES 
('Dr. Sarah Kimani', 'Physician', '0700000001', 'sarah@example.com', 1);

-- Insert a patient
INSERT INTO patients (full_name, date_of_birth, gender, phone, email, address)
VALUES 
('John Doe', '1990-01-01', 'Male', '0711000000', 'john@example.com', 'Nairobi');

-- Insert appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, notes)
VALUES 
(1, 1, '2025-05-09 10:00:00', 'Completed', 'Routine checkup'),
(1, 1, '2025-05-10 11:00:00', 'Scheduled', 'Follow-up visit');

-- Insert bills
INSERT INTO bills (appointment_id, amount, payment_status, payment_date)
VALUES 
(1, 150.00, 'Paid', '2025-05-10'),
(2, 200.00, 'Pending', NULL);

-- Insert doctor schedule
INSERT INTO doctor_schedules (doctor_id, available_date)
VALUES 
(1, '2025-05-12 09:00:00'),
(1, '2025-05-13 14:00:00');

-- ---------------------------------------------------
-- 🔍 These entries are for testing only. You may remove them for clean deployment.
-- ---------------------------------------------------
