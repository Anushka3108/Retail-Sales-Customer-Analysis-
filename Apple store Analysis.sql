-- ================================
-- RETAIL SALES ANALYSIS PROJECT
-- ================================

-- 1. TABLE CREATION

CREATE TABLE sales (
    sales_id INT,
    product_id INT,
    store_id INT,
    date DATE,
    quantity INT,
    revenue DECIMAL(10,2)
);

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2)
);

CREATE TABLE category (
    category_id INT,
    category_name VARCHAR(100)
);

CREATE TABLE stores (
    store_id INT,
    store_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE warranty (
    product_id INT,
    warranty_period INT
);

-- ================================
-- 2. BASIC ANALYSIS
-- ================================

SELECT COUNT(*) AS total_orders,
       SUM(quantity) AS total_units,
       SUM(revenue) AS total_revenue
FROM sales;

SELECT MIN(date) AS start_date,
       MAX(date) AS end_date
FROM sales;

-- ================================
-- 3. PRODUCT PERFORMANCE
-- ================================

-- Top Products
SELECT p.product_name,
       SUM(s.quantity) AS total_units,
       SUM(s.revenue) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- Bottom Products
SELECT p.product_name,
       SUM(s.revenue) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue ASC
LIMIT 10;

-- ================================
-- 4. TOP 25% PRODUCTS
-- ================================

WITH ranked_products AS (
    SELECT p.product_name,
           SUM(s.revenue) AS revenue,
           NTILE(4) OVER (ORDER BY SUM(s.revenue) DESC) AS quartile
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT *
FROM ranked_products
WHERE quartile = 1;

-- ================================
-- 5. STORE ANALYSIS
-- ================================

SELECT st.store_name,
       SUM(s.revenue) AS revenue
FROM sales s
JOIN stores st ON s.store_id = st.store_id
GROUP BY st.store_name
ORDER BY revenue DESC;

-- Region Performance
SELECT st.region,
       SUM(s.revenue) AS revenue
FROM sales s
JOIN stores st ON s.store_id = st.store_id
GROUP BY st.region
ORDER BY revenue DESC;

-- ================================
-- 6. CATEGORY ANALYSIS
-- ================================

SELECT c.category_name,
       SUM(s.revenue) AS revenue,
       SUM(s.quantity) AS units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

-- ================================
-- 7. TIME ANALYSIS
-- ================================

-- Monthly Sales
SELECT DATE_TRUNC('month', date) AS month,
       SUM(revenue) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;

-- Peak Sales Days
SELECT date,
       SUM(revenue) AS daily_revenue
FROM sales
GROUP BY date
ORDER BY daily_revenue DESC
LIMIT 5;

-- ================================
-- 8. DEMAND ANALYSIS
-- ================================

SELECT product_id,
       COUNT(*) AS purchase_count
FROM sales
GROUP BY product_id
ORDER BY purchase_count DESC
LIMIT 10;

-- ================================
-- 9. WARRANTY ANALYSIS
-- ================================

SELECT p.product_name,
       w.warranty_period,
       SUM(s.revenue) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN warranty w ON p.product_id = w.product_id
GROUP BY p.product_name, w.warranty_period
ORDER BY revenue DESC;

-- ================================
-- 10. ADVANCED ANALYSIS
-- ================================

-- Running Revenue
SELECT date,
       SUM(revenue) OVER (ORDER BY date) AS running_revenue
FROM sales;

-- Top Product per Region
SELECT *
FROM (
    SELECT st.region,
           p.product_name,
           SUM(s.revenue) AS revenue,
           RANK() OVER (PARTITION BY st.region ORDER BY SUM(s.revenue) DESC) AS 'rank'
    FROM sales s
    JOIN stores st ON s.store_id = st.store_id
    JOIN products p ON s.product_id = p.product_id
    GROUP BY st.region, p.product_name
) ranked
WHERE 'rank' = 1;

-- ================================
-- 11. INDEXING (PERFORMANCE)
-- ================================

CREATE INDEX idx_product_id ON sales(product_id);
CREATE INDEX idx_store_id ON sales(store_id);