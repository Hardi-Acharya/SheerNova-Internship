-- Q-1.
ALTER TABLE customers ADD COLUMN wallet_balance DECIMAL(10,2) NOT NULL DEFAULT 1000.00;
ALTER TABLE customers ADD CONSTRAINT chk_wallet_balance CHECK (wallet_balance >= 0);
UPDATE customers SET wallet_balance = 10000.00 WHERE customer_id = 1;
UPDATE customers SET wallet_balance = 2000.00 WHERE customer_id = 2;
UPDATE customers SET wallet_balance = 2500.00 WHERE customer_id = 3;
UPDATE customers SET wallet_balance = 3000.00 WHERE customer_id = 4;
UPDATE customers SET wallet_balance = 1500.00 WHERE customer_id = 5;
START TRANSACTION;
-- A. Customer 1 ke account se ₹5,000 debit (kam) karna
UPDATE customers SET wallet_balance = wallet_balance - 5000.00 WHERE customer_id = 1;
-- B. Customer 2 ke account mein ₹5,000 credit karna
UPDATE customers SET wallet_balance = wallet_balance + 5000.00 WHERE customer_id = 2;
COMMIT;
SELECT customer_id, name, wallet_balance FROM customers WHERE customer_id IN (1, 2,3,4,5);

-- Q-2.
START TRANSACTION;
-- Step A: Customer 1 se 10,000 debit karna it shows error 
-- ERROR: MySQL yahan "Check constraint 'chk_wallet_balance' is violated" ka error dega!
UPDATE customers SET wallet_balance = wallet_balance - 10000.00 WHERE customer_id = 1;
-- Step B: Customer 2 ke account mein ₹10,000 credit karna
UPDATE customers SET wallet_balance = wallet_balance + 10000.00  WHERE customer_id = 2;
-- Kyunki upar error aa gaya, hum changes ko cancel karne ke liye ROLLBACK chalayenge
ROLLBACK;
-- ROLLBACK ke baad ka final balance check
SELECT customer_id, name, wallet_balance FROM customers WHERE customer_id IN (1, 2);

-- Q-3.
USE ecommerce_db;
START TRANSACTION;
-- Check Stock
SELECT stock_quantity
FROM inventory
WHERE product_id = 1;
-- If stock is sufficient, execute the following statements
-- Create Order
INSERT INTO orders(customer_id, order_date, total_amount, status)
VALUES (1, CURDATE(), 129060.00, 'Pending');
-- Get New Order ID
SET @order_id = LAST_INSERT_ID();
-- Add Order Item
INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES (@order_id, 1, 2, 64530.00);
-- Decrease Inventory
UPDATE inventory SET stock_quantity = stock_quantity - 2 WHERE product_id = 1;
-- Add Payment
INSERT INTO payments(order_id, payment_date, amount, payment_method, payment_status)
VALUES (@order_id, CURDATE(), 129060.00, 'UPI', 'Paid');
-- If all statements are successful
COMMIT;
-- If stock is insufficient or any error occurs
ROLLBACK;

-- Q-4.
USE ecommerce_db;
SET AUTOCOMMIT = 0;
START TRANSACTION;
-- Order Item 1
INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES (1, 1, 1, 64530.00);
SAVEPOINT sp1;
-- Order Item 2
INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES (1, 2, 2, 24930.00);
SAVEPOINT sp2;
-- Order Item 3
INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES (1, 3, 1, 3325.00);
-- Roll back only the third insert
ROLLBACK TO sp2;
-- Commit only first two inserts
COMMIT;
SET AUTOCOMMIT = 1;
-- Verify
SELECT * FROM order_items WHERE order_id = 1;

-- Q-5.
USE ecommerce_db;
SET AUTOCOMMIT = 0;
START TRANSACTION;
UPDATE products SET price = price + 500 WHERE product_id = 1;
SELECT * FROM products WHERE product_id = 1;
COMMIT;

-- Q-6.
USE ecommerce_db;
SET autocommit=0;
START TRANSACTION;
UPDATE products SET price=99999 WHERE product_id=1;
COMMIT;

-- Q-7.
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT price FROM products WHERE product_id=1;
COMMIT;

-- ============================================
-- DAY 4: TRANSACTIONS, INTEGRITY, NORMALIZATION
-- DB: Use your existing DB
-- ============================================
USE your_db_name; -- apna DB name dalo

-- ============ TASK 8: PHANTOM READ DEMO ============
-- Session 1:
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT * FROM products WHERE price BETWEEN 1000 AND 2000; -- Query 1

-- Session 2: 
INSERT INTO products(product_name, category_id, supplier_id, price) 
VALUES ('Phantom Mouse', 1, 1, 1500); 
COMMIT;

-- Session 1:
SELECT * FROM products WHERE price BETWEEN 1000 AND 2000; -- Query 2. New row appears = Phantom
COMMIT;

-- ============ TASK 9: ISOLATION LEVEL MATRIX ============
/*
MySQL 8.0 InnoDB Actual Behavior:

| Isolation Level    | Dirty Read | Non-Repeatable Read | Phantom Read |
|--------------------|------------|---------------------|--------------|
| READ UNCOMMITTED   | Possible   | Possible            | Possible     |
| READ COMMITTED     | Not Possible| Possible           | Possible     |
| REPEATABLE READ    | Not Possible| Not Possible       | Not Possible*|
| SERIALIZABLE       | Not Possible| Not Possible       | Not Possible |

*Difference: SQL Standard says REPEATABLE READ allows Phantom.
But InnoDB uses Next-Key Locks, so Phantom is blocked in RR.
*/

-- ============ TASK 10: DEADLOCK ============
-- Session A:
START TRANSACTION;
SELECT * FROM inventory WHERE inventory_id=1 FOR UPDATE; -- lock row 1
SELECT SLEEP(3);
SELECT * FROM inventory WHERE inventory_id=2 FOR UPDATE; -- lock row 2
COMMIT;

-- Session B:
START TRANSACTION;
SELECT * FROM inventory WHERE inventory_id=2 FOR UPDATE; -- lock row 2
SELECT SLEEP(3);
SELECT * FROM inventory WHERE inventory_id=1 FOR UPDATE; -- lock row 1 -> DEADLOCK
COMMIT;
-- Error: ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction
-- Report: SHOW ENGINE INNODB STATUS\G

-- ============ TASK 11: FIX DEADLOCK ============
-- Session A & B both: Always lock in same order: 1 then 2
START TRANSACTION;
SELECT * FROM inventory WHERE inventory_id=1 FOR UPDATE;
SELECT * FROM inventory WHERE inventory_id=2 FOR UPDATE;
COMMIT;
-- Result: No deadlock

-- ============ TASK 12: LOST UPDATE ============
-- Setup: UPDATE inventory SET stock_quantity=1 WHERE inventory_id=1;

-- LOST UPDATE - BAD
-- Session A: UPDATE inventory SET stock_quantity = stock_quantity - 1 WHERE inventory_id=1;
-- Session B: UPDATE inventory SET stock_quantity = stock_quantity - 1 WHERE inventory_id=1;
-- Result: stock_quantity = -1

-- FIX: PESSIMISTIC LOCKING
START TRANSACTION;
SELECT stock_quantity FROM inventory WHERE inventory_id=1 FOR UPDATE;
UPDATE inventory SET stock_quantity = stock_quantity - 1 WHERE inventory_id=1;
COMMIT;

-- ============ TASK 13: OPTIMISTIC LOCKING ============
ALTER TABLE inventory ADD COLUMN version INT DEFAULT 1;
UPDATE inventory SET stock_quantity = stock_quantity - 1, version = version + 1 
WHERE inventory_id=1 AND version=1; -- if affected_rows=0 then retry
/*
Optimistic: Use when low contention, read-heavy. No locks, better performance.
Pessimistic: Use when high contention, financial data. Prevents conflicts.
*/

-- ============ TASK 14: CHECK CONSTRAINTS ============
ALTER TABLE products ADD CONSTRAINT chk_price CHECK (price > 0);
ALTER TABLE inventory ADD CONSTRAINT chk_qty CHECK (stock_quantity >= 0);
ALTER TABLE orders ADD CONSTRAINT chk_status CHECK (status IN ('PENDING','PAID','SHIPPED','CANCELLED'));

-- Violations:
INSERT INTO products(product_name, category_id, supplier_id, price) VALUES ('Test',1,1,-100);
-- ERROR 3819 (HY000): Check constraint 'chk_price' is violated.

INSERT INTO inventory(product_id, stock_quantity) VALUES (999, -5);
-- ERROR 3819 (HY000): Check constraint 'chk_qty' is violated.

INSERT INTO orders(customer_id, order_date, total_amount, status) VALUES (1, CURDATE(), 100, 'INVALID');
-- ERROR 3819 (HY000): Check constraint 'chk_status' is violated.

-- ============ TASK 15: FK CASCADE & SET NULL ============
ALTER TABLE order_items ADD CONSTRAINT fk_oi_order 
FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

-- Demo: DELETE FROM orders WHERE order_id=1; -- order_items auto deleted

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1; -- default name, apna check kar lena
ALTER TABLE orders ADD CONSTRAINT fk_orders_customer 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;

-- Demo: DELETE FROM customers WHERE customer_id=1; -- orders.customer_id becomes NULL
-- RESTRICT: ERROR 1451: Cannot delete or update a parent row
-- Answer: E-commerce me RESTRICT/SET NULL sahi. Order history delete nahi honi chahiye.

-- ============ TASK 16: COMPOSITE PK & UNIQUE ============
ALTER TABLE order_items DROP PRIMARY KEY;
ALTER TABLE order_items ADD PRIMARY KEY (order_id, product_id);

INSERT INTO order_items(order_id, product_id, quantity, price) VALUES (1, 1, 2, 100);
INSERT INTO order_items(order_id, product_id, quantity, price) VALUES (1, 1, 3, 100);
-- ERROR 1062 (23000): Duplicate entry '1-1' for key 'PRIMARY'

ALTER TABLE customers ADD CONSTRAINT uq_email UNIQUE (email);
-- Diff: UNIQUE constraint = logical rule. UNIQUE index = physical structure to enforce it.

-- ============ TASK 17: NORMALIZATION ============
/*
1NF: Remove repeating groups. Split products,quantities,unit_prices into rows
Table: sales_1nf(order_id, customer_name, customer_email, customer_city, product, quantity, unit_price, order_date, supplier_name, supplier_phone)
Dependency removed: Repeating group / Multi-valued attribute

2NF: Remove partial dependency. customer_name, customer_city depends on customer_email not order_id
Tables: customers(customer_email PK, customer_name, customer_city)
        orders(order_id PK, customer_email FK, order_date, supplier_name FK)
        sales_2nf(order_id FK, product, quantity, unit_price)
Dependency removed: customer details -> customer_email

3NF: Remove transitive dependency. supplier_phone depends on supplier_name not order_id
Tables: suppliers(supplier_name PK, supplier_phone)
        orders(order_id PK, customer_email FK, order_date, supplier_name FK)
Dependency removed: supplier_phone -> supplier_name
*/

-- ============ TASK 18: DENORMALIZED TABLE ============
CREATE TABLE daily_sales_summary (
    sale_date DATE,
    category_name VARCHAR(100),
    total_revenue DECIMAL(12,2),
    PRIMARY KEY (sale_date, category_name)
);

INSERT INTO daily_sales_summary
SELECT o.order_date, c.category_name, SUM(oi.quantity * oi.price)
FROM orders o 
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
JOIN categories c ON p.category_id=c.category_id
GROUP BY o.order_date, c.category_name;

-- ============ TASK 19: UPSERT ============
INSERT INTO inventory (product_id, stock_quantity) VALUES (1, 5)
ON DUPLICATE KEY UPDATE stock_quantity = stock_quantity + VALUES(stock_quantity);
-- Run twice. Quantity adds up.

-- ============ TASK 20: PIVOT ============
SELECT 
c.category_name,
SUM(CASE WHEN MONTH(o.order_date)=1 THEN oi.quantity*oi.price ELSE 0 END) AS Jan,
SUM(CASE WHEN MONTH(o.order_date)=2 THEN oi.quantity*oi.price ELSE 0 END) AS Feb,
SUM(CASE WHEN MONTH(o.order_date)=12 THEN oi.quantity*oi.price ELSE 0 END) AS Dec
FROM orders o 
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
JOIN categories c ON p.category_id=c.category_id
GROUP BY c.category_name;

-- ============ TASK 21: SECURITY ============
CREATE USER IF NOT EXISTS 'reporting_user'@'%' IDENTIFIED BY 'Report@123';
GRANT SELECT ON your_db_name.monthly_sales_summary TO 'reporting_user'@'%';
GRANT SELECT ON your_db_name.top_selling_products TO 'reporting_user'@'%';
GRANT SELECT ON your_db_name.low_stock_products TO 'reporting_user'@'%';
FLUSH PRIVILEGES;
-- Test: INSERT INTO orders... ERROR 1142: INSERT command denied

-- Prepared Statement to prevent SQL Injection
PREPARE stmt FROM 'SELECT * FROM products WHERE product_name = ?';
SET @name = 'Laptop';
EXECUTE stmt USING @name;
-- Prevents: ' OR '1'='1 injection

-- -----------------Task-22-------------------------------
USE ecommerce_db;

DROP PROCEDURE IF EXISTS sp_place_order;

DELIMITER $$

CREATE PROCEDURE sp_place_order(
IN p_customer_id INT,
IN p_product_id INT,
IN p_qty INT,
OUT p_final_amount DECIMAL(10,2)
)
BEGIN

DECLARE v_stock INT;
DECLARE v_price DECIMAL(10,2);
DECLARE v_total DECIMAL(10,2);
DECLARE v_order_id INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
END;

START TRANSACTION;

SELECT stock_quantity
INTO v_stock
FROM inventory
WHERE product_id=p_product_id
FOR UPDATE;

IF v_stock<p_qty THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Not enough stock';
END IF;

SELECT price
INTO v_price
FROM products
WHERE product_id=p_product_id;

SET v_total=v_price*p_qty;

IF v_total>10000 THEN
SET p_final_amount=v_total-(v_total*0.10);

ELSEIF v_total>5000 THEN
SET p_final_amount=v_total-(v_total*0.05);

ELSE
SET p_final_amount=v_total;
END IF;

INSERT INTO orders(customer_id,order_date,total_amount,status)
VALUES(p_customer_id,NOW(),p_final_amount,'Placed');

SET v_order_id=LAST_INSERT_ID();

INSERT INTO order_items(order_id,product_id,quantity,price)
VALUES(v_order_id,p_product_id,p_qty,v_price);

UPDATE inventory
SET stock_quantity=stock_quantity-p_qty
WHERE product_id=p_product_id;

INSERT INTO payments(order_id,payment_date,amount,payment_method,status)
VALUES(v_order_id,NOW(),p_final_amount,'UPI','Paid');

INSERT INTO order_audit_log(order_id,action,action_time)
VALUES(v_order_id,'Order Placed',NOW());

COMMIT;

END$$

DELIMITER ;

CALL sp_place_order(1,1,2,@amt);
SELECT @amt;
UPDATE inventory
SET stock_quantity=10
WHERE product_id=1;
COMMIT;
SELECT stock_quantity
FROM inventory
WHERE product_id=1;