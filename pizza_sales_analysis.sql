select *
from project_excel;

/* FIND TOTAL REVENUE */
SELECT sum(total_price) AS total_revenue
from project_excel;

/* FIND AVERAGE ORDER VALUE*/
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS average_order_value
from project_excel;

/*FIND TOTAL PIZZA SOLD*/
SELECT SUM(quantity) AS total_order
from project_excel;

/*Total order placed*/
SELECT COUNT(DISTINCT order_id) AS total_order
FROM project_excel;

/*Average Pizza per order*/
SELECT SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS  average_pizza_per_order /* using '*' donot round up value */
from project_excel;

/*Daily trend for total orders based on day*/
;WITH daily_orders AS (
   SELECT order_date, order_id
   FROM project_excel
)
SELECT
   DATENAME(dw, order_date) AS order_day,
   COUNT(DISTINCT order_id) AS total_orders
FROM daily_orders
GROUP BY DATENAME(dw, order_date);

/*Daily trend for total orders based on hours*/
SELECT DATEPART(HOUR, order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders
from project_excel
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time) ASC;

/*To find percentage of sold pizza by category*/
SELECT
   pizza_category,
   SUM(total_price) * 100.0 /
   (SELECT SUM(total_price) FROM project_excel) AS sales_percentage
FROM project_excel
GROUP BY pizza_category;

/*To find the percentage of sold pizza by size*/
SELECT
   pizza_size,
   SUM(total_price) * 100.0 /
   (SELECT SUM(total_price) FROM project_excel) AS percentage_sales
FROM project_excel
GROUP BY pizza_size
ORDER BY pizza_size;

/*Total pizza sold by category*/
SELECT pizza_category,
SUM(quantity) as total_order
from project_excel
group by pizza_category;

/*TOP 5 BEST SELLER BY TOTAL PIZZA SOLD*/
SELECT top 5 pizza_name, SUM(quantity) as total_sold
from project_excel
group by pizza_name
order by SUM(quantity) desc;

/*Least sold*/
SELECT top 5 pizza_name, SUM(quantity) as total_sold
from project_excel
group by pizza_name
order by SUM(quantity) asc;
