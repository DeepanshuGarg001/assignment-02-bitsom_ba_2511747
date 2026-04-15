-- Part 1: Relational Databases
-- Task 1.2: Schema Design (Normalized to 3NF)

-- 1. Create Tables with appropriate PK, FK, and Constraints

-- Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) UNIQUE NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

-- Products Table
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0)
);

-- Sales Representatives Table
CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) UNIQUE NOT NULL,
    office_address TEXT NOT NULL
);

-- Orders Table
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

-- Order Items Table (to handle normalization of repeated products in orders)
CREATE TABLE order_items (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Populate at least 5 rows per table based on orders_flat.csv

-- Populate Customers
INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi');

-- Populate Products
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000),
('P002', 'Mouse', 'Electronics', 800),
('P004', 'Notebook', 'Stationery', 120),
('P005', 'Headphones', 'Electronics', 3200),
('P007', 'Pen Set', 'Stationery', 250);

-- Populate Sales Reps
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road, Bangalore - 560001'),
('SR04', 'Suresh Raina', 'suresh@corp.com', 'Chennai Branch, T. Nagar - 600017'),
('SR05', 'Kiran Bedi', 'kiran@corp.com', 'Hyderabad Office, Banjara Hills - 500034');

-- Populate Orders
INSERT INTO orders (order_id, customer_id, sales_rep_id, order_date) VALUES
('ORD1027', 'C002', 'SR02', '2023-11-02'),
('ORD1114', 'C001', 'SR01', '2023-08-06'),
('ORD1153', 'C006', 'SR01', '2023-02-14'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1118', 'C006', 'SR02', '2023-11-10'),
('ORD1132', 'C003', 'SR02', '2023-03-07'),
('ORD1037', 'C002', 'SR03', '2023-03-06');

-- Populate Order Items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
('ORD1027', 'P004', 4),
('ORD1114', 'P007', 2),
('ORD1153', 'P007', 3),
('ORD1002', 'P005', 1),
('ORD1118', 'P007', 5),
('ORD1132', 'P007', 5),
('ORD1037', 'P007', 2);
