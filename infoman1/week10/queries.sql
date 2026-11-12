-- ===================================================
-- INFOMAN1 - Week 10: Safe DML & Data Integrity
-- ===================================================

CREATE DATABASE IF NOT EXISTS infoman1_bookstore;
USE infoman1_bookstore;

-- ---------------------------------------------------
-- Schema Setup & Seed Data
-- ---------------------------------------------------
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS sizes;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    sku VARCHAR(30),
    price DECIMAL(10,2),
    stock_quantity INT,
    status VARCHAR(20)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    manager_id INT
);

CREATE TABLE colors (
    color_name VARCHAR(30) PRIMARY KEY
);

CREATE TABLE sizes (
    size_name VARCHAR(10) PRIMARY KEY
);

INSERT INTO products (product_name, sku, price, stock_quantity, status) VALUES
('Notebook', 'NB-001', 45.00, 100, 'Active'),
('Ballpen', 'BP-001', 15.00, 250, 'Active'),
('USB Drive', 'USB-001', 350.00, 30, 'Active'),
('Ruler', 'RL-001', 25.00, 80, 'Active'),
('Eraser', 'ER-001', 10.00, 200, 'Active');

INSERT INTO sales (product_id, sale_date, quantity) VALUES
(1, '2026-08-10', 5),
(2, '2026-08-11', 10);

INSERT INTO employees VALUES
(1, 'Lea Ramos', NULL),
(2, 'Carlo Reyes', 1),
(3, 'Dana Cruz', 1);

INSERT INTO colors VALUES ('Red'), ('Blue'), ('Green');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');


-- ---------------------------------------------------
-- TASK 1: Safe INSERT
-- ---------------------------------------------------
-- Safe explicit column inserts
INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Scientific Calculator', 'CALC-SCI-001', 850.00, 20, 'Active');

SELECT * FROM products WHERE sku = 'CALC-SCI-001';

INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Compass', 'CMP-001', 120.00, 50, 'Active');

SELECT * FROM products WHERE sku = 'CMP-001';

-- Intentionally rejected insert (Will fail after Task 4 UNIQUE constraint is added)
-- INSERT INTO products (product_name, sku, price, stock_quantity, status) 
-- VALUES ('Duplicate Calculator', 'CALC-SCI-001', 900.00, 10, 'Active');


-- ---------------------------------------------------
-- TASK 2: UPDATE & DELETE Without Collateral Damage
-- ---------------------------------------------------
-- Update 2.1: Preview, Execute, Verify
SELECT product_id, product_name, price FROM products WHERE sku = 'CALC-SCI-001';

UPDATE products 
SET price = 875.00 
WHERE product_id = 6; -- Stable primary key identifier

SELECT product_id, product_name, price FROM products WHERE product_id = 6;

-- Delete 2.2: Preview, Execute, Verify
SELECT product_id, product_name, sku FROM products WHERE sku = 'ER-001';

DELETE FROM products 
WHERE product_id = 5; -- Stable primary key identifier

SELECT product_id, product_name FROM products WHERE product_id = 5;


-- ---------------------------------------------------
-- TASK 3: Self Join & Cross Join
-- ---------------------------------------------------
-- 3.1: Self Join (Employees & Managers)
SELECT 
    e.employee_id, 
    e.employee_name AS employee, 
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 3.2: Cross Join (Colors & Sizes Cartesian Product)
SELECT c.color_name, s.size_name
FROM colors c
CROSS JOIN sizes s;


-- ---------------------------------------------------
-- TASK 4: Constraints & Table Evolution
-- ---------------------------------------------------
-- 4.1 Evolution: Add contact_number
ALTER TABLE products ADD COLUMN contact_number VARCHAR(20);

-- 4.2 Enforce Rules via ALTER TABLE
ALTER TABLE products MODIFY product_name VARCHAR(100) NOT NULL;
ALTER TABLE products ADD CONSTRAINT unique_sku UNIQUE (sku);
ALTER TABLE products ADD CONSTRAINT check_positive_price CHECK (price > 0);

-- Testing Rules (Valid vs Invalid Writes)
-- Rule 1: NOT NULL (Passing write)
INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Stapler', 'STP-001', 150.00, 15, 'Active');

-- Rule 2: UNIQUE (Passing write)
INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Highlighter', 'HL-001', 35.00, 100, 'Active');

-- Rule 3: CHECK (Passing write)
INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Scissors', 'SCS-001', 65.00, 40, 'Active');