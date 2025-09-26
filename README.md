#  Task 4: Aggregate Functions and Grouping

# 🛒 E-Commerce Database Project

## 📌 Task Overview
- **Objective**: Build and query a database of products for an e-commerce platform.  
- **Tasks**:  
  1. Create database and table.  
  2. Insert product data.  
  3. Run queries to analyze products, suppliers, prices, and inventory.  
- **Tools Used**: MySQL CLI (Command Line Interface)  
- **Key Points**: Demonstrate use of **aggregate functions**, `GROUP BY`, `HAVING`, `DISTINCT`, and subqueries.  
- **Aggregate Functions Used**:  
  - `COUNT()`  
  - `SUM()`  
  - `AVG()`  
  - `MIN()`  
  - `MAX()`  
  - `ROUND()`  

---

## 🗄️ Database Overview
- **Database Name**: `ecommercedb`  
- **Table Name**: `products`

### Table Structure
```sql
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
```

### Sample Data Inserted
10 rows of product data across categories **Electronics**, **Home Appliances**, and **Clothing** with suppliers like TechWorld, CompStore, HomeNeeds, etc.
```sql
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
```
![Alt Text](images/tableinfo.png)

---

## 🔍 Queries and Outputs

### 1️⃣ Category-wise Product Statistics
**Explanation**: Get product count, average price, max and min price for each category.  

```sql
SELECT category, COUNT(*) AS total_products, 
       AVG(price) AS avg_price,
       MAX(price) AS max_price,
       MIN(price) AS min_price
FROM products
GROUP BY category;
```

**Output**:

| category        | total_products | avg_price | max_price | min_price |
|-----------------|----------------|-----------|-----------|-----------|
| Electronics     | 4              | 31000.00  | 65000.00  | 4000.00   |
| Home Appliances | 3              | 31000.00  | 35000.00  | 28000.00  |
| Clothing        | 3              | 2733.33   | 4500.00   | 1200.00   |

---

### 2️⃣ Supplier-wise Product Count
**Explanation**: Count number of products supplied by each supplier.  

```sql
SELECT supplier, COUNT(brand) 
FROM products 
GROUP BY supplier;
```

**Output**:

| supplier    | COUNT(brand) |
|-------------|--------------|
| TechWorld   | 1            |
| CompStore   | 1            |
| HomeNeeds   | 2            |
| CoolAir     | 1            |
| FashionHub  | 2            |
| SportStyle  | 1            |
| MusicWorld  | 1            |
| iStore      | 1            |

---

### 3️⃣ Category-wise Average Price
**Explanation**: Show average price of products in each category.  

```sql
SELECT category, AVG(price) 
FROM products 
GROUP BY category;
```

**Output**:

| category        | AVG(price) |
|-----------------|------------|
| Electronics     | 31000.00   |
| Home Appliances | 31000.00   |
| Clothing        | 2733.33    |

---

### 4️⃣ Supplier-wise Maximum Price
**Explanation**: Show maximum priced product by each supplier.  

```sql
SELECT supplier, MAX(price) 
FROM products 
GROUP BY supplier;
```

**Output**:

| supplier    | MAX(price) |
|-------------|------------|
| TechWorld   | 25000.00   |
| CompStore   | 65000.00   |
| HomeNeeds   | 30000.00   |
| CoolAir     | 35000.00   |
| FashionHub  | 2500.00    |
| SportStyle  | 4500.00    |
| MusicWorld  | 4000.00    |
| iStore      | 30000.00   |

---

### 5️⃣ Cheapest Product Price
**Explanation**: Find lowest product price in the table.  

```sql
SELECT MIN(price) AS cheapest_price 
FROM products;
```

**Output**:

| cheapest_price |
|----------------|
| 1200.00        |

---

### 6️⃣ Total Inventory Value
**Explanation**: Calculate total stock value (price × quantity).  

```sql
SELECT SUM(price * quantity) AS total_inventory_value
FROM products;
```

**Output**:

| total_inventory_value |
|-----------------------|
| 7230000.00            |

---

### 7️⃣ Brands with Quantity > 50
**Explanation**: Find brands whose total stock exceeds 50 units.  

```sql
SELECT brand, SUM(quantity) 
FROM products 
GROUP BY brand 
HAVING SUM(quantity) > 50;
```

**Output**:

| brand  | SUM(quantity) |
|--------|---------------|
| Nike   | 100           |
| Adidas | 60            |
| Sony   | 80            |
| Levis  | 90            |

---

### 8️⃣ Distinct Categories
**Explanation**: Count distinct categories available.  

```sql
SELECT COUNT(DISTINCT category) 
FROM products;
```

**Output**:

| COUNT(DISTINCT category) |
|--------------------------|
| 3                        |

---

### 9️⃣ Average Price (Rounded)
**Explanation**: Show overall average price rounded to 2 decimals.  

```sql
SELECT ROUND(AVG(price), 2) AS avg_price_2_decimals 
FROM products;
```

**Output**:

| avg_price_2_decimals |
|----------------------|
| 22520.00             |

---

### 🔟 Highest Product Price by Category
**Explanation**: Get highest product price per category.  

```sql
SELECT category, MAX(price) AS highest_price
FROM products
GROUP BY category;
```

**Output**:

| category        | highest_price |
|-----------------|---------------|
| Electronics     | 65000.00      |
| Home Appliances | 35000.00      |
| Clothing        | 4500.00       |

---

### 1️⃣1️⃣ Highest Priced Product Name in Each Category
**Explanation**: Show product names having max price in their category.  

```sql
SELECT p.category, p.product_name, p.price
FROM products p
WHERE p.price = (
    SELECT MAX(price)
    FROM products
    WHERE category = p.category
);
```

**Output**:

| category        | product_name        | price    |
|-----------------|---------------------|---------:|
| Electronics     | Laptop Pro 15       | 65000.00 |
| Home Appliances | Air Conditioner 1.5T| 35000.00 |
| Clothing        | Running Shoes       | 4500.00  |

---

### 1️⃣2️⃣ Total Sales Value Per Supplier
**Explanation**: If all stock sold, calculate total value per supplier.  

```sql
SELECT supplier, SUM(price * quantity) AS total_value
FROM products
GROUP BY supplier;
```

**Output**:

| supplier    | total_value |
|-------------|-------------|
| TechWorld   | 1250000.00  |
| CompStore   | 1950000.00  |
| HomeNeeds   | 1020000.00  |
| CoolAir     | 875000.00   |
| FashionHub  | 345000.00   |
| SportStyle  | 270000.00   |
| MusicWorld  | 320000.00   |
| iStore      | 1200000.00  |

---

"# Task-4Aggregate-Functions-and-Grouping" 
"# Task-4-Aggregate-Functions-and-Grouping" 
