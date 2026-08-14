USE BankDB;

SELECT * FROM Customer;
SELECT * FROM Account;

INSERT INTO Customer
(Customer_ID, Customer_Name, Phone, Email, City)
VALUES
(106, 'Sreekar Varanasi', '9876543215', 'sreekar@gmail.com', 'Delhi'),
(107, 'Arnav Chitikena', '9876543216', 'arnav@gmail.com', 'Mumbai'),
(108, 'Keith Dudemeister', '9876543217', 'keith@gmail.com', 'Pune'),
(109, 'Molly Clock', '9876543218', 'molly@gmail.com', 'Hyderabad'),
(110, 'Aditya Kumar', '9876543219', 'aditya@gmail.com', 'Vijayawada');

INSERT INTO Account
(Account_No, Customer_ID, Account_Type, Balance, Branch)
VALUES
(10006, 106, 'Savings', 65000, 'Delhi'),
(10007, 107, 'Current', 150000, 'Mumbai'),
(10008, 108, 'Savings', 35000, 'Pune'),
(10009, 109, 'Savings', 85000, 'Hyderabad'),
(10010, 110, 'Current', 110000, 'Vijayawada');

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 10000),
(10001, 'WITHDRAW', 5000),
(10002, 'DEPOSIT', 15000),
(10003, 'WITHDRAW', 20000),
(10004, 'DEPOSIT', 5000),
(10005, 'WITHDRAW', 10000),
(10006, 'DEPOSIT', 12000),
(10007, 'DEPOSIT', 25000),
(10008, 'WITHDRAW', 5000),
(10009, 'DEPOSIT', 20000),
(10010, 'WITHDRAW', 15000);

INSERT INTO Loan
(Loan_ID, Customer_ID, Loan_Type, Loan_Amount, Interest_Rate)
VALUES
(505, 105, 'Home Loan', 4000000, 7.2),
(506, 106, 'Car Loan', 900000, 8.5),
(507, 107, 'Business Loan', 3000000, 9.0),
(508, 109, 'Personal Loan', 600000, 10.0);


CREATE VIEW Customer_Account_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    A.Balance
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID;

SELECT * FROM Customer_Account_View;

CREATE VIEW Savings_Above_50000 AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
WHERE Account_Type = 'Savings'
AND Balance > 50000;

SELECT * FROM Savings_Above_50000;

CREATE VIEW Customer_Loan_Account_View AS
SELECT
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    L.Loan_Type,
    L.Loan_Amount
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customer_Loan_Account_View;

CREATE VIEW Branch_Total_Balance_Practical AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch;

SELECT * FROM Branch_Total_Balance_Practical;

CREATE VIEW Loan_Interest_Practical AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    (Loan_Amount * Interest_Rate / 100) AS Annual_Interest
FROM Loan;

SELECT * FROM Loan_Interest_Practical;