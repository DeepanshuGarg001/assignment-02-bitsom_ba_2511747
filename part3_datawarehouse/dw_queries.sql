-- Part 3: Data Warehouses
-- Task 3.2: Analytical Queries

-- Q1: Total sales revenue by product category for each month
-- Description: Aggregates revenue by month (from dim_date) and category (from dim_product).
SELECT 
    d.month_name, 
    p.category, 
    SUM(f.total_revenue) AS monthly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.month_name, p.category
ORDER BY d.month, p.category;

-- Q2: Top 2 performing stores by total revenue
-- Description: Ranks stores based on the sum of their total_revenue in the fact table.
SELECT 
    s.store_name, 
    SUM(f.total_revenue) AS total_store_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_store_revenue DESC
LIMIT 2;

-- Q3: Month-over-month (MoM) sales trend across all stores
-- Description: Shows total revenue for each month to observe growth or decline.
-- (Note: For a true MoM % change, window functions like LAG() would be used in a full SQL engine).
SELECT 
    d.year,
    d.month_name, 
    SUM(f.total_revenue) AS total_monthly_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;
