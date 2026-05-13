-- ASSIGNMENT 3: Duty Database Management System
-- This assignment covers database creation, table design, and sample data insertion

-- Create the database
CREATE DATABASE DutyDB;
USE DutyDB;

-- Create Employee table
CREATE TABLE Employee (
    emp_no INT PRIMARY KEY,
    name VARCHAR(50),
    skill VARCHAR(50),
    pay_rate INT
);

-- Create Position table
CREATE TABLE Position (
    posting_no INT PRIMARY KEY,
    skill VARCHAR(50)
);

-- Create Duty_allocation table with foreign key constraints
CREATE TABLE Duty_allocation (
    posting_no INT,
    emp_no INT,
    day VARCHAR(20),
    shift VARCHAR(10),   -- day/night
    FOREIGN KEY (posting_no) REFERENCES Position(posting_no),
    FOREIGN KEY (emp_no) REFERENCES Employee(emp_no)
);

-- Insert sample data into Employee table
INSERT INTO Employee VALUES
(1, 'XYZ', 'Java', 5000),
(2, 'Amit', 'Python', 6000),
(3, 'Rahul', 'Java', 4500),
(4, 'Sita', 'SQL', 7000);

-- Insert sample data into Position table
INSERT INTO Position VALUES
(101, 'Java'),
(102, 'Python'),
(103, 'SQL');

-- Insert sample data into Duty_allocation table
INSERT INTO Duty_allocation VALUES
(101, 1, 'Monday', 'day'),
(102, 2, 'Monday', 'night'),
(103, 4, 'Tuesday', 'day'),
(101, 3, 'Wednesday', 'night');

-- Display all tables
SELECT 'Employee Table:' AS '';
SELECT * FROM Employee;

SELECT 'Position Table:' AS '';
SELECT * FROM Position;

SELECT 'Duty Allocation Table:' AS '';
SELECT * FROM Duty_allocation;
