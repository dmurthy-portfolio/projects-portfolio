create database supply_chain;
use supply_chain;
select * from orders;
select * from ordered_items;
select * from product_info;
select * from customer_info;
select * from category;
select * from department;

--  Get the number of orders by the Type of Transaction. Please exclude orders shipped from Sangli and Srinagar. 
-- Also, exclude the SUSPECTED_FRAUD cases based on the Order Status. Sort the result in the descending order based on the number of orders

select type as transaction_type, count(order_id) as orders
from orders
where order_city not in ('Sangali', 'Srinagar')
and order_status != 'SUSPECTED_FRAUD'
group by type
order by orders desc;

 -- Get the list of the Top 3 customers based on the completed orders along with the following details:
-- ● Customer Id
-- ● Customer First Name
-- ● Customer City
-- ● Customer State
-- ● Number of completed orders
-- ● Total Sales 

select c.id as customer_id, c.first_name, c.city, c.state,
count(distinct o.order_id) as completed_orders, sum(d.sales) as total_sales
from orders o 
join ordered_items d on o.order_id = d.order_id
join customer_info c on o.customer_id = c.id
where o.order_status = 'COMPLETE'
group by c.id, c.first_name, c.city, c.state
order by completed_orders desc
limit 3;

-- Get the order count by the Shipping Mode and the Department Name. Consider 
-- departments with at least 40 closed/completed orders

WITH valid_departments AS (
 SELECT d.name
 FROM orders o
 JOIN ordered_items oi ON o.order_id = oi.order_id
 JOIN product_info p ON oi.item_id = p.product_id
 JOIN department d ON p.department_id = d.id
 WHERE o.order_status IN ('COMPLETE', 'CLOSED')
 GROUP BY d.name
 HAVING COUNT(DISTINCT o.order_id) >= 40
)
SELECT o.shipping_mode, d.name AS department_name,
 COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN product_info p ON oi.item_id = p.product_id
JOIN department d ON p.department_id = d.id
WHERE o.order_status IN ('COMPLETE', 'CLOSED')
 AND d.name IN (SELECT name FROM valid_departments)
GROUP BY o.shipping_mode, d.name;

-- Create a new field as shipment compliance based on
-- Real_Shipping_Days and Scheduled_Shipping_Days. It should have
-- the following values:
-- ● Cancelled shipment - If the Order Status is SUSPECTED_FRAUD or CANCELED
-- ● Within schedule - If shipped within the scheduled number of days
-- ● On time - If shipped exactly as per schedule
-- ● Upto 2 days of delay - If shipped beyond schedule but delay upto 2 days
-- ● Beyond 2 days of delay - If shipped beyond schedule with delay beyond 2 days
-- Which shipping mode was observed to have the greatest number
-- of delayed orders

-- Create shipment_compliance field per order
select *,
case
when order_status in ('SUSPECTED_FRAUD', 'CANCELED') then 'Cancelled shipment'
when real_shipping_days < scheduled_shipping_days then 'Within schedule'
when real_shipping_days = scheduled_shipping_days then 'On time'
when real_shipping_days - scheduled_shipping_days <=2 then 'Upto 2 days of delay'
else 'Beyond 2 days of delay'
end as shipment_compliance
from orders;

-- Delayed orders by shipping mode
select shipping_mode, count(order_id) as delayed_orders
from orders
where real_shipping_days > scheduled_shipping_days
group by shipping_mode
order by delayed_orders desc
limit 1;

-- An order is cancelled when the status of the order is either
-- cancelled or SUSPECTED_FRAUD. Obtain the list of states by
-- the order cancellation % and sort them in the descending order of the cancellation %
-- ● Definition: Cancellation % = Cancelled orders / Total Order

with cancelled_orders as (
select order_state, count(*) as cancelled_count
from orders
where order_status in ('CANCELLED', 'SUSPECTED_FRAUD')
group by order_state
),
total_orders as (
select order_state, count(*) as total_count
from orders
group by order_state
)
select t.order_state,
round(c.cancelled_count * 100.0/t.total_count,2) as cancellation_percentage
from cancelled_orders c 
join total_orders t on c.order_state = t.order_state
order by cancellation_percentage desc;

-- like operators: %- 0 or any num of char
                   -- _ - single char
use practice;
select * from myemp;
select * from myemp where FIRST_NAME like "s%";
select * from myemp where FIRST_NAME like "s_____";

select * from myemp where FIRST_NAME like "a%a";             
select * from myemp where FIRST_NAME like "%sh%";

     




-- extras
describe orders;
SELECT DISTINCT order_date FROM orders LIMIT 10;

-- Monthly trend of total, completed, and canceled orders
select
    date_format(str_to_date(order_date, '%m/%d/%Y'), '%Y-%m') as month,
    order_status,
    COUNT(*) as order_count
from orders
group by month, order_status
order by month;

-- Orders by day of the week
select 
    dayname(str_to_date(order_date, '%m/%d/%Y')) AS weekday, 
    COUNT(*) as order_count
from orders
group by weekday
order by field(weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Avg items per order per shipping mode
SELECT shipping_mode, AVG(item_count) AS avg_items
FROM (
 SELECT o.order_id, o.shipping_mode, COUNT(*) AS item_count
 FROM orders o
 JOIN ordered_items oi ON o.order_id = oi.order_id
 GROUP BY o.order_id, o.shipping_mode
) sub
GROUP BY shipping_mode;

-- . Monthly unique customer count
select date_format(str_to_date(order_date, '%m/%d/%Y'), '%Y-%m') as month,
count(distinct customer_id) as unique_customers
from orders
group by month;

-- Peak sales months
select date_format(str_to_date(order_date, '%m/%d/%Y'), '%Y-%m') as month,
sum(oi.sales) as total_sales
from orders o 
join ordered_items oi on o.Order_Id = oi.Order_Id
group by month
order by total_sales desc;

-- Top customer segments by average sales per order
select c.state, avg(oi.sales) as avg_order_value
from orders o 
join customer_info c on o.Customer_Id = c.id
join ordered_items oi on o.Order_Id = oi.Order_Id
group by c.state
order by avg_order_value desc;

-- Monthly customer churn (customers who didn't return)
SELECT this_month.month, COUNT(DISTINCT this_month.customer_id) AS churned_customers
FROM (
 SELECT DISTINCT customer_id, DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month
 FROM orders
) this_month
LEFT JOIN (
 SELECT DISTINCT customer_id, DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month
 FROM orders
) next_month
ON this_month.customer_id = next_month.customer_id
 AND this_month.month < next_month.month
WHERE next_month.customer_id IS NULL
GROUP BY this_month.month;

-- Customers with highest number of canceled/fraud orders
SELECT o.customer_id, COUNT(*) AS canceled_count
FROM orders o
WHERE o.order_status IN ('CANCELED', 'SUSPECTED_FRAUD')
GROUP BY o.customer_id
ORDER BY canceled_count DESC
LIMIT 10;

-- Percentage of customers with more than 1 orders
WITH customer_orders AS (
  SELECT customer_id, COUNT(order_id) AS order_count
  FROM orders
  GROUP BY customer_id
)
SELECT 
  ROUND(
    COUNT(CASE WHEN order_count > 1 THEN 1 END) * 100.0 / COUNT(*), 2
  ) AS percent_high_order_customers
FROM customer_orders;

--  Average real shipping time by state or city
SELECT order_state, AVG(real_shipping_days) AS avg_shipping_days
FROM orders
WHERE order_status IN ('COMPLETE', 'CLOSED')
GROUP BY order_state
ORDER BY avg_shipping_days DESC;

-- Percentage of early, on-time, and delayed shipments per department
SELECT d.name AS department_name,
  SUM(CASE WHEN o.real_shipping_days < o.scheduled_shipping_days THEN 1 ELSE 0 END) AS early,
  SUM(CASE WHEN o.real_shipping_days = o.scheduled_shipping_days THEN 1 ELSE 0 END) AS on_time,
  SUM(CASE WHEN o.real_shipping_days > o.scheduled_shipping_days THEN 1 ELSE 0 END) AS delay
FROM orders o
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN product_info p ON oi.item_id = p.product_id
JOIN department d ON p.department_id = d.id
GROUP BY d.name;

-- Departments linked to the most delayed shipments
SELECT d.name AS department_name, COUNT(*) AS delayed_orders
FROM orders o
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN product_info p ON oi.Item_Id = p.product_id
JOIN department d ON p.department_id = d.id
WHERE o.real_shipping_days > o.scheduled_shipping_days
GROUP BY d.name
ORDER BY delayed_orders DESC;

-- Cities with frequent delays despite short scheduled shipping (<3 days)
SELECT o.order_city, COUNT(*) AS delayed_count
FROM orders o
WHERE o.scheduled_shipping_days < 3 
  AND o.real_shipping_days > o.scheduled_shipping_days
GROUP BY o.order_city
ORDER BY delayed_count DESC;

-- Department-wise contribution to total revenue
SELECT d.name AS department_name, SUM(oi.sales) AS total_sales
FROM ordered_items oi
JOIN product_info p ON oi.Item_Id = p.product_id
JOIN department d ON p.department_id = d.id
GROUP BY d.name
ORDER BY total_sales DESC;

-- Average order value per shipping mode
SELECT o.shipping_mode, AVG(order_sales.total_sales) AS avg_order_value
FROM (
  SELECT order_id, SUM(sales) AS total_sales
  FROM ordered_items
  GROUP BY order_id
) order_sales
JOIN orders o ON o.order_id = order_sales.order_id
GROUP BY o.shipping_mode;

-- Most returned (canceled/fraud) departments by sales value
SELECT d.name AS department_name, SUM(oi.sales) AS canceled_sales
FROM orders o
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN product_info p ON oi.Item_Id = p.product_id
JOIN department d ON p.department_id = d.id
WHERE o.order_status IN ('CANCELED', 'SUSPECTED_FRAUD')
GROUP BY d.name
ORDER BY canceled_sales DESC;

-- Average revenue per order in each customer state
SELECT c.state, AVG(oi.sales) AS avg_sales_per_order
FROM orders o
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN customer_info c ON o.customer_id = c.id
GROUP BY c.state
ORDER BY avg_sales_per_order DESC;

-- Correlation between order value and fraud rate
SELECT 
  CASE 
    WHEN bucket.total_sales < 500 THEN '<500'
    WHEN bucket.total_sales BETWEEN 500 AND 1000 THEN '500-1000'
    ELSE '>1000'
  END AS value_range,
  COUNT(CASE WHEN o.order_status = 'SUSPECTED_FRAUD' THEN 1 END) AS fraud_count,
  COUNT(*) AS total_orders,
  ROUND(COUNT(CASE WHEN o.order_status = 'SUSPECTED_FRAUD' * 100.0 / COUNT(*), 2) AS fraud_rate_percent
FROM (
  SELECT o.order_id, SUM(oi.sales) AS total_sales
  FROM orders o
  JOIN ordered_items oi ON o.order_id = oi.order_id
  GROUP BY o.order_id
) bucket
JOIN orders o ON o.order_id = bucket.order_id
GROUP BY value_range;


-- States with consistently high cancellation rates
SELECT order_state, 
  ROUND(SUM(CASE WHEN order_status IN ('CANCELED', 'SUSPECTED_FRAUD') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancel_rate
FROM orders
GROUP BY order_state
HAVING cancel_rate > 20
ORDER BY cancel_rate DESC;

-- Cancellation rate by department
SELECT d.name AS department_name,
  ROUND(SUM(CASE WHEN o.order_status IN ('CANCELED', 'SUSPECTED_FRAUD') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancel_rate
FROM orders o
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN product_info p ON oi.Item_Id = p.product_id
JOIN department d ON p.department_id = d.id
GROUP BY d.name
ORDER BY cancel_rate DESC;






select * from ordered_items;

