USE bookflow_db;

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO loans (loan_id, member_id, book_id, loan_date) VALUES
(101, 1, 1, '2025-01-05'),
(102, 2, 2, '2025-01-10'),
(103, 3, 3, '2025-01-20'),
(104, 1, 2, '2025-02-01'),
(105, 2, 1, '2025-02-05'),
(106, 3, 2, '2025-03-01'),
(107, 1, 3, '2025-03-07'),
(108, 2, 3, '2025-03-15'),
(109, 3, 1, '2025-04-01'),
(110, 1, 1, '2025-04-15');

SELECT * FROM loans;

SELECT
    m.full_name AS Member_Name,
    b.title AS Book_Title,
    l.loan_date
FROM loans l
INNER JOIN members m
ON l.member_id = m.member_id
INNER JOIN books b
ON l.book_id = b.book_id;

SELECT
    published_year,
    COUNT(book_id) AS Total_Books
FROM books
GROUP BY published_year
ORDER BY published_year;
CREATE TABLE donation_history (
    donation_id INT PRIMARY KEY,
    book_id INT,
    donor_name VARCHAR(100),
    donation_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO donation_history
(donation_id, book_id, donor_name, donation_date)
VALUES
(1, 1, 'Mohammad Rehan', '2026-08-04');

SELECT * FROM donation_history;
