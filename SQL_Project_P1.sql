-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
WHERE sale_date = "2022-11-05";

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category = "clothing" and quantiy >= 4 and year(sale_date)= 2022 and month(sale_date)= 11;

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category

select category, sum(total_sale) as net_sales  from retail_sales
GROUP BY 1;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(AVG(age),2) as avg_age  from retail_sales
WHERE category = "Beauty";

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT * from retail_sales
where total_sale>1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category 

select category , gender , count(transactions_id) as total_transactions from retail_sales
GROUP BY gender,category ORDER BY 1 ;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year , month ,
avg_sale from
(select year(sale_date) as year , month(sale_date) as month,
round(avg(total_sale),2) as avg_sale,
rank ()over(partition by year(sale_date) order by avg(total_sale) desc ) as Rank_
from retail_sales
group by 1,2) as t1 
where Rank_ = 1 ;

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales

select DISTINCT(customer_id) as customer , sum(total_sale)
from retail_sales 
GROUP BY 1 ORDER BY 2 desc limit 5 ;

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

select category , count(DISTINCT customer_id) as unique_customer from retail_sales
GROUP BY 1 ;

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17

with hourly_safe
as
(select *,
	case 
		when hour(sale_time)<12 then 'Morning'
        when hour(sale_time)<18 then 'Afternoon'
        else 'Evening'
	end as shift
from retail_sales)
select shift,count(transactions_id) from hourly_safe
GROUP BY 1 ;

-- End of Project