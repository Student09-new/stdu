-- ASSIGNMENT 5: DDL Commands - CREATE, ALTER, DROP, VIEW, INDEX, SEQUENCE
-- This assignment covers comprehensive DDL operations on Company Database

-- Create the database
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- ===== CREATE TABLE: Employee =====
CREATE TABLE Employee (
    emp_no INT PRIMARY KEY,
    name VARCHAR(50),
    skill VARCHAR(50),
    pay_rate INT
);

-- ===== CREATE TABLE: Position =====
CREATE TABLE Position (
    posting_no INT PRIMARY KEY,
    skill VARCHAR(50)
);

-- ===== CREATE TABLE: Duty_allocation =====
CREATE TABLE Duty_allocation (
    posting_no INT,
    emp_no INT,
    day VARCHAR(20),
    shift VARCHAR(10),
    FOREIGN KEY (posting_no) REFERENCES Position(posting_no),
    FOREIGN KEY (emp_no) REFERENCES Employee(emp_no)
);

-- Display all created tables
SELECT 'Employee Table Created Successfully' AS status;
SELECT * FROM Employee;

SELECT 'Position Table Created Successfully' AS status;
SELECT * FROM Position;

SELECT 'Duty_allocation Table Created Successfully' AS status;
SELECT * FROM Duty_allocation;
