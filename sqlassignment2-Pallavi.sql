create database superstores;
select * from superstores.cust_dimen;
select * from superstores.market_fact;
select * from superstores.orders_dimen;
select * from superstores.shipping_dimen;
select * from superstores.prod_dimen;
-- 1. Write a query to display the Customer_Name and Customer Segment using alias 
-- name “Customer Name", "Customer Segment" from table Cust_dimen.
select customer_name as "customer Name",customer_segment as "customer segment" from superstores.cust_dimen;

-- 2. Write a query to find all the details of the customer from the table cust_dimen 
-- order by desc.
select * from superstores.cust_dimen order by customer_name desc;

-- 3. Write a query to get the Order ID, Order date from table orders_dimen where 
-- ‘Order Priority’ is high
select order_ID,Order_date from superstores.orders_dimen where Order_Priority="high";

-- 4. Find the total and the average sales (display total_sales and avg_sales)
select sum(sales) as total_sales,avg(sales) as avg_sales from superstores.market_fact;

-- 5. Write a query to get the maximum and minimum sales from maket_fact table.
select max(sales) as MAX_SALES,min(sales) as MIN_SALES from superstores.market_fact;

-- 6. Display the number of customers in each region in decreasing order of 
-- no_of_customers. The result should contain columns Region, no_of_customers.
select region,count(distinct customer_name) as no_of_customer from superstores.cust_dimen group  by region order by 2 desc;


-- 7. Find the region having maximum customers (display the region name and 
-- max(no_of_customers)
SELECT region as "Region name", COUNT(DISTINCT cust_id) AS NO_of_Customer
FROM cust_dimen
GROUP BY region
HAVING COUNT(DISTINCT cust_id) =
(SELECT MAX(No_of_customer)
 FROM
 (SELECT region, COUNT(DISTINCT cust_id) AS No_of_customer
  FROM cust_dimen
  GROUP BY region) sub);



-- 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
-- and the number of tables purchased (display the customer name, no_of_tables 
-- purchased) 
select Customer_Name, count(market_fact.Prod_id)
from cust_dimen join
     market_fact 
     on  market_fact.Cust_id = cust_dimen.Cust_id 
	join
     prod_dimen
     on prod_dimen.Prod_id = market_fact.Prod_id
where Region = 'ATLANTIC' and Product_Sub_Category = 'TABlES'
group by Customer_name;


  

-- 9.Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners_
 select Customer_name , count(Customer_Segment) as "no of small bussiness owner" from cust_dimen where Province="Ontario" and Customer_Segment = "SMALL BUSINESS"
group by Customer_name;



-- 12.Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
select Product_Category as "Product Category", round(sum(Profit), 2) as "Profits"
from market_fact 
        join prod_dimen on market_fact.Prod_id = prod_dimen.Prod_id
group by Product_Category
Order by sum(Profit) DESC;


-- 13. Display the product category, product sub-category and the profit within each subcategory in three columns.
select Product_Category as "Product Category", Product_Sub_Category as "Product Sub Category",
		round(sum(Profit), 2) as "Total Profits"
from market_fact 
        join prod_dimen  on market_fact.Prod_id = prod_dimen.Prod_id
group by Product_Sub_Category
Order by Product_Category;

-- 10.Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) 
select prod_dimen.Prod_id as "product id",count(prod_dimen.Prod_id) as "no_of_products" from market_fact join prod_dimen on market_fact.Prod_id=prod_dimen.Prod_id 
group by market_fact.Prod_id 
order by no_of_products desc;

-- 11.  Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. 
-- The result should contain columns product id, product sub category.
 select Prod_id as "Product id" ,Product_Sub_Category as "Product sub category" from prod_dimen 
 where Product_Category ="FURNITURE" or Product_Category="TECHNOLOGY";

-- 14. Display the order date, order quantity and the sales for the order.
select orders_dimen.Order_Date,market_fact.Order_Quantity,market_fact.Sales from orders_dimen join market_fact on orders_dimen.Ord_id=market_fact.Ord_id;

-- 15. Display the names of the customers whose name contains the 
 -- i) Second letter as ‘R’
--  ii) Fourth letter as ‘D’
select cust_dimen.Customer_Name from cust_dimen where upper(cust_dimen.Customer_Name) like "_r_d%";

-- 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and 
-- their region where sales are between 1000 and 5000.
select cust_dimen.Cust_id,market_fact.Sales,cust_dimen.Customer_Name,cust_dimen.Region from cust_dimen 
join market_fact on cust_dimen.Cust_id=market_fact.Cust_id where market_fact.Sales between 1000 and 5000;

-- 17. Write a SQL query to find the 3rd highest sales
select market_fact.Sales from market_fact order by market_fact.Sales desc limit 2,1;

-- 18. Where is the least profitable product subcategory shipped the most? For the least 
-- profitable product sub-category, display the region-wise no_of_shipments and the 
-- profit made in each region in decreasing order of profits (i.e. region, 
-- no_of_shipments, profit_in_each_region
select cust_dimen.region,count(market_fact.Ship_id) as no_of_shipments,prod_dimen.Product_Sub_Category,market_fact.Profit as Profit_in_each_region from 
(market_fact join prod_dimen on market_fact.prod_id=prod_dimen.prod_id )join cust_dimen on market_fact.cust_id=cust_dimen.cust_id 
 group by  region 
order by Profit_in_each_region ,prod_dimen.Product_Sub_Category;





