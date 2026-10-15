USE bookflow_db;

DESCRIBE Books;

SELECT *
FROM Books
ORDER BY book_id;

DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    description TEXT,
    published_year INT
);

SHOW CREATE TABLE Books;

ALTER TABLE Books
ADD COLUMN author VARCHAR(150) NOT NULL DEFAULT 'Unknown',
ADD COLUMN genre VARCHAR(50),
ADD COLUMN description TEXT;














DESCRIBE Books;

UPDATE Books
SET title = 'The Martian',
    author = 'Andy Weir',
    genre = 'Science Fiction',
    description = 'An astronaut stranded on Mars fights to survive.',
    published_year = 2021
WHERE book_id = 1;

UPDATE Books
SET title = 'Dune',
    author = 'Frank Herbert',
    genre = 'Science Fiction',
    description = 'A young noble navigates politics and survival on Arrakis.',
    published_year = 1965
WHERE book_id = 2;

UPDATE Books
SET title = 'The Hitchhikers Guide to the Galaxy',
    author = 'Douglas Adams',
    genre = 'Science Fiction',
    description = 'A comedic journey across the galaxy.',
    published_year = 1979
WHERE book_id = 3;


INSERT INTO Books
(book_id, title, author, genre, description, published_year)
VALUES
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance',
 'A classic romance of manners and misunderstandings.', 1813),

(5, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic',
 'A mysterious millionaire pursues an old love.', 1925),

(6, 'Foundation', 'Isaac Asimov', 'Science Fiction',
 'A mathematician predicts the fall of a galactic empire.', 1951),

(7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy',
 'A hobbit embarks on an unexpected adventure.', 1937),

(8, 'Enders Game', 'Orson Scott Card', 'Science Fiction',
 'A young boy is trained to fight in an interstellar war.', 1985),

(9, 'Harry Potter and the Sorcerers Stone', 'J.K. Rowling', 'Fantasy',
 'A young wizard begins his magical education.', 1997),

(10, 'Twenty Thousand Leagues Under the Seas', 'Jules Verne', 'Adventure',
 'A fantastic underwater adventure aboard a mysterious submarine.', 1870);
 
 ALTER TABLE Books
MODIFY COLUMN isbn VARCHAR(13) NOT NULL DEFAULT '0000000000000';

INSERT INTO Books
(book_id, title, author, genre, description, published_year)
VALUES
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance',
 'A classic romance of manners and misunderstandings.', 1813),

(5, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic',
 'A mysterious millionaire pursues an old love.', 1925),

(6, 'Foundation', 'Isaac Asimov', 'Science Fiction',
 'A mathematician predicts the fall of a galactic empire.', 1951),

(7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy',
 'A hobbit embarks on an unexpected adventure.', 1937),

(8, 'Enders Game', 'Orson Scott Card', 'Science Fiction',
 'A young boy is trained to fight in an interstellar war.', 1985),

(9, 'Harry Potter and the Sorcerers Stone', 'J.K. Rowling', 'Fantasy',
 'A young wizard begins his magical education.', 1997),

(10, 'Twenty Thousand Leagues Under the Seas', 'Jules Verne', 'Adventure',
 'A fantastic underwater adventure aboard a mysterious submarine.', 1870);
 
 ALTER TABLE Books
MODIFY COLUMN isbn VARCHAR(13) NULL;

INSERT INTO Books
(book_id, title, author, genre, description, published_year)
VALUES
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance',
 'A classic romance of manners and misunderstandings.', 1813),

(5, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic',
 'A mysterious millionaire pursues an old love.', 1925),

(6, 'Foundation', 'Isaac Asimov', 'Science Fiction',
 'A mathematician predicts the fall of a galactic empire.', 1951),

(7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy',
 'A hobbit embarks on an unexpected adventure.', 1937),

(8, 'Enders Game', 'Orson Scott Card', 'Science Fiction',
 'A young boy is trained to fight in an interstellar war.', 1985),

(9, 'Harry Potter and the Sorcerers Stone', 'J.K. Rowling', 'Fantasy',
 'A young wizard begins his magical education.', 1997),

(10, 'Twenty Thousand Leagues Under the Seas', 'Jules Verne', 'Adventure',
 'A fantastic underwater adventure aboard a mysterious submarine.', 1870);
 
 SELECT
    book_id,
    title,
    author,
    genre,
    description,
    published_year
FROM Books
ORDER BY book_id;

ALTER TABLE Books
ADD COLUMN embedding JSON;

DESCRIBE Books;

UPDATE Books SET embedding = JSON_ARRAY(0.9, 0.8, 0.2) WHERE book_id = 1;

UPDATE Books SET embedding = JSON_ARRAY(0.8, 0.7, 0.3) WHERE book_id = 2;

UPDATE Books SET embedding = JSON_ARRAY(0.2, 0.3, 0.9) WHERE book_id = 3;

UPDATE Books SET embedding = JSON_ARRAY(0.1, 0.2, 0.8) WHERE book_id = 4;

UPDATE Books SET embedding = JSON_ARRAY(0.3, 0.4, 0.2) WHERE book_id = 5;

UPDATE Books SET embedding = JSON_ARRAY(0.85, 0.75, 0.25) WHERE book_id = 6;

UPDATE Books SET embedding = JSON_ARRAY(0.4, 0.3, 0.7) WHERE book_id = 7;

UPDATE Books SET embedding = JSON_ARRAY(0.88, 0.78, 0.22) WHERE book_id = 8;

UPDATE Books SET embedding = JSON_ARRAY(0.35, 0.25, 0.75) WHERE book_id = 9;

UPDATE Books SET embedding = JSON_ARRAY(0.25, 0.35, 0.65) WHERE book_id = 10;


SELECT
    book_id,
    title,
    embedding
FROM Books;

SELECT
    book_id,
    title,
    SQRT(
        POW(JSON_EXTRACT(embedding, '$[0]') - 0.9, 2) +
        POW(JSON_EXTRACT(embedding, '$[1]') - 0.8, 2) +
        POW(JSON_EXTRACT(embedding, '$[2]') - 0.2, 2)
    ) AS l2_distance
FROM Books
ORDER BY l2_distance ASC;


SELECT
    book_id,
    title,
    (
        (
            JSON_EXTRACT(embedding, '$[0]') * 0.9 +
            JSON_EXTRACT(embedding, '$[1]') * 0.8 +
            JSON_EXTRACT(embedding, '$[2]') * 0.2
        )
        /
        (
            SQRT(
                POW(JSON_EXTRACT(embedding, '$[0]'), 2) +
                POW(JSON_EXTRACT(embedding, '$[1]'), 2) +
                POW(JSON_EXTRACT(embedding, '$[2]'), 2)
            )
            *
            SQRT(
                POW(0.9, 2) +
                POW(0.8, 2) +
                POW(0.2, 2)
            )
        )
    ) AS cosine_similarity
FROM Books
ORDER BY cosine_similarity DESC;