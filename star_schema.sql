-- Part 3: Data Warehouses
-- Task 3.1: Star Schema Design

-- 1. Create Dimension Tables

-- dim_date: Extracts time-based attributes for analysis
CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    day INTEGER,
    month INTEGER,
    year INTEGER,
    quarter INTEGER,
    month_name VARCHAR(15)
);

-- dim_store: Store location and name details
CREATE TABLE dim_store (
    store_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

-- dim_product: Product catalog and categories (Standardized Category)
CREATE TABLE dim_product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- 2. Create Fact Table

-- fact_sales: Central table for transactional measures
CREATE TABLE fact_sales (
    transaction_id VARCHAR(10) PRIMARY KEY,
    date_key DATE NOT NULL,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    units_sold INTEGER NOT NULL,
    unit_price DECIMAL(15, 2) NOT NULL,
    total_revenue DECIMAL(15, 2) NOT NULL,
    customer_id VARCHAR(10),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- 3. Load Cleaned Sample Data (at least 10 rows)
-- Note: Cleaning handled: 
-- - Standardized Categories (e.g., 'electronics' -> 'Electronics')
-- - Standardized Dates (YYYY-MM-DD)
-- - Calculated total_revenue

-- Cleaned dim_store
INSERT INTO dim_store (store_id, store_name, store_city) VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- Cleaned dim_product (Standardized casing and pluralization)
INSERT INTO dim_product (product_id, product_name, category) VALUES
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Phone', 'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg', 'Groceries'),
(6, 'Jeans', 'Clothing'),
(7, 'Biscuits', 'Groceries'),
(8, 'Jacket', 'Clothing'),
(9, 'Laptop', 'Electronics'),
(10, 'Milk 1L', 'Groceries');

-- Populate dim_date (Supporting inserted fact rows)
INSERT INTO dim_date (date_key, day, month, year, quarter, month_name) VALUES
('2023-01-15', 15, 1, 2023, 1, 'January'),
('2023-02-05', 5, 2, 2023, 1, 'February'),
('2023-02-20', 20, 2, 2023, 1, 'February'),
('2023-03-31', 31, 3, 2023, 1, 'March'),
('2023-05-21', 21, 5, 2023, 2, 'May'),
('2023-06-04', 4, 6, 2023, 2, 'June'),
('2023-08-09', 9, 8, 2023, 3, 'August'),
('2023-08-29', 29, 8, 2023, 3, 'August'),
('2023-10-26', 26, 10, 2023, 4, 'October'),
('2023-12-08', 8, 12, 2023, 4, 'December'),
('2023-12-12', 12, 12, 2023, 4, 'December');

-- Cleaned fact_sales (Calculated measures and standardized FKs)
INSERT INTO fact_sales (transaction_id, date_key, store_id, product_id, units_sold, unit_price, total_revenue, customer_id) VALUES
('TXN5000', '2023-08-29', 1, 1, 3, 49262.78, 147788.34, 'CUST045'),
('TXN5001', '2023-12-12', 1, 2, 11, 23226.12, 255487.32, 'CUST021'),
('TXN5002', '2023-02-05', 1, 3, 20, 48703.39, 974067.80, 'CUST019'),
('TXN5003', '2023-02-20', 2, 2, 14, 23226.12, 325165.68, 'CUST007'),
('TXN5004', '2023-01-15', 1, 4, 10, 58851.01, 588510.10, 'CUST004'),
('TXN5005', '2023-08-09', 3, 5, 12, 52464.0, 629568.00, 'CUST027'),
('TXN5006', '2023-03-31', 4, 4, 6, 58851.01, 353106.06, 'CUST025'),
('TXN5007', '2023-10-26', 4, 6, 16, 2317.47, 37079.52, 'CUST041'),
('TXN5008', '2023-12-08', 3, 7, 9, 27469.99, 247229.91, 'CUST030'),
('TXN5012', '2023-05-21', 3, 9, 13, 42343.15, 550460.95, 'CUST044');
