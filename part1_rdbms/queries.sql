-- Part 1: Relational Databases
-- Task 1.3: SQL Queries

-- Q1: List all customers from Mumbai along with their total order value
-- Description: Joins customers, orders, and order_items to calculate the sum of (quantity * unit_price).
SELECT 
    c.customer_name, 
    SUM(oi.quantity * p.unit_price) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
-- Description: Aggregates quantities from order_items and sorts to find the most popular items.
SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
-- Description: Counts unique customer IDs associated with each sales rep in the orders table.
SELECT 
    sr.sales_rep_name, 
    COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM sales_reps sr
LEFT JOIN orders o ON sr.sales_rep_id = o.sales_rep_id
GROUP BY sr.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
-- Description: Calculates total order value and filters using HAVING.
SELECT 
    o.order_id, 
    SUM(oi.quantity * p.unit_price) AS order_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING order_total > 10000
ORDER BY order_total DESC;

-- Q5: Identify any products that have never been ordered
-- Description: Uses a LEFT JOIN to find products that do not appear in the order_items table.
SELECT 
    p.product_id, 
    p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;
