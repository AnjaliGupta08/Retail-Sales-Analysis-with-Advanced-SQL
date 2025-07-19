## Retail Sales Analysis

SELECT * FROM dim_campaigns;
SELECT * FROM dim_customers;
SELECT * FROM dim_dates;
SELECT * FROM dim_products;
SELECT * FROM dim_salespersons;
SELECT * FROM dim_stores;
SELECT * FROM fact_sales_denormalized;
SELECT * From fact_sales_normalized;


# OVERVIEW

-- 1. List all customers
SELECT * FROM dim_customers;
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  email,
  residential_location
FROM dim_customers;

-- Show all products in 'Electronics' category
SELECT * FROM dim_products WHERE category = 'Electronics';

-- Count of total stores
SELECT count(* )FROM dim_stores;

-- Get all unique customer segments
SELECT DISTINCT customer_segment FROM dim_customers;

-- Get all unique campaign
SELECT DISTINCT count(campaign_name ) FROM dim_campaigns;

-- Get top 10 campaigns by budget
SELECT campaign_name, campaign_budget FROM dim_campaigns ORDER BY campaign_budget DESC LIMIT 10;

-- Total number of sales
SELECT COUNT(*) FROM fact_sales_normalized;

-- Total sales amount
SELECT SUM(total_amount) AS total_revenue FROM fact_sales_normalized;

-- Number of stores by type
SELECT store_type, COUNT(*) FROM dim_stores GROUP BY store_type;

-- Show all salespersons with their roles
SELECT salesperson_name, salesperson_role FROM dim_salespersons;

-- List customers from 'Chicago'
SELECT * FROM dim_customers WHERE residential_location = 'Chicago';

-- Total sales in NOVEMBER
SELECT SUM(total_amount) FROM fact_sales_normalized 
WHERE month(sales_date) = 11;

-- Products of brand 'Sony'
SELECT * FROM dim_products WHERE brand = 'Sony';

-- Store locations with more than 2 stores
SELECT store_location, COUNT(*) FROM dim_stores GROUP BY store_location HAVING COUNT(*) > 2;

-- Customers in 'Premium' segment
SELECT * FROM dim_customers WHERE customer_segment = 'Premium Shopper';

-- List all dates in January 2024
SELECT * FROM dim_dates WHERE month = 1 AND year = 2024;

-- Total number of products per category
SELECT category, COUNT(*) FROM dim_products GROUP BY category;

-- Find highest campaign budget
SELECT MAX(campaign_budget) FROM dim_campaigns;

-- Show total sales by each customer segment
SELECT customer_segment, COUNT(*) FROM fact_sales_denormalized GROUP BY customer_segment;

-- Show number of products from each origin location
SELECT origin_location, COUNT(*) FROM dim_products GROUP BY origin_location;

# DATA CLEANING AND PREPROCESSING

--  Preview bad values (non-YYYY-MM-DD) in dim_date
SELECT full_date
FROM dim_dates
WHERE full_date NOT LIKE '____-__-__';

-- Backup the affected rows 

CREATE TABLE dim_dates_backup AS
SELECT * FROM dim_dates;

SELECT * FROM dim_dates_backup ;

-- Convert serial numbers to proper dates
-- Only updates rows where full_date is NOT in date format
UPDATE dim_dates
SET full_date = DATE_ADD('1899-12-30', INTERVAL CAST(full_date AS UNSIGNED) DAY)
WHERE full_date NOT LIKE '____-__-__';

--  Check if all full_date values are now in proper format
SELECT DISTINCT full_date
FROM dim_dates
ORDER BY full_date;

-- Add a new column for clean date in table ( fact_sales_normalized)
ALTER TABLE fact_sales_normalized
ADD COLUMN clean_sales_date DATE;

-- Fill new column with converted values
UPDATE fact_sales_normalized
SET clean_sales_date = DATE(sales_date);    


# JOINS

-- Full view of sales (customer + product + store + date + campaign)
SELECT
    f.sales_id,
    c.first_name, c.last_name,
    p.product_name, p.brand,
    s.store_name, s.store_location,
    d.year, d.month, d.day,
    cam.campaign_name,
    f.total_amount
FROM fact_sales_normalized f
JOIN dim_customers c ON f.customer_sk = c.customer_sk
JOIN dim_products p ON f.product_sk = p.product_sk
JOIN dim_stores s ON f.store_sk = s.store_sk
JOIN dim_dates d ON f.clean_sales_date = d.full_date
JOIN dim_campaigns cam ON f.campaign_sk = cam.campaign_sk;

# Business  Marketing, Campaign, and Customer Insights

-- 1. Sales with product and customer info
SELECT f.sales_id, c.first_name, p.product_name, f.total_amount
FROM fact_sales_normalized f
JOIN dim_customers c ON f.customer_sk = c.customer_sk
JOIN dim_products p ON f.product_sk = p.product_sk;

-- Top 10 Products by Sales Revenue
SELECT p.product_name, SUM(f.total_amount) AS total_revenue
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Top 10 Customers by Total Spend
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(f.total_amount) AS total_spent
FROM fact_sales_normalized f
JOIN dim_customers c ON f.customer_sk = c.customer_sk
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Top 5 Stores by Revenue
SELECT s.store_name, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_stores s ON f.store_sk = s.store_sk
GROUP BY s.store_name
ORDER BY total_sales DESC
LIMIT 5;

-- Best Salesperson (by revenue)
SELECT sp.salesperson_name, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_salespersons sp ON f.salesperson_sk = sp.salesperson_sk
GROUP BY sp.salesperson_name
ORDER BY total_sales DESC
limit 1;

-- Most Profitable Campaign
SELECT c.campaign_name, SUM(f.total_amount) AS revenue
FROM fact_sales_normalized f
JOIN dim_campaigns c ON f.campaign_sk = c.campaign_sk
GROUP BY c.campaign_name
ORDER BY revenue DESC
LIMIT 1;

-- Top Selling Product
SELECT 
p.product_name,
COUNT(*) AS units_sold 
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
GROUP BY p.product_name
ORDER BY units_sold DESC;

-- Products with No Sales 
SELECT p.product_name
FROM dim_products p
LEFT JOIN fact_sales_normalized f ON p.product_sk = f.product_sk
WHERE f.sales_id IS NULL;

-- Customers Who Haven’t Purchased Anything 
SELECT c.customer_id, c.first_name, c.last_name
FROM dim_customers c
LEFT JOIN fact_sales_normalized f ON c.customer_sk = f.customer_sk
WHERE f.sales_id IS NULL;

-- Sales by Product Category and Store Type
SELECT p.category, s.store_type, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
JOIN dim_stores s ON f.store_sk = s.store_sk
GROUP BY p.category, s.store_type
ORDER BY total_sales DESC;


-- Sales by Product Category
SELECT p.category, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
GROUP BY p.category
ORDER BY total_sales DESC;

-- Customer Segmentation Insights
SELECT customer_segment, sum(total_amount) AS revenue
FROM dim_customers c 
JOIN fact_sales_normalized f 
ON c.customer_sk= f.customer_sk
GROUP BY customer_segment
ORDER BY  revenue ;

-- Sales by Quarter
SELECT d.quarter, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_dates d ON f.clean_sales_date = d.full_date
GROUP BY d.quarter
ORDER BY total_sales DESC;

-- Stores with No Sales 
SELECT s.store_id, s.store_name
FROM dim_stores s
LEFT JOIN fact_sales_normalized f ON s.store_sk = f.store_sk
WHERE f.sales_id IS NULL;

-- Stores with  MAX no of items Sales
SELECT s.store_name, count(s.store_id) as total_no_of_sale
FROM dim_stores s
LEFT JOIN fact_sales_normalized f ON s.store_sk = f.store_sk
GROUP BY s.store_name
ORDER BY total_no_of_sale DESC 
LIMIT 1;

-- No_Of_Sales by Weekday 
SELECT DAYNAME(d.full_date) AS weekdays, COUNT(f.sales_id) AS total_no_of_sales
FROM dim_dates d
JOIN fact_sales_normalized f ON f.clean_sales_date = d.full_date
GROUP BY DAYNAME(d.full_date)
ORDER BY total_no_of_sales DESC;

-- Max Sale Amount per Product Category
SELECT p.category, MAX(f.total_amount) AS max_sale
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
GROUP BY p.category
ORDER BY max_sale DESC;

-- Store Managers with the Most Revenue
SELECT m.salesperson_name AS manager_name, s.store_name, SUM(f.total_amount) AS total_sales
FROM dim_stores s
JOIN dim_salespersons m ON s.store_manager_sk = m.salesperson_sk
LEFT JOIN fact_sales_normalized f ON s.store_sk = f.store_sk
WHERE salesperson_role='Manager'
GROUP BY m.salesperson_name, s.store_name
ORDER BY total_sales DESC
LIMIT 5;

-- Sales Distribution By Role
SELECT m.salesperson_role , SUM(f.total_amount) AS total_sales
FROM dim_salespersons m
JOIN fact_sales_normalized f  ON m.salesperson_sk = f.salesperson_sk
GROUP BY m.salesperson_role
ORDER BY total_sales DESC;

-- Top 10 Best-Selling Brands by Total REVENUE
SELECT p.brand,SUM(f.total_amount) AS Revenue
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
GROUP BY p.brand
ORDER BY Revenue DESC
LIMIT 10;

-- Campaigns with Below-Expected Revenue 
SELECT c.campaign_name, c.campaign_budget, IFNULL(SUM(f.total_amount),0) AS actual_sales
FROM dim_campaigns c
LEFT JOIN fact_sales_normalized f ON c.campaign_sk = f.campaign_sk
GROUP BY c.campaign_name, c.campaign_budget
HAVING actual_sales < c.campaign_budget
ORDER BY campaign_budget-actual_sales DESC
LIMIT 5;

-- Last 10 Sales with Full Customer and Product Info
SELECT f.sales_id, f.sales_date, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, p.product_name, f.total_amount
FROM fact_sales_normalized f
JOIN dim_customers c ON f.customer_sk = c.customer_sk
JOIN dim_products p ON f.product_sk = p.product_sk
ORDER BY f.sales_date DESC
LIMIT 10;

-- Weekly Sales Trend per Store 
SELECT s.store_name, DAYNAME(d.full_date) AS weekdays, SUM(f.total_amount) AS weekly_sales
FROM fact_sales_normalized f
JOIN dim_dates d ON f.clean_sales_date = d.full_date
JOIN dim_stores s ON f.store_sk = s.store_sk
GROUP BY s.store_name, d.weekday
ORDER BY s.store_name, FIELD(weekdays, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Total company revenue
SELECT SUM(total_amount) AS total_company_revenue FROM fact_sales_normalized;

-- Best performing store (by revenue)
SELECT s.store_name, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_stores s ON f.store_sk = s.store_sk
GROUP BY s.store_name
ORDER BY total_sales DESC
LIMIT 1;

-- Best performing product category
SELECT p.category, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_products p ON f.product_sk = p.product_sk
GROUP BY p.category
ORDER BY total_sales DESC
LIMIT 1;

-- Top 3 Region with highest sales
SELECT s.store_location, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_stores s ON f.store_sk = s.store_sk
GROUP BY s.store_location
ORDER BY total_sales DESC
LIMIT 3;

-- MONTHLY trend (for decision-making)
SELECT 
DATE_FORMAT(d.full_date, '%M') AS sale_month,  -- Full month name
SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_dates d ON f.clean_sales_date = d.full_date
GROUP BY sale_month
ORDER BY MONTH(d.full_date);  


-- Best performing campaign
SELECT c.campaign_name, SUM(f.total_amount) AS revenue_generated
FROM fact_sales_normalized f
JOIN dim_campaigns c ON f.campaign_sk = c.campaign_sk
GROUP BY c.campaign_name
ORDER BY revenue_generaed DESC
LIMIT 1;

-- Campaign ROI
SELECT c.campaign_name, c.campaign_budget, SUM(f.total_amount) AS revenue_generated,
       (SUM(f.total_amount) - c.campaign_budget) AS roi
FROM fact_sales_normalized f
JOIN dim_campaigns c ON f.campaign_sk = c.campaign_sk
GROUP BY c.campaign_name
order by roi
;


-- Sales trend by campaign over quarters
SELECT d.quarter, c.campaign_name, SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_dates d ON f.clean_sales_date= d.full_date
JOIN dim_campaigns c ON f.campaign_sk = c.campaign_sk
GROUP BY d.quarter, c.campaign_name
ORDER BY d.quarter;

-- Customer behavior by location
SELECT c.residential_location, COUNT(*) AS total_customers,
       SUM(f.total_amount) AS total_sales
FROM fact_sales_normalized f
JOIN dim_customers c ON f.customer_sk = c.customer_sk
GROUP BY c.residential_location
ORDER BY total_sales DESC;


-- Products That Made More Revenue Than the Average Product Revenue
SELECT product_id, product_name, category, total_revenue
FROM (
    SELECT p.product_id, p.product_name, p.category, SUM(f.total_amount) AS total_revenue
    FROM fact_sales_normalized f
    JOIN dim_products p ON f.product_sk = p.product_sk
    GROUP BY p.product_id
) AS product_sales
WHERE total_revenue > (
    SELECT AVG(total_amount) FROM fact_sales_normalized
);

-- Stores That Sold More Than 10 Orders
SELECT store_id, store_name, total_orders
FROM (
    SELECT s.store_id, s.store_name, COUNT(f.sales_id) AS total_orders
    FROM fact_sales_normalized f
    JOIN dim_stores s ON f.store_sk = s.store_sk
    GROUP BY s.store_id
) AS order_count
WHERE total_orders > 10;

-- Salespersons Who Beat the Average Sales Revenue Per Person
SELECT salesperson_id, salesperson_name, total_sales
FROM (
    SELECT sp.salesperson_id, sp.salesperson_name, SUM(f.total_amount) AS total_sales
    FROM fact_sales_normalized f
    JOIN dim_salespersons sp ON f.salesperson_sk = sp.salesperson_sk
    GROUP BY sp.salesperson_id
) AS sales_perf
WHERE total_sales > (
    SELECT AVG(inner_sales.total_sales)
    FROM (
        SELECT SUM(f.total_amount) AS total_sales
        FROM fact_sales_normalized f
        GROUP BY f.salesperson_sk
    ) AS inner_sales
);



    

