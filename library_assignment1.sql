-- ASSIGNMENT 1: Library Management System - Database Creation and DML Operations
-- This assignment covers database design, table creation, data insertion, and basic CRUD operations

-- ===== CREATE DATABASE =====
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- ===== CREATE TABLE: Publisher =====
CREATE TABLE Publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(50),
    city VARCHAR(50)
);

-- ===== CREATE TABLE: Books =====
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(100),
    author VARCHAR(50),
    price INT,
    publisher_id INT,
    FOREIGN KEY (publisher_id)
    REFERENCES Publisher(publisher_id)
);

-- ===== CREATE TABLE: Student =====
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(50),
    book_id INT,
    FOREIGN KEY (book_id)
    REFERENCES Books(book_id)
);

-- ===== INSERT INTO Publisher =====
INSERT INTO Publisher VALUES
(1, 'Pearson', 'Delhi'),
(2, 'McGraw Hill', 'Mumbai'),
(3, 'Oxford', 'Pune');

-- ===== INSERT INTO Books =====
INSERT INTO Books VALUES
(101, 'Database Systems', 'Korth', 500, 1),
(102, 'Operating System', 'Galvin', 650, 2),
(103, 'Computer Networks', 'Tanenbaum', 700, 3);

-- ===== INSERT INTO Student =====
INSERT INTO Student VALUES
(1, 'Amit', 'Computer', 101),
(2, 'Rahul', 'IT', 102),
(3, 'Sita', 'ENTC', 103);

-- ===== SELECT COMMANDS: Display all data =====
SELECT 'Publisher Table:' AS '';
SELECT * FROM Publisher;

SELECT 'Books Table:' AS '';
SELECT * FROM Books;

SELECT 'Student Table:' AS '';
SELECT * FROM Student;

-- ===== UPDATE COMMAND: Modify book price =====
UPDATE Books
SET price = 750
WHERE book_id = 103;

SELECT 'After UPDATE - Books Table:' AS '';
SELECT * FROM Books;

-- ===== DELETE COMMAND: Remove student record =====
DELETE FROM Student
WHERE student_id = 3;

SELECT 'After DELETE - Student Table:' AS '';
SELECT * FROM Student;

-- ===== ALTER TABLE COMMAND: Add new column =====
ALTER TABLE Student
ADD phone_no VARCHAR(15);

SELECT 'After ALTER TABLE - Student Table:' AS '';
SELECT * FROM Student;

-- ===== DROP TABLE COMMAND: Create and drop temporary table =====
CREATE TABLE TempTable (
    id INT
);

SELECT 'TempTable created successfully' AS status;

DROP TABLE TempTable;

SELECT 'TempTable dropped successfully' AS status;

-- ===== FINAL VERIFICATION =====
SELECT 'All DML Operations Completed Successfully!' AS final_status;
