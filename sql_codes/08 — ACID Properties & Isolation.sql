USE BankDB;

START TRANSACTION;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10001;

SELECT *
FROM Account
WHERE Account_No = 10001;

COMMIT;

SELECT *
FROM Account
WHERE Account_No = 10001;

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 10000
WHERE Account_No = 10001;

SELECT *
FROM Account
WHERE Account_No = 10001;

ROLLBACK;

SELECT *
FROM Account
WHERE Account_No = 10001;

START TRANSACTION;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10001;

SAVEPOINT Deposit1;

UPDATE Account
SET Balance = Balance - 3000
WHERE Account_No = 10002;

SAVEPOINT Withdrawal1;

UPDATE Account
SET Balance = Balance + 10000
WHERE Account_No = 10003;

ROLLBACK TO SAVEPOINT Withdrawal1;

COMMIT;

SELECT *
FROM Account;

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 15000
WHERE Account_No = 10001;

UPDATE Account
SET Balance = Balance + 15000
WHERE Account_No = 10002;

SELECT *
FROM Account
WHERE Account_No IN (10001, 10002);

COMMIT;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No IN (10001, 10002);	

SELECT @@SESSION.transaction_isolation;