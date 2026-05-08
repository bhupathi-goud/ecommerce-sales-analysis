-- Orders Table
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);



-- Payments Table
CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

-- Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- Products Table
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2),
    product_category_name_english VARCHAR(100)
);

-- Order Items Table
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

-- Sellers Table
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght DECIMAL(10,2),
    product_description_lenght DECIMAL(10,2),
    product_photos_qty DECIMAL(10,2),
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2),
    product_category_name_english VARCHAR(100)
);

COPY products FROM 'C:\tmp\products_clean.csv' 
DELIMITER ',' CSV HEADER;

COPY orders FROM 'C:\tmp\orders_clean.csv' 
DELIMITER ',' CSV HEADER;

COPY payments FROM 'C:\tmp\payments_clean.csv' 
DELIMITER ',' CSV HEADER;

COPY customers FROM 'C:\tmp\customers_clean.csv' 
DELIMITER ',' CSV HEADER;

COPY order_items FROM 'C:\tmp\order_items_clean.csv' 
DELIMITER ',' CSV HEADER;

COPY sellers FROM 'C:\tmp\sellers_clean.csv' 
DELIMITER ',' CSV HEADER;

SELECT COUNT(*) FROM Orders;
SELECT COUNT(*)FROM Products;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM Orders;

SELECT 'orders'      AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'payments'    AS table_name, COUNT(*) AS row_count FROM payments
UNION ALL
SELECT 'customers'   AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products'    AS table_name, COUNT(*) AS row_count FROM products
UNION ALL
SELECT 'order_items' AS table_name, COUNT(*) AS row_count FROM order_items
UNION ALL
SELECT 'sellers'     AS table_name, COUNT(*) AS row_count FROM sellers;

# total revenue .....

SELECT SUM(payment_value) as Revenu_amount FROM payments;

# top 5 payment types.....

SELECT payment_type, COUNT(*) AS total
FROM payments
GROUP BY payment_type
ORDER BY total DESC;

# avg order value....

SELECT AVG(payment_value) as Avg_value from payments;

# top 5 states by customers....

SELECT customer_state,COUNT(*) AS total_custoemrs FROM customers
GROUP BY customer_state
ORDER BY total_custoemrs DESC
LIMIT 5;

# top 5 product categories....

SELECT product_category_name_english,COUNT(*) AS total FROM products
GROUP BY product_category_name_english
ORDER BY total DESC
LIMIT 5;

-- each order with its payment....
SELECT 
    o.order_id,
    o.order_purchase_timestamp,
    p.payment_type,
    p.payment_value
FROM orders o
JOIN payments p ON o.order_id = p.order_id
LIMIT 10;

-- each order with customer city...

SELECT 
    o.order_id,
    o.order_purchase_timestamp,
    c.customer_city,
    c.customer_state
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LIMIT 10;

-- Revenue per month...

SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value)::numeric, 2)         AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

--- Year wise Revenue...

SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    ROUND(SUM(p.payment_value)::numeric, 2)       AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY year
ORDER BY year;

-- Top 10 revenue categories...

SELECT 
    pr.product_category_name_english              AS category,
    ROUND(SUM(p.payment_value)::numeric, 2)       AS revenue
FROM order_items oi
JOIN products pr  ON oi.product_id = pr.product_id
JOIN payments p   ON oi.order_id   = p.order_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;

-- count of late deliveries...

SELECT 
    COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;

-- top 10 sellers by revenue....

SELECT  
    s.seller_id,
    s.seller_city,
    s.seller_state,
    ROUND(SUM(oi.price)::numeric, 2)              AS total_revenue
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Month over month growth....

WITH monthly AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        ROUND(SUM(p.payment_value)::numeric, 2)         AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY month
)
SELECT 
    month,
    revenue,
    ROUND(((revenue - LAG(revenue) OVER (ORDER BY month)) /
    LAG(revenue) OVER (ORDER BY month) * 100)::numeric, 2) AS mom_growth_pct
FROM monthly
ORDER BY month;

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'ecommerce ';

ALTER DATABASE "ecommerce " RENAME TO ecommerce;



