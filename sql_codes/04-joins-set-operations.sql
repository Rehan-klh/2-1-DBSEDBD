USE bookflow_db;

CREATE TABLE class (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE class_info (
    id INT,
    address VARCHAR(30)
);

INSERT INTO class VALUES
(1,'Rehan'),
(2,'Akhil'),
(4,'Rohit');

INSERT INTO class_info VALUES
(1,'HYDERABAD'),
(2,'MUMBAI'),
(3,'CHENNAI');

SELECT *
FROM class
CROSS JOIN class_info;

DELETE FROM class;
DELETE FROM class_info;

INSERT INTO class VALUES
(1,'Rehan'),
(2,'Akhil'),
(3,'Rohit'),
(4,'Pratik');

INSERT INTO class_info VALUES
(1,'HYDERABAD'),
(2,'MUMBAI'),
(3,'CHENNAI');

SELECT *
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

SELECT class.name,
       class_info.address
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
NATURAL JOIN class_info;

INSERT INTO class VALUES
(5,'YUGANDAR');

INSERT INTO class_info VALUES
(7,'GUNTUR'),
(8,'BAPATLA');

SELECT *
FROM class
LEFT OUTER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL;

SELECT *
FROM class
RIGHT OUTER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id

UNION

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL

UNION

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;

CREATE TABLE first_table (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE second_table (
    id INT,
    name VARCHAR(30)
);

INSERT INTO first_table VALUES
(1,'Rehan'),
(2,'Aditya');

INSERT INTO second_table VALUES
(2,'Akhil'),
(3,'Rohit');

SELECT *
FROM first_table
UNION
SELECT *
FROM second_table;

SELECT name
FROM first_table
UNION
SELECT name
FROM second_table;

SELECT *
FROM first_table
UNION ALL
SELECT *
FROM second_table;

SELECT COUNT(*)
FROM (
    SELECT * FROM first_table
    UNION ALL
    SELECT * FROM second_table
) AS A;

DELETE FROM first_table;
DELETE FROM second_table;

INSERT INTO first_table VALUES
(1,'Rehan'),
(2,'Akhil');

INSERT INTO second_table VALUES
(2,'Akhil'),
(3,'Rohit');

SELECT f.*
FROM first_table f
INNER JOIN second_table s
ON f.id = s.id
AND f.name = s.name;

SELECT f.name
FROM first_table f
INNER JOIN second_table s
ON f.name = s.name;

SELECT f.*
FROM first_table f
LEFT JOIN second_table s
ON f.id = s.id
AND f.name = s.name
WHERE s.id IS NULL;

SELECT f.name
FROM first_table f
LEFT JOIN second_table s
ON f.name = s.name
WHERE s.name IS NULL;

SELECT c.id,
       c.name,
       ci.address
FROM class c
INNER JOIN class_info ci
ON c.id = ci.id;

SELECT c.id,
       c.name,
       CASE
           WHEN ci.address IS NULL
           THEN 'Address Missing'
           ELSE 'Address Available'
       END AS Status
FROM class c
LEFT JOIN class_info ci
ON c.id = ci.id;