CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE categories
(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE suppliers
(
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products
(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL REFERENCES categories(category_id),
    supplier_id INT NOT NULL REFERENCES suppliers(supplier_id),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE inventory
(
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL UNIQUE REFERENCES products(product_id),
    stock_quantity INT NOT NULL
);

CREATE TABLE orders
(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE order_items
(
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE payments
(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL REFERENCES orders(order_id),
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL
);

CREATE TABLE order_audit_log
(
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL REFERENCES orders(order_id),
    action VARCHAR(50) NOT NULL,
    action_time DATETIME NOT NULL
);

-- Insert data into all tables --
USE ecommerce_db;
INSERT INTO customers(name,email,phone,address,city,status)
VALUES
('Amit Shah','amit@gmail.com','9876500001','Street 1','Ahmedabad','Active'),
('Neha Patel','neha@gmail.com','9876500002','Street 2','Surat','Active'),
('Rahul Mehta','rahul@gmail.com','9876500003','Street 3','Rajkot','Inactive'),
('Priya Joshi','priya@gmail.com','9876500004','Street 4','Vadodara','Active'),
('Karan Desai','karan@gmail.com','9876500005','Street 5','Bhavnagar','Active'),
('Sneha Trivedi','sneha@gmail.com','9876500006','Street 6','Jamnagar','Inactive'),
('Rohit Patel','rohit@gmail.com','9876500007','Street 7','Surendranagar','Active'),
('Pooja Shah','pooja@gmail.com','9876500008','Street 8','Morbi','Active'),
('Vikas Parmar','vikas@gmail.com','9876500009','Street 9','Junagadh','Active'),
('Anjali Dave','anjali@gmail.com','9876500010','Street 10','Gandhinagar','Inactive');

INSERT INTO categories(category_name,description)
VALUES
('Electronics','Electronic products'),
('Clothing','Clothing products'),
('Books','Books and study material'),
('Furniture','Furniture products'),
('Groceries','Daily grocery items');

INSERT INTO suppliers(supplier_name,email,phone,city)
VALUES
('TechWorld','techworld@gmail.com','9876500001','Ahmedabad'),
('FashionHub','fashionhub@gmail.com','9876500002','Surat'),
('BookStore','bookstore@gmail.com','9876500003','Rajkot'),
('HomeDecor','homedecor@gmail.com','9876500004','Vadodara'),
('FreshMart','freshmart@gmail.com','9876500005','Surendranagar');

INSERT INTO products(product_name,category_id,supplier_id,price)
VALUES
('Laptop',1,1,65000.00),
('Smartphone',1,1,25000.00),
('Headphones',1,1,3000.00),
('Smart Watch',1,1,7000.00),
('Keyboard',1,1,1200.00),
('T-Shirt',2,2,799.00),
('Jeans',2,2,1800.00),
('Shirt',2,2,1200.00),
('Jacket',2,2,3500.00),
('Hoodie',2,2,2200.00),
('Java Book',3,3,550.00),
('Python Book',3,3,650.00),
('SQL Book',3,3,500.00),
('Data Science Book',3,3,900.00),
('AI Basics Book',3,3,750.00),
('Office Chair',4,4,4500.00),
('Study Table',4,4,6000.00),
('Bookshelf',4,4,3500.00),
('Sofa',4,4,25000.00),
('Wardrobe',4,4,18000.00),
('Rice Bag',5,5,1200.00),
('Wheat Flour',5,5,600.00),
('Sugar',5,5,300.00),
('Cooking Oil',5,5,180.00),
('Tea Powder',5,5,450.00);

INSERT INTO inventory(product_id,stock_quantity)
VALUES
(1,20),(2,15),(3,40),(4,18),(5,30),
(6,50),(7,35),(8,25),(9,12),(10,20),
(11,45),(12,30),(13,40),(14,18),(15,22),
(16,10),(17,8),(18,15),(19,5),(20,7),
(21,60),(22,50),(23,80),(24,70),(25,40);

INSERT INTO orders(customer_id,order_date,total_amount,status)
VALUES
(1,'2026-07-01',68000.00,'Delivered'),
(2,'2026-07-02',2599.00,'Pending'),
(3,'2026-07-03',1450.00,'Delivered'),
(4,'2026-07-04',4500.00,'Cancelled'),
(5,'2026-07-05',1980.00,'Delivered'),
(6,'2026-07-06',1200.00,'Pending'),
(7,'2026-07-07',25000.00,'Delivered'),
(8,'2026-07-08',3300.00,'Delivered'),
(9,'2026-07-09',7800.00,'Pending'),
(10,'2026-07-10',18000.00,'Delivered'),
(1,'2026-07-11',900.00,'Delivered'),
(2,'2026-07-12',600.00,'Pending'),
(3,'2026-07-13',3500.00,'Delivered'),
(4,'2026-07-14',1200.00,'Cancelled'),
(5,'2026-07-15',750.00,'Delivered');

INSERT INTO order_items(order_id,product_id,quantity,price)
VALUES
(1,1,1,65000),(1,5,1,1200),(2,6,2,799),(2,10,1,2200),
(3,11,1,550),(3,12,1,650),(3,13,1,500),(4,16,1,4500),
(5,7,1,1800),(5,24,1,180),(6,21,1,1200),(7,19,1,25000),
(8,3,1,3000),(8,25,1,450),(9,4,1,7000),(9,23,2,300),(10,20,1,18000),
(11,14,1,900),(12,22,1,600),(13,18,1,3500),(14,8,1,1200),(15,15,1,750);

INSERT INTO payments(order_id,payment_date,amount,payment_method,payment_status)
VALUES
(1,'2026-07-01',68000,'Card','Success'),
(2,'2026-07-02',2599,'UPI','Pending'),
(3,'2026-07-03',1450,'Cash','Success'),
(4,'2026-07-04',4500,'Card','Failed'),
(5,'2026-07-05',1980,'UPI','Success'),
(6,'2026-07-06',1200,'Cash','Pending'),
(7,'2026-07-07',25000,'Net Banking','Success'),
(8,'2026-07-08',3450,'Card','Success'),
(9,'2026-07-09',7600,'UPI','Pending'),
(10,'2026-07-10',18000,'Net Banking','Success'),
(11,'2026-07-11',900,'Cash','Success'),
(12,'2026-07-12',600,'UPI','Pending'),
(13,'2026-07-13',3500,'Card','Success'),
(14,'2026-07-14',1200,'Cash','Failed'),
(15,'2026-07-15',750,'UPI','Success');

INSERT INTO order_audit_log(order_id,action,action_time)
VALUES
(1,'Order Created','2026-07-01 09:00:00'),
(2,'Order Created','2026-07-02 10:15:00'),
(3,'Order Delivered','2026-07-03 17:30:00'),
(4,'Order Cancelled','2026-07-04 12:10:00'),
(5,'Order Delivered','2026-07-05 18:00:00'),
(6,'Order Created','2026-07-06 09:40:00'),
(7,'Order Delivered','2026-07-07 20:15:00'),
(8,'Order Delivered','2026-07-08 16:30:00'),
(9,'Order Created','2026-07-09 11:20:00'),
(10,'Order Delivered','2026-07-10 19:00:00'),
(11,'Order Delivered','2026-07-11 14:00:00'),
(12,'Order Created','2026-07-12 09:30:00'),
(13,'Order Delivered','2026-07-13 17:10:00'),
(14,'Order Cancelled','2026-07-14 13:20:00'),
(15,'Order Delivered','2026-07-15 18:40:00');

-- Q-1.Create a view that displays all active customers. 
CREATE VIEW active_customers AS
SELECT * FROM customers WHERE status='Active';
SELECT * FROM active_customers;  

 -- Q-2.Create a view showing monthly sales summary.
 USE ecommerce_db;
CREATE VIEW monthly_sales_summary AS
SELECT
YEAR(order_date) year,
MONTH(order_date) month,
COUNT(*) total_orders,
SUM(total_amount) total_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);
SELECT * FROM monthly_sales_summary;

-- Q-3.Create a view displaying top-selling products.
USE ecommerce_db;
CREATE VIEW top_selling_products AS
SELECT p.product_name, SUM(oi.quantity) total_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC;
SELECT * FROM top_selling_products; 

-- Q-4.Create a view showing customer order history. 
USE ecommerce_db;
CREATE VIEW customer_order_history AS
SELECT c.name, o.order_id, o.order_date, o.total_amount, p.payment_status
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id;

SELECT * FROM customer_order_history;

-- Q-5. Create a view showing products with low stock. 
USE ecommerce_db;
CREATE VIEW low_stock_products AS
SELECT p.product_name, i.stock_quantity
FROM products p
JOIN inventory i
ON p.product_id = i.product_id
WHERE i.stock_quantity < 10;

SELECT * FROM low_stock_products;

-- Q-6. Create an index on customers(email) and compare query execution before and after. 
-- Before creating index
SELECT * FROM customers WHERE email = 'amit@gmail.com';
-- Create index
CREATE INDEX idx_customer_email ON customers(email);
-- After creating index
SELECT * FROM customers WHERE email = 'amit@gmail.com';

-- Q-7.Create a composite index on (customer_id, order_date). 
USE ecommerce_db;
CREATE INDEX idx_customer_orderdate
ON orders(customer_id, order_date);
SHOW INDEX FROM orders;

-- Q-8.Find three slow queries and optimize them using indexes.
-- slow1: search by city
SELECT * FROM customers WHERE city='Surat'; CREATE INDEX idx_city ON customers(city);
-- slow2: filter orders by status
SELECT * FROM orders WHERE status='Pending'; CREATE INDEX idx_status ON orders(status);
-- slow3: low stock products
SELECT * FROM inventory WHERE stock_quantity<10; CREATE INDEX idx_stock ON inventory(stock_quantity);

-- Q-9.Write a report explaining which columns should be indexed and why.
-- customers.city - filter ke liye - index ban gaya
-- orders.status - filter ke liye - index ban gaya  
-- order_items.product_id - join ke liye
CREATE INDEX idx_oi_pid ON order_items(product_id);

-- Q-10.Use EXPLAIN on five queries and explain the execution plan.
EXPLAIN SELECT * FROM customers WHERE city='Surat';
EXPLAIN SELECT * FROM orders WHERE customer_id=1;
EXPLAIN SELECT * FROM inventory WHERE stock_quantity<10;
EXPLAIN SELECT * FROM products WHERE price>5000;
EXPLAIN SELECT * FROM order_items WHERE order_id=1;

-- Q-11.Create a stored procedure to retrieve all orders for a customer.
DELIMITER $$
CREATE PROCEDURE getorders(IN cid INT)
BEGIN
SELECT * FROM orders WHERE customer_id=cid;
END$$
DELIMITER ;
CALL getorders(9);

-- Q-12.Create a stored procedure to calculate total sales for a given month
DELIMITER $$
CREATE PROCEDURE monthsales(IN m INT)
BEGIN
    SELECT SUM(total_amount) AS total
    FROM orders
    WHERE MONTH(order_date) = m;
END $$
DELIMITER ;
CALL monthsales(7);

-- Q-13.Create a stored procedure that returns the top 10 customers based on spending.
DELIMITER $$
CREATE PROCEDURE top10()
BEGIN
SELECT c.name,SUM(o.total_amount) AS total 
FROM customers c JOIN orders o ON c.customer_id=o.customer_id 
GROUP BY c.customer_id ORDER BY total DESC LIMIT 10;
END$$
DELIMITER ;
CALL top10();

-- Q-14. Create a stored procedure to update product prices by a given percentage.
DROP PROCEDURE IF EXISTS priceup;
DELIMITER $$
CREATE PROCEDURE priceup()
BEGIN
    UPDATE products
    SET price = price + 100;
END $$
DELIMITER ;
SET SQL_SAFE_UPDATES = 0;
CALL priceup();
SELECT product_id, product_name, price
FROM products;
SET SQL_SAFE_UPDATES = 1;


-- Q-15.Create a stored procedure that applies tiered discounts
DELIMITER $$
CREATE PROCEDURE discountprice()
BEGIN
    UPDATE products
    SET price = CASE
        WHEN price > 5000 THEN ROUND(price * 0.90, 2)
        WHEN price > 1000 THEN ROUND(price * 0.95, 2)
        ELSE price
    END;
END $$
DELIMITER ;
SET SQL_SAFE_UPDATES = 0;
CALL discountprice();
SELECT product_id, product_name, price
FROM products;
SET SQL_SAFE_UPDATES = 1;

-- Q-16.Create a function to calculate order total including GST.
DELIMITER $$
CREATE FUNCTION gst(oid INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE t DECIMAL(10,2) DEFAULT 0;
SELECT SUM(quantity*price) INTO t FROM order_items WHERE order_id=oid;
RETURN t*1.18;
END$$
DELIMITER ;
SELECT gst(8);

-- Q-17.Create a function to calculate customer age from date of birth.
ALTER TABLE customers ADD COLUMN dob DATE;
DELIMITER $$
CREATE FUNCTION getage(dob DATE) RETURNS INT
DETERMINISTIC
BEGIN
RETURN TIMESTAMPDIFF(YEAR,dob,CURDATE());
END$$
DELIMITER ;
SELECT getage('2003-05-10');

-- Q-18.Create a function that returns the total number of orders for a customer.
DELIMITER $$
CREATE FUNCTION totorders(cid INT) RETURNS INT
DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(*) FROM orders WHERE customer_id=cid);
END$$
DELIMITER ;
SELECT totorders(1);

-- Q-19.Create a function that returns product stock status
DELIMITER $$
CREATE FUNCTION stockstatus(pid INT) RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE s INT DEFAULT 0;
SELECT stock_quantity INTO s FROM inventory WHERE product_id=pid;
IF s=0 THEN RETURN 'Out of Stock';
ELSEIF s<10 THEN RETURN 'Low Stock';
ELSE RETURN 'In Stock';
END IF;
END$$
DELIMITER ;
SELECT stockstatus(5);

-- Q-20.Create a function that calculates total revenue generated by a product.
DELIMITER $$
CREATE FUNCTION revenue(pid INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN (SELECT SUM(quantity*price) FROM order_items WHERE product_id=pid);
END$$
DELIMITER ;
SELECT revenue(8);

-- Q-21.Create a trigger that automatically updates product stock when an order is placed.
DELIMITER $$
CREATE TRIGGER updatestock AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
UPDATE inventory SET stock_quantity=stock_quantity-NEW.quantity WHERE product_id=NEW.product_id;
END$$
DELIMITER ;


-- Q-22.Create a trigger that records every new order in an audit table.
DELIMITER $$
CREATE TRIGGER neworder AFTER INSERT ON orders
FOR EACH ROW
BEGIN
INSERT INTO order_audit_log(order_id,action,action_time) VALUES(NEW.order_id,'Order Created',NOW());
END$$
DELIMITER ;

-- Q-23.Create a trigger that logs old and new prices whenever a product price changes.
CREATE TABLE IF NOT EXISTS price_log(pid INT,oldp DECIMAL(10,2),newp DECIMAL(10,2),dt DATETIME);
DELIMITER $$
CREATE TRIGGER pricelog BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
IF OLD.price <> NEW.price THEN
INSERT INTO price_log VALUES(OLD.product_id,OLD.price,NEW.price,NOW());
END IF;
END$$
DELIMITER ;

-- Q-24.Create a trigger that prevents negative stock quantities.
DELIMITER $$
CREATE TRIGGER nostock BEFORE UPDATE ON inventory
FOR EACH ROW
BEGIN
IF NEW.stock_quantity<0 THEN SET NEW.stock_quantity=0; END IF;
END$$
DELIMITER ;

-- Q-25.Create a trigger that records every INSERT, UPDATE, and DELETE on the orders table
USE ecommerce_db;
DELIMITER $$
CREATE TRIGGER auditins AFTER INSERT ON orders
FOR EACH ROW
BEGIN
INSERT INTO order_audit_log(order_id,action,action_time) VALUES(NEW.order_id,'INSERT',NOW());
END$$
CREATE TRIGGER auditupd AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
INSERT INTO order_audit_log(order_id,action,action_time) VALUES(NEW.order_id,'UPDATE',NOW());
END$$
CREATE TRIGGER auditdel AFTER DELETE ON orders
FOR EACH ROW
BEGIN
INSERT INTO order_audit_log(order_id,action,action_time) VALUES(OLD.order_id,'DELETE',NOW());
END$$
DELIMITER ;

-- Q-26.Write a deliberately slow query on a table containing 500+ rows.
SELECT * FROM orders o,customers c WHERE o.customer_id=c.customer_id;
EXPLAIN SELECT * FROM orders o,customers c WHERE o.customer_id=c.customer_id;
CREATE INDEX idx_cid ON orders(customer_id);
EXPLAIN SELECT * FROM orders o JOIN customers c ON o.customer_id=c.customer_id;

-- Q-27.Create an order_audit_log table and use triggers to maintain it automatically
USE ecommerce_db;
DELIMITER $$
-- Log INSERT
CREATE TRIGGER order_insert_audit
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit_log(order_id, action, action_time)
    VALUES (NEW.order_id, 'INSERT', NOW());
END$$
-- Log UPDATE
CREATE TRIGGER order_update_audit
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit_log(order_id, action, action_time)
    VALUES (NEW.order_id, 'UPDATE', NOW());
END$$
-- Log DELETE
CREATE TRIGGER order_delete_audit
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit_log(order_id, action, action_time)
    VALUES (OLD.order_id, 'DELETE', NOW());
END$$
DELIMITER ;


-- Q-28.Write a stored procedure that Accepts a customer ID.Calculates total order value.Applies tiered discounts
DELIMITER $$
CREATE PROCEDURE finalamt(IN cid INT)
BEGIN
DECLARE t DECIMAL(10,2) DEFAULT 0;
SELECT SUM(total_amount) INTO t FROM orders WHERE customer_id=cid;
IF t>10000 THEN SELECT t AS total,t*0.9 AS final;
ELSEIF t>5000 THEN SELECT t AS total,t*0.95 AS final;
ELSE SELECT t AS total,t AS final;
END IF;
END$$
DELIMITER ;

-- Q-29.Prepare an Index Recommendation Report for the e-commerce database
-- customers.city - filter - single index
-- orders.status - filter - single index  
-- order_items.product_id - join - single index
-- inventory.stock_quantity - report - single index
SHOW INDEX FROM customers;
SHOW INDEX FROM orders;
SHOW INDEX FROM order_items;
SHOW INDEX FROM inventory;

