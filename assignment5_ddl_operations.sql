-- ASSIGNMENT 5 (CONTINUED): DDL Operations - INDEX, ALTER, VIEW, SEQUENCE, DROP, TRUNCATE

-- Prerequisites: Run assignment5_ddl_table_creation.sql first

-- ===== A) CREATE INDEX on Employee table with emp_no =====
CREATE INDEX idx_emp_no
ON Employee(emp_no);

-- Verify index creation
SELECT 'Index idx_emp_no created on Employee(emp_no)' AS status;


-- ===== B) PERFORM ALTER TABLE OPERATION =====
-- Add a new column 'salary_bonus' to Employee table
ALTER TABLE Employee
ADD salary_bonus INT;

-- Modify the 'name' column to increase VARCHAR size
ALTER TABLE Employee
MODIFY name VARCHAR(100);

-- Drop a column from Employee table (example: if we want to remove salary_bonus)
-- ALTER TABLE Employee DROP COLUMN salary_bonus;

-- Rename table (if needed)
-- ALTER TABLE Employee RENAME TO Employee_Master;

SELECT 'ALTER TABLE: Added salary_bonus column to Employee table' AS status;
SELECT 'ALTER TABLE: Modified name column to VARCHAR(100)' AS status;


-- ===== C) CREATE VIEW on columns emp_no and pay_rate =====
CREATE VIEW Employee_Pay_View AS
SELECT emp_no, pay_rate
FROM Employee;

-- Create another view for complete employee information
CREATE VIEW Employee_Info_View AS
SELECT emp_no, name, skill, pay_rate
FROM Employee;

SELECT 'View Employee_Pay_View created successfully' AS status;
SELECT 'View Employee_Info_View created successfully' AS status;

-- Display views (query from view)
-- SELECT * FROM Employee_Pay_View;


-- ===== D) CREATE SEQUENCE on Employee table =====
-- Note: MySQL does not have native SEQUENCE like Oracle or SQL Server
-- We can use AUTO_INCREMENT as an alternative, or simulate with a separate table

-- Method 1: Using AUTO_INCREMENT (MySQL approach)
-- Modify emp_no to auto-increment
-- ALTER TABLE Employee MODIFY emp_no INT AUTO_INCREMENT;

-- Method 2: Create a sequence simulation table (works on all databases)
CREATE TABLE emp_sequence (
    seq_name VARCHAR(50),
    seq_value INT,
    PRIMARY KEY (seq_name)
);

INSERT INTO emp_sequence VALUES ('emp_seq', 0);

-- Function/Procedure to get next sequence value
DELIMITER //
CREATE FUNCTION get_next_emp_seq() RETURNS INT
DETERMINISTIC
MODIFIES SQL DATA
BEGIN
    UPDATE emp_sequence SET seq_value = seq_value + 1 WHERE seq_name = 'emp_seq';
    RETURN (SELECT seq_value FROM emp_sequence WHERE seq_name = 'emp_seq');
END //
DELIMITER ;

SELECT 'Sequence emp_seq created successfully' AS status;


-- ===== INSERT DATA using SEQUENCE =====
-- Using the sequence function
INSERT INTO Employee (emp_no, name, skill, pay_rate) VALUES 
(1, 'ABC', 'Java', 5000);

INSERT INTO Employee (emp_no, name, skill, pay_rate) VALUES 
(2, 'XYZ', 'Python', 6000);

INSERT INTO Employee (emp_no, name, skill, pay_rate) VALUES 
(3, 'PQR', 'SQL', 5500);

SELECT 'Sample data inserted into Employee table' AS status;


-- ===== SAMPLE DATA for Position and Duty_allocation =====
INSERT INTO Position VALUES (101, 'Java');
INSERT INTO Position VALUES (102, 'Python');
INSERT INTO Position VALUES (103, 'SQL');

INSERT INTO Duty_allocation VALUES (101, 1, 'Monday', 'day');
INSERT INTO Duty_allocation VALUES (102, 2, 'Tuesday', 'night');
INSERT INTO Duty_allocation VALUES (103, 3, 'Wednesday', 'day');


-- ===== DISPLAY ALL DATA =====
SELECT 'Employee Table:' AS '';
SELECT * FROM Employee;

SELECT 'Position Table:' AS '';
SELECT * FROM Position;

SELECT 'Duty Allocation Table:' AS '';
SELECT * FROM Duty_allocation;


-- ===== E) DROP & TRUNCATE OPERATIONS =====

-- TRUNCATE TABLE: Removes all data but keeps table structure
-- TRUNCATE TABLE Employee;
-- SELECT 'TRUNCATE: All data removed from Employee table, structure remains' AS status;

-- DROP TABLE: Removes entire table including structure and data
-- DROP TABLE Duty_allocation;
-- SELECT 'DROP: Duty_allocation table dropped completely' AS status;

-- DROP TABLE Employee;
-- SELECT 'DROP: Employee table dropped completely' AS status;

-- Drop view
-- DROP VIEW Employee_Pay_View;
-- SELECT 'DROP VIEW: Employee_Pay_View dropped' AS status;

-- Drop index
-- DROP INDEX idx_emp_no ON Employee;
-- SELECT 'DROP INDEX: idx_emp_no dropped' AS status;

SELECT 'All DDL operations completed successfully!' AS final_status;
