-- ASSIGNMENT 3 (CONTINUED): Query Exercises for Duty Database
-- This file contains all query examples to solve various business problems

-- Prerequisites: Run assignment3_duty_db_setup.sql first

-- ===== QUERY 1: Find the shift for the employee 'XYZ' =====
SELECT D.shift
FROM Employee E
JOIN Duty_allocation D ON E.emp_no = D.emp_no
WHERE E.name = 'XYZ';


-- ===== QUERY 2: Get count of different employees for each shift =====
SELECT shift, COUNT(DISTINCT emp_no) AS total_employees
FROM Duty_allocation
GROUP BY shift;


-- ===== QUERY 3: Find the employee eligible to fill a position =====
-- Employees whose skill matches the position's required skill
SELECT E.name, P.posting_no, E.skill
FROM Employee E
JOIN Position P ON E.skill = P.skill;


-- ===== QUERY 4: Find employee with the lowest pay rate =====
SELECT name, pay_rate
FROM Employee
WHERE pay_rate = (SELECT MIN(pay_rate) FROM Employee);


-- ===== QUERY 5: Find the name and rate of pay of all employees allocated to duty =====
SELECT DISTINCT E.name, E.pay_rate
FROM Employee E
JOIN Duty_allocation D ON E.emp_no = D.emp_no;


-- ===== QUERY 6: Count the number of employees =====
SELECT COUNT(*) AS total_employees
FROM Employee;


-- ===== QUERY 7: Calculate the total payroll of the company =====
SELECT SUM(pay_rate) AS total_payroll
FROM Employee;


-- ===== QUERY 8: Calculate the average payrate of the company for each employee =====
SELECT AVG(pay_rate) AS average_payrate
FROM Employee;


-- ===== QUERY 9: Find minimum and maximum payrate of the company =====
SELECT 
    MIN(pay_rate) AS min_payrate,
    MAX(pay_rate) AS max_payrate
FROM Employee;
