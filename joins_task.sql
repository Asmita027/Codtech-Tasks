-- Create Database
CREATE DATABASE internship_joins;
USE internship_joins;

-- Create Tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course_id INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

-- Insert Data
INSERT INTO students VALUES
(1, 'Amit', 101),
(2, 'Neha', 102),
(3, 'Ravi', 103),
(4, 'Priya', NULL);

INSERT INTO courses VALUES
(101, 'Web Development'),
(102, 'Data Science'),
(104, 'Cyber Security');

-- INNER JOIN
SELECT s.student_id, s.name, c.course_name
FROM students s
INNER JOIN courses c
ON s.course_id = c.course_id;

-- LEFT JOIN
SELECT s.student_id, s.name, c.course_name
FROM students s
LEFT JOIN courses c
ON s.course_id = c.course_id;

-- RIGHT JOIN
SELECT s.student_id, s.name, c.course_name
FROM students s
RIGHT JOIN courses c
ON s.course_id = c.course_id;

-- FULL JOIN (MySQL workaround)
SELECT s.student_id, s.name, c.course_name
FROM students s
LEFT JOIN courses c
ON s.course_id = c.course_id

UNION

SELECT s.student_id, s.name, c.course_name
FROM students s
RIGHT JOIN courses c
ON s.course_id = c.course_id;
