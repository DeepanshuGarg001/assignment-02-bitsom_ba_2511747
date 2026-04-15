-- Part 5: Data Lakes & DuckDB
-- Task 5.1: Cross-Format Queries
-- Note: Queries read directly from raw files without pre-loading.

-- Q1: List all customers along with the total number of orders they have placed
-- Description: Joins customers.csv and orders.json to count orders per customer.
SELECT 
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM 'datasets/customers.csv' c
LEFT JOIN 'datasets/orders.json' o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;

-- Q2: Find the top 3 customers by total order value
-- Description: Summarizes total_amount from orders.json for each customer.
SELECT 
    c.name, 
    SUM(o.total_amount) AS total_spent
FROM 'datasets/customers.csv' c
JOIN 'datasets/orders.json' o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
-- Description: Joins all three files and filters by city.
SELECT DISTINCT 
    p.product_name
FROM 'datasets/products.parquet' p
JOIN 'datasets/orders.json' o ON p.order_id = o.order_id
JOIN 'datasets/customers.csv' c ON o.customer_id = c.customer_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
-- Description: Provides a comprehensive flat view of all transactional data.
SELECT 
    c.name AS customer_name, 
    o.order_date, 
    p.product_name, 
    p.quantity
FROM 'datasets/customers.csv' c
JOIN 'datasets/orders.json' o ON c.customer_id = o.customer_id
JOIN 'datasets/products.parquet' p ON o.order_id = p.order_id
LIMIT 20;
