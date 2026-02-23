use sql_project_practice;
-- SQL Retail sales Annalysis 
Create Table retail_sales
(
             transactions_id INT PRIMARY KEY,	
			 sale_date DATE,
             sale_time TIME,
		     customer_id INT,
             gender VARCHAR(15),	
			 age INT,	
             category VARCHAR(15),
			 quantiy INT,
             price_per_unit FLOAT,
             cogs FLOAT,	
             total_sale FLOAT
);
select * from retail_sales
Limit 10;

select 
      Count(*)
From retail_sales;

select * from retail_sales
where transcations_id is NULL;
select * from retail_sales
where sale_date is NULL;
select * from retail_sales
where sale_time is NULL;

select * from retail_sales
where 
     transcations_id is null 
     or 
     sale_date is NUll
     or 
     sale_time is Null 
     or 
     gender is Null 
     or 
     customer_id is Null 
     or 
     age is Null 
     or 
     category is Null 
     or 
     quantity is Null
     or 
     price_per_unit is Null 
     or 
     cogs is Null
     or 
     total_sale is Null; 
--- How many sales we have?
Select COUNT(*) as total_sale From retail_sales;

--- How many unique customers we have?
SELECT Count(Distinct customer_id) as total_sale from retail_sales;
Select Distinct Category from retail_sales;  

--- 1.Write a sql query to retrieve all columns for sales made on 2022-11-05
select * 
from retail_sales 
where sale_date = '2022-11-05'; 

-- 2.Write a sql query to retrieve all transcations where there category is 'clothing' and the quantity sold is more than  in the month of Nov 2022
Select *
From retail_sales
where category = 'clothing'
    AND quantiy >=4 
	AND sale_date >= '2022-11-01'
    AND sale_date < '2022-12-01'
Limit 0, 50000;
-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.
select 
      category, 
      sum(total_sale) as net_sale,
      COUNT(*) as total_orders 
from retail_sales
group by 1 ; 

--- 4 Write a sql query to find the average age of customers who purchased items from the 'Beauty' category.
select 
    round(Avg(age),2) as avg_age
From retail_sales 
where category ='Beauty';

--- 5Q Write a sql query to find all transcations where the total_sale is greater than 1000. 
select 
   *
From retail_sales
Where total_sale >= 1000;

----- 6Q Write a sql query to find the toal number of transcations (transcation_id) made by each gender each category.
select 
    category,
    gender,
    count(*) as total_trans
from retail_sales 
group by category, 
		 gender
Order by 1;

--- 7Q (Imp)Write a sql query to calculate the average  sale for each month, Find out best month in each year. 
select 
     sale_year,
     sale_month,
     Avg_Total_Sales
FROM 
(
select 
     year(sale_date) as sale_year,
     month(sale_date) as sale_month,
     round(avg(total_sale),2) as Avg_Total_Sales ,
     rank() over(
			     partition by year(sale_date) 
                 order by avg(total_sale) DESC) as sales_rank
From retail_sales
Group by year(sale_date), month(sale_date)
) as t1 
where sales_rank = 1 ;
--- order by sale_year, avg_total_sales  DESC;

--- 8Q Write a sql query to find the top 5 customers based on the highest total sales? 
select 
      customer_id,
      sum(total_sale) as Total_sales_amount 
from retail_sales 
group by customer_id 
order by Total_sales_amount  desc
limit 5; 

--- 9Q Write a sql query to find the number of unique customers who purchased items from each category. 
select
	 category, 
     count(distinct customer_id) as cnt_unique_cs
From retail_sales
group by category;

---- 10Q Write a sql query to create each shift add number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
With hourly_sale 
AS
(
Select *,
      case 
      when hour(sale_time)<12 Then 'Morning'
      when Hour(sale_time) between 12 and 17 Then 'Afternoon'
      else'Evening'
   End as Shift 
From retail_sales 
)
select 
      shift, 
      Count(*) as total_orders
From hourly_sale 
Group by shift

