
-- E-commerce Sales Analysis Project
-- Database setup and table creation

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

CREATE TABLE IF NOT EXISTS superstore (
    order_date DATE,
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2)
);

-- =====================================================
-- PROJECT: E-COMMERCE SALES ANALYSIS
-- Tool: MySQL Workbench
-- Database: ecommerce_analysis
-- Table: superstore
-- Purpose: Analyse sales, profit, products and regions
-- =====================================================


-- STEP 1: Select our project database
-- Think of a database as a folder containing our data.

USE ecommerce_analysis;


-- STEP 2: Check whether our data was imported
-- COUNT(*) counts the number of records (rows).
-- We expect approximately 4,999 records.

SELECT COUNT(*) AS total_records
FROM superstore;


-- STEP 3: View the first 10 records
-- SELECT * means show all columns.
-- LIMIT 10 means show only 10 rows.

SELECT *
FROM superstore
LIMIT 10;


-- STEP 4: Calculate total sales
-- SUM adds all the sales values together.
-- AS gives the result a readable name.

SELECT SUM(sales) AS total_sales
FROM superstore;


-- STEP 5: Calculate total profit

SELECT SUM(profit) AS total_profit
FROM superstore;


-- STEP 6: Calculate total quantity sold

SELECT SUM(quantity) AS total_quantity
FROM superstore;


-- STEP 7: Calculate average sales per record

SELECT ROUND(AVG(sales), 2) AS average_sales
FROM superstore;


-- STEP 8: Calculate average profit per record

SELECT ROUND(AVG(profit), 2) AS average_profit
FROM superstore;


-- STEP 9: Find the highest and lowest individual sales values

SELECT
    MAX(sales) AS highest_sale,
    MIN(sales) AS lowest_sale
FROM superstore;


-- STEP 10: Calculate overall profit margin
-- Profit margin = total profit / total sales * 100.
-- ROUND(..., 2) keeps two decimal places.

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)
        AS profit_margin_percent
FROM superstore;


-- STEP 11: Find total sales and profit by category
-- GROUP BY puts matching categories together.
-- ORDER BY ... DESC sorts the largest value first.

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


-- STEP 12: Find profit by region

SELECT
    region,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;


-- STEP 13: Find sales by region

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;


-- STEP 14: Find the top 10 cities by sales

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;


-- STEP 15: Find the top 10 sub-categories by profit

SELECT
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 10;


-- STEP 16: Find sub-categories with an overall loss
-- HAVING filters groups after GROUP BY.
-- ASC sorts the most negative profit first.

SELECT
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;


-- STEP 17: Compare sales and profit at different discount levels

SELECT
    discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY discount
ORDER BY discount;


-- STEP 18: Find records where sales exceed 500

SELECT city, category, sales, profit
FROM superstore
WHERE sales > 500
LIMIT 10;


-- STEP 19: Find high-sales records that are also profitable
-- AND means both conditions must be true.

SELECT city, category, sales, profit
FROM superstore
WHERE sales > 500 AND profit > 0
LIMIT 10;


-- STEP 20: Find records matching either condition
-- OR means at least one condition must be true.

SELECT city, category, sales, profit
FROM superstore
WHERE sales > 1000 OR profit > 100
LIMIT 10;


-- STEP 21: Find cities starting with the letter S
-- LIKE 'S%' means starts with S, followed by any characters.

SELECT city, category, sales, profit
FROM superstore
WHERE city LIKE 'S%'
LIMIT 10;


-- STEP 22: Find sales between 100 and 500
-- BETWEEN includes both boundary values.

SELECT city, sales, profit
FROM superstore
WHERE sales BETWEEN 100 AND 500
LIMIT 10;


-- STEP 23: Show unique product categories
-- DISTINCT removes repeated category names.

SELECT DISTINCT category
FROM superstore;


-- STEP 24: Count records in each category

SELECT
    category,
    COUNT(*) AS record_count
FROM superstore
GROUP BY category
ORDER BY record_count DESC;


-- STEP 25: Classify each record by profit status
-- CASE WHEN creates a label based on a condition.
-- Positive profit = Profitable; negative = Loss.

SELECT
    city,
    sales,
    profit,
    CASE
        WHEN profit > 0 THEN 'Profitable'
        WHEN profit < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS profit_status
FROM superstore
LIMIT 20;


-- STEP 26: Count profitable, loss-making and break-even records

SELECT
    CASE
        WHEN profit > 0 THEN 'Profitable'
        WHEN profit < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS profit_status,
    COUNT(*) AS record_count
FROM superstore
GROUP BY profit_status;


-- STEP 27: Analyse sales and profit by sub-category
-- This is a useful business result for our project.
-- It shows sales and profit for the top 10 by sales.

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 10;
-- PROJECT VALIDATION
-- Purpose: Check the main business numbers
-- against the totals calculated in Excel.

USE ecommerce_analysis;

SELECT
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(
        SUM(profit) / SUM(sales) * 100,
        2
    ) AS profit_margin_percent
FROM superstore;

-- STEP 28: TOP 5 MOST PROFITABLE SUB-CATEGORIES
-- Purpose:
-- Find which product types generate the most profit.
--
-- GROUP BY: combines records with the same sub-category.
-- SUM(profit): adds profit for each sub-category.
-- ORDER BY ... DESC: ranks highest profit first.
-- LIMIT 5: shows only the top 5.

SELECT
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 5;

-- STEP 29: TOP 5 CITIES BY SALES
-- GROUP BY: combines records from the same city.
-- SUM(sales): calculates total sales for each city.
-- ORDER BY DESC: sorts from highest to lowest sales.
-- LIMIT 5: displays only the top 5 cities.

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY city
ORDER BY total_sales DESC
LIMIT 5;

-- STEP 30: LOWEST-PROFIT SUB-CATEGORIES
-- GROUP BY: groups records by product type.
-- SUM(profit): calculates total profit for each type.
-- ORDER BY ASC: sorts from lowest profit to highest.
-- LIMIT 5: shows the bottom 5.

SELECT
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_profit ASC
LIMIT 5;

-- STEP 31: REGIONAL SALES AND PROFIT
-- Purpose: Compare business performance across regions.
-- SUM(sales): calculates total sales for each region.
-- SUM(profit): calculates total profit for each region.
-- GROUP BY: creates one result per region.
-- ORDER BY: ranks regions by total sales.

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- STEP 32: FINAL PROJECT VALIDATION
-- Purpose: Check the main totals from our dataset.
-- We will compare them with the results from Excel.

SELECT
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)
        AS profit_margin_percent
FROM superstore;
