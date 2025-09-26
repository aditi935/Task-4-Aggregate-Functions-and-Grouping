--CREATE DATABASE
CREATE DATABASE ecommercedb;

USE ecommercedb;

--CREATE TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    rating DECIMAL(3,1),
    supplier VARCHAR(50),
    added_date DATE
);

--VALUES INSERT
INSERT INTO products (product_id, product_name, category, brand, price, quantity, rating, supplier, added_date)
VALUES
(1, 'Smartphone X1', 'Electronics', 'Samsung', 25000.00, 50, 4.5, 'TechWorld', '2023-05-12'),
(2, 'Laptop Pro 15', 'Electronics', 'Dell', 65000.00, 30, 4.7, 'CompStore', '2023-06-20'),
(3, 'Washing Machine 7kg', 'Home Appliances', 'LG', 30000.00, 20, 4.3, 'HomeNeeds', '2023-02-15'),
(4, 'Air Conditioner 1.5T', 'Home Appliances', 'Voltas', 35000.00, 25, 4.2, 'CoolAir', '2023-07-10'),
(5, 'T-Shirt Classic', 'Clothing', 'Nike', 1200.00, 100, 4.0, 'FashionHub', '2023-08-01'),
(6, 'Running Shoes', 'Clothing', 'Adidas', 4500.00, 60, 4.4, 'SportStyle', '2023-03-05'),
(7, 'Refrigerator 250L', 'Home Appliances', 'Whirlpool', 28000.00, 15, 4.6, 'HomeNeeds', '2023-04-25'),
(8, 'Headphones Z', 'Electronics', 'Sony', 4000.00, 80, 4.8, 'MusicWorld', '2023-01-18'),
(9, 'Smartwatch S', 'Electronics', 'Apple', 30000.00, 40, 4.9, 'iStore', '2023-09-10'),
(10, 'Jeans Slim Fit', 'Clothing', 'Levis', 2500.00, 90, 4.2, 'FashionHub', '2023-02-28');

SELECT *FROM products;

-- Query 1: Category-wise Product Statistics
SELECT category, COUNT(*) AS total_products, 
       AVG(price) AS avg_price,
       MAX(price) AS max_price,
       MIN(price) AS min_price
FROM products
GROUP BY category;

-- Query 2: Supplier-wise Product Count
SELECT supplier, COUNT(brand) 
FROM products 
GROUP BY supplier;

-- Query 3: Category-wise Average Price
SELECT category, AVG(price) 
FROM products 
GROUP BY category;

-- Query 4: Supplier-wise Maximum Price
SELECT supplier, MAX(price) 
FROM products 
GROUP BY supplier;

-- Query 5: Cheapest Product Price
SELECT MIN(price) AS cheapest_price 
FROM products;

-- Query 6: Total Inventory Value
SELECT SUM(price * quantity) AS total_inventory_value
FROM products;

-- Query 7: Brands with Quantity > 50
SELECT brand, SUM(quantity) 
FROM products 
GROUP BY brand 
HAVING SUM(quantity) > 50;

-- Query 8: Distinct Categories Count
SELECT COUNT(DISTINCT category) 
FROM products;

-- Query 9: Average Price Rounded
SELECT ROUND(AVG(price), 2) AS avg_price_2_decimals 
FROM products;

-- Query 10: Highest Price by Category
SELECT category, MAX(price) AS highest_price
FROM products
GROUP BY category;

-- Query 11: Highest Priced Product Name in Each Category
SELECT p.category, p.product_name, p.price
FROM products p
WHERE p.price = (
    SELECT MAX(price)
    FROM products
    WHERE category = p.category
);

-- Query 12: Total Sales Value Per Supplier
SELECT supplier, SUM(price * quantity) AS total_value
FROM products
GROUP BY supplier;
