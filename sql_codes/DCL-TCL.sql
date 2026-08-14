USE bookflow_db;

CREATE USER IF NOT EXISTS 'Auditor1'@'localhost'
IDENTIFIED BY 'Auditor@123';

CREATE USER IF NOT EXISTS 'BranchManager'@'localhost'
IDENTIFIED BY 'Manager@123';

GRANT SELECT
ON bookflow_db.bank_transactions
TO 'Auditor1'@'localhost';

GRANT ALL PRIVILEGES
ON bookflow_db.bank_transactions
TO 'BranchManager'@'localhost';

REVOKE SELECT
ON bookflow_db.bank_transactions
FROM 'Auditor1'@'localhost';

REVOKE ALL PRIVILEGES
ON bookflow_db.bank_transactions
FROM 'BranchManager'@'localhost';

UPDATE bank_transactions
SET amount = 6000
WHERE txn_id = 101;

COMMIT;

SAVEPOINT Before_Update;

UPDATE bank_transactions
SET amount = 99999
WHERE txn_id = 102;

ROLLBACK TO Before_Update;



















START TRANSACTION;

SAVEPOINT Before_Update;

UPDATE bank_transactions
SET amount = 99999
WHERE txn_id = 102;

ROLLBACK TO SAVEPOINT Before_Update;

COMMIT;