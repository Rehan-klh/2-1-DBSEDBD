USE bookflow_db;

CREATE TABLE student_marks1 (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    subject VARCHAR(50),
    marks DECIMAL(5,2)
);
DESCRIBE student_marks1;
INSERT INTO student_marks1 (roll_no, name, subject, marks) VALUES 
(1, 'Rehan', 'Math', 85.50), 
(2, 'Rohit', 'Math', 92.75), 
(3, 'Akhil', 'Math', 78.40), 
(4, 'Pratik', 'Math', 88.90), 
(5, 'Bharath', 'Math', 80.25), 
(6, 'Yugandhar', 'aws', 98.50), 
(7, 'Sreekar', 'dbms', 95.75), 
(8, 'Arnav', 'english', 97.40), 
(9, 'kavithamam', 'aws1', 99.90), 
(10, 'seetha', 'azure', 82.25);

SELECT COUNT(*) AS total_students FROM student_marks1;
SELECT SUM(marks) FROM student_marks1;
SELECT AVG(marks) FROM student_marks1;
SELECT MAX(marks) FROM student_marks1;
SELECT MIN(marks) FROM student_marks1;

SELECT * FROM student_marks1 WHERE marks > 85;
SELECT * FROM student_marks1 WHERE marks >= 90;
SELECT * FROM student_marks1 WHERE marks < 80;
SELECT * FROM student_marks1 WHERE marks BETWEEN 80 AND 90;
SELECT * FROM student_marks1 WHERE name LIKE 'A%';
SELECT * FROM student_marks1 WHERE name IN ('Rehan', 'Sita', 'Vijay');
SELECT * FROM student_marks1 WHERE marks > 85 AND (subject = 'Math' OR name LIKE 'A%');

UPDATE student_marks1 SET marks = 74.00 WHERE roll_no = 3;
UPDATE student_marks1 SET subject = 'Remedial Math' WHERE marks < 80;
SELECT * FROM student_marks1;

DELETE FROM student_marks1 WHERE roll_no = 5;
DELETE FROM student_marks1 WHERE marks < 75;

SELECT * FROM student_marks1 ORDER BY marks ASC;
SELECT * FROM student_marks1 ORDER BY marks DESC;
SELECT * FROM student_marks1 ORDER BY name ASC;
SELECT * FROM student_marks1 ORDER BY name DESC;

SELECT subject, SUM(marks) AS total_marks FROM student_marks1 GROUP BY subject;
SELECT subject, AVG(marks) AS avg_marks FROM student_marks1 GROUP BY subject;
SELECT subject, COUNT(*) AS num_students FROM student_marks1 GROUP BY subject;

SELECT subject, AVG(marks) AS avg_marks
FROM student_marks1
GROUP BY subject
HAVING AVG(marks) > 90;

SELECT subject, COUNT(*) AS num_students
FROM student_marks1
GROUP BY subject
HAVING COUNT(*) > 1;
