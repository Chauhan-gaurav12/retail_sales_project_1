# retail_sales_project_1

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales`

The Retail Sales Database is designed to store, manage, and analyze sales-related information for a retail business. It provides a structured relational model that captures key business entities such as products, customers, orders, stores, and sales transactions. This database enables smooth tracking of daily operations, generating insights, and supporting data-driven decision making.

## Project Structure

### 1. Database Setup
- **Database Creation**: The project starts by creating a database named retail_sales

-  **Table Creation**: A table named `retail` is created to store the sales data. The table structure includes columns for transaction_ID, sale_date, sale_time, customer_ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_sales;

CREATE TABLE retail
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

```sql
SELECT 
    *
FROM
    retail
WHERE
    sale_date <= '2022-11-05';
```

Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

```sql
SELECT 
    *
FROM
    retail
WHERE
    category = 'Clothing' AND quantity > 3
        AND sale_date >= '2022-11-01'
        AND sale_date < '2022-12-01';
```

Q.3 Write a SQL query to calculate the total sales (total_sale) and total Quantity  for each category.

```sql
SELECT 
    category,
    SUM(total_sale) AS total,
    COUNT(quantity) AS total_order
FROM
    retail
GROUP BY category;
```

 Q.4 Write a SQL query to find the average age of customers and total paid amount by them  who purchased items from the 'Beauty' category.

 ```sql
SELECT 
    category,
    ROUND(AVG(age), 0) AS average_age,
    SUM(total_sale) AS total_paid_amount
FROM
    retail
WHERE
    category = 'Beauty';
```

 Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

```sql
SELECT 
    *
FROM
    retail
WHERE
    total_sale > 1000;
```

Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

```sql
SELECT 
    category, gender, COUNT(*) AS total_trans
FROM
    retail
GROUP BY category , gender;
```
Q.7 Write a SQL query to calculate the average sale for each month.Find out best selling month in each year

```sql
select * from
(SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS Month,
    SUM(total_sale) AS total_sales,
    RANK() OVER(
        PARTITION BY YEAR(sale_date)
        ORDER BY SUM(total_sale) DESC
    ) as ranking
FROM retail
GROUP BY 
    YEAR(sale_date), 
    MONTH(sale_date)
ORDER BY 
    year, 
    total_sales DESC) as total
    where ranking=1;
```

Q.8 Write a SQL query to find the top 5  customers based on the highest total sales 

```sql
SELECT 
    customer_id, SUM(total_sale) AS total_amount_paid
FROM
    retail
GROUP BY customer_id
ORDER BY total_amount_paid DESC
LIMIT 5;
```

Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

```sql
SELECT 
    category, COUNT(DISTINCT customer_id) AS unique_customer
FROM
    retail
GROUP BY category;
```

Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

```sql
select 
case 
when hour(sale_time) < 12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'AfterNoon'
else 'Evening'
end as shift,
count(*) as total_orders
from retail 
group by shift
order by total_orders desc;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

  ## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `retail_sales` file to create and populate the database.


