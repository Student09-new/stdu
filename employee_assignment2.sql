-- ASSIGNMENT 2: Employee Database - Advanced Queries
-- Covers: Subqueries, JOINs, Aggregate Functions, Pattern Matching with LIKE

CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

CREATE TABLE IF NOT EXISTS Company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT,
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

INSERT INTO Company VALUES
('FBC', 'Mumbai', 'India'),
('Small Bank Corporation', 'Delhi', 'India'),
('TechCorp', 'Bangalore', 'India'),
('Accenture', 'Pune', 'India'),
('TechnoIndia', 'Hyderabad', 'India');

INSERT INTO Employee VALUES
('Amit', '123 MG Road', 'Mumbai'),
('Rahul', '456 Park Street', 'Delhi'),
('Sita', '789 IT Park', 'Bangalore'),
('John', '321 Tech Lane', 'Pune'),
('Priya', '654 Business St', 'Hyderabad'),
('Vikram', '987 Commerce Road', 'Mumbai');

INSERT INTO Works VALUES
('Amit', 'FBC', 15000),
('Rahul', 'Small Bank Corporation', 12000),
('Sita', 'TechCorp', 18000),
('John', 'Accenture', 16000),
('Priya', 'TechnoIndia', 14000),
('Vikram', 'FBC', 11000);

-- Query 1: Employees who work for FBC
SELECT employee_name FROM Works WHERE company_name = 'FBC';

-- Query 2: Employees who work for FBC and salary > 10000
SELECT E.employee_name, E.street, E.city
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.company_name = 'FBC' AND W.salary > 10000;

-- Query 3: Employees earning more than ALL employees of Small Bank Corporation
SELECT employee_name FROM Works
WHERE salary > ALL (
    SELECT salary FROM Works WHERE company_name = 'Small Bank Corporation'
);

-- Query 4: Company with smallest total payroll
SELECT company_name FROM Works
GROUP BY company_name
HAVING SUM(salary) = (
    SELECT MIN(total_salary) FROM (
        SELECT SUM(salary) AS total_salary FROM Works GROUP BY company_name
    ) AS temp
);

-- Query 5: Update company name where city = Pune
UPDATE Company SET company_name = 'Updated_Pune_Company' WHERE city = 'Pune';

-- Query 6: Company names starting with 'A'
SELECT company_name FROM Company WHERE company_name LIKE 'A%';

-- Query 7: Company names ending with 'a'
SELECT company_name FROM Company WHERE company_name LIKE '%a';

-- Query 8: Company names containing 'tech'
SELECT company_name FROM Company 
WHERE company_name LIKE '%tech%' OR company_name LIKE '%Tech%' OR company_name LIKE '%TECH%';
