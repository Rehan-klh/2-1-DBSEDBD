USE bookflow_db;

CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

ALTER TABLE bank_transactions
ADD account_no VARCHAR(20);	
DESCRIBE bank_transactions;

ALTER TABLE bank_transactions
MODIFY customer_name VARCHAR(100);
DESCRIBE bank_transactions;

RENAME TABLE bank_transactions
TO customer_transactions;
SHOW TABLES;

TRUNCATE TABLE customer_transactions;
DESCRIBE customer_transactions;