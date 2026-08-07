CREATE DATABASE IF NOT EXISTS bookflow_db;
USE bookflow_db;
CREATE TABLE books (
 book_id INT AUTO_INCREMENT PRIMARY KEY,
 title VARCHAR(255) NOT NULL,
 isbn VARCHAR(13) NOT NULL UNIQUE,
 published_year INT,
 CONSTRAINT chk_published_year CHECK (published_year < 2027)
);
CREATE TABLE members (
 member_id INT AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(100) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE
);
DESCRIBE books;
DESCRIBE members;

INSERT INTO books (title,isbn,published_year) VALUES
('The Alchemist', '9780061122415', 1988),
('Clean Code', '9780132350884', 2008),
('Atomic Habits', '9780735211292', 2018);

INSERT INTO members (full_name, email) VALUES
('Akhil Frau', 'akhil@example.com'),
('Rohit BJ', 'rohit@example.com'),
('Ravi Verma', 'ravi.verma@example.com');

SELECT * FROM books;
SELECT * FROM members;

CREATE TABLE students (
student_id INT NOT NULL UNIQUE,
student_name VARCHAR(255) NOT NULL,
student_stream VARCHAR(10) NOT NULL
);
INSERT INTO students (student_id,student_name,student_stream) VALUES
(30066,'Mohammad Rehan','CSE'),
(30021,'Akhil Frau','ECE'),
(30030,'Rohit Sai','CSI');
SELECT * FROM students;
CREATE TABLE student (
student_id INT NOT NULL UNIQUE,
student_name VARCHAR(255) NOT NULL,
student_stream VARCHAR(100) NOT NULL
);
DROP TABLE student;
DROP DATABASE IF EXISTS bookflow_db;

