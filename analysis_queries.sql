-- ============================================
-- INTERNSHIP TASK 2
-- DATA ANALYSIS WITH COMPLEX SQL QUERIES
-- DATABASE: MySQL 8+
-- ============================================

-- Create Database
CREATE DATABASE internship_analysis;
USE internship_analysis;

-- ============================================
-- Create Table
-- ============================================
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    amount INT
);

-- ============================================
-- Insert Sample Data
-- ============================================
INSERT INTO sales (sale_date, customer_name, product, amount) VALUES
('2024-01-01', 'Amit', 'Laptop', 50000),
('2024-01-05', 'Neha', 'Mobile', 20000),
('2024-01-10', 'Amit', 'Tablet', 15000),
('2024-02-01', 'Ravi', 'Laptop', 52000),
('2024-02-10', 'Neha', 'Laptop', 48000),
('2024-02-15', 'Amit', 'Mobile', 22000),
('2024-03-01', 'Ravi', 'Tablet', 18000),
('2024-03-10', 'Neha', 'Mobile', 21000);

-- ============================================
-- 1. WINDOW FUNCTION
-- Rank customers by total spending
-- ============================================
SELECT 
    customer_name,
    SUM(amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM sales
GROUP BY customer_name;

-- ============================================
-- 2. WINDOW FUNCTION
-- Running total of sales over time
-- ============================================
SELECT 
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date) AS running_total
FROM sales;

-- ============================================
-- 3. SUBQUERY
-- Customers whose total spending is above average
-- ============================================
SELECT customer_name
FROM sales
GROUP BY customer_name
HAVING SUM(amount) > (
    SELECT AVG(amount)
    FROM sales
);

-- ============================================
-- 4. CTE (Common Table Expression)
-- Monthly sales analysis
-- ============================================
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(sale_date, '%Y-%m') AS month,
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY month
)
SELECT *
FROM monthly_sales
ORDER BY total_sales DESC;

-- ============================================
-- 5. CTE + WINDOW FUNCTION
-- Top-selling product per month
-- ============================================
WITH product_sales AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS month,
        product,
        SUM(amount) AS total_amount
    FROM sales
    GROUP BY month, product
)
SELECT 
    month,
    product,
    total_amount,
    RANK() OVER (PARTITION BY month ORDER BY total_amount DESC) AS product_rank
FROM product_sales;

