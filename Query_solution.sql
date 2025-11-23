use retail_sales;
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail
where sale_date<='2022-11-05';

-- -- Q.2 Write a SQL query to retrieve all transactions where the category is
--    'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT 
    *
FROM
    retail
WHERE
    category = 'Clothing' AND quantity > 3
        AND sale_date >= '2022-11-01'
        AND sale_date < '2022-12-01';
        
-- -- Q.3 Write a SQL query to calculate the total sales (total_sale)
--  and total Quantity  for each category.
SELECT 
    category,
    SUM(total_sale) AS total,
    COUNT(quantity) AS total_order
FROM
    retail
GROUP BY category;

-- 4.  Q.4 Write a SQL query to find the average age of customers
-- and total paid amount by them  who purchased items from the 'Beauty' category.
SELECT 
    category,
    ROUND(AVG(age), 0) AS average_age,
    SUM(total_sale) AS total_paid_amount
FROM
    retail
WHERE
    category = 'Beauty';
    
-- -- Q.5 Write a SQL query to find all transactions 
-- 		where the total_sale is greater than 1000.

SELECT 
    *
FROM
    retail
WHERE
    total_sale > 1000;
    
-- Q.6 Write a SQL query to find the total number of transactions
--  (transaction_id) made by each gender in each category.

select category,gender ,count(*) as total_trans
from retail 
group by  category,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month.
--  Find out best selling month in each year

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

-- Q.8 Write a SQL query to find the top 5 
-- customers based on the highest total sales 
SELECT 
    customer_id, SUM(total_sale) AS total_amount_paid
FROM
    retail
GROUP BY customer_id
ORDER BY total_amount_paid DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique 
--     customers who purchased items from each category.
SELECT 
    category, COUNT(DISTINCT customer_id) AS unique_customer
FROM
    retail
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example 
-- Morning <=12, Afternoon Between 12 & 17, Evening >17)

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