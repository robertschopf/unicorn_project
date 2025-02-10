/*	Question	1. How many customers do we have in the data? */

SELECT 	COUNT(customer_id) AS total_count_customerids
--				, COUNT (customer_name) AS total_customer_by_name
FROM customers
;


/*	Question	2. What was the city with the most profit for the company in 2015? */

SELECT 	shipping_city ,SUM(od.order_profits) AS total_profits
--				,EXTRACT(YEAR FROM order_date) AS year
FROM orders o
LEFT JOIN order_details od ON o.order_id = od.order_id
WHERE EXTRACT(YEAR FROM order_date) = 2015
GROUP BY shipping_city --,year
ORDER BY SUM(od.order_profits) DESC
LIMIT 3
;
                        
              
              
/*	Question	3. In 2015, what was the most profitable city's profit?	*/

SELECT /*shipping_city ,*/SUM(od.order_profits) AS total_profits
--				,EXTRACT(YEAR FROM order_date) AS year
FROM orders o
LEFT JOIN order_details od ON o.order_id = od.order_id
WHERE EXTRACT(YEAR FROM order_date) = 2015
GROUP BY shipping_city --,year
ORDER BY total_profits DESC
LIMIT 3
;            
              
/* Question		4. How many different cities do we have in the data?	*/

SELECT	COUNT(DISTINCT shipping_city) number_cities 
--				,COUNT(shipping_postal_code) AS total_number_postal_codes
FROM orders
;

/* Question		5. Show the total spent by customers from low to high. */

SELECT customer_id, SUM(order_sales) AS total_spend_by_customer
FROM customers
JOIN orders USING(customer_id)
LEFT JOIN order_details USING (order_id)
GROUP BY customer_id
ORDER BY total_spend_by_customer ASC
;

/* Question		6. What is the most profitable city in the State of Tennessee? */

SELECT shipping_city, SUM(order_profits) AS total_profit_by_city
FROM orders
LEFT JOIN order_details USING (order_id)
WHERE shipping_state = 'Tennessee'
GROUP BY shipping_city
ORDER BY total_profit_by_city DESC
LIMIT 3
;

/* Question		7. What's the average annual profit for that city across all years? */
/*
SELECT EXTRACT(YEAR FROM order_date), AVG(order_profits) AS avg_profit
FROM orders
LEFT JOIN order_details USING (order_id)
WHERE shipping_city = 'Lebanon'
GROUP BY order_date
ORDER BY order_date DESC
;
*/
-- through every 3 years    

SELECT 	shipping_city AS city,
				AVG(order_profits) AS avg_profit
FROM order_details
JOIN orders USING (order_id)
WHERE shipping_city='Lebanon'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
;

/* Question		8. What is the distribution of customer types in the data? */

SELECT customer_segment, COUNT(DISTINCT customer_id) AS total_custo_via_segment
				,ROUND(COUNT(DISTINCT customer_id) * 100.0 / SUM(COUNT(DISTINCT customer_id)) OVER (), 2) AS perc_distribution	
FROM customers
GROUP BY customer_segment
;

/* Question		9. What's the most profitable product category on average in lowa across all years? */

/* divided for all individual years !!!

SELECT product_category, SUM(order_profits) AS total_profit
FROM product
LEFT JOIN order_details USING (product_id)
GROUP BY product_category
ORDER BY total_profit DESC
;*/

SELECT p.product_category
FROM order_details od
	JOIN product p USING(product_id)
  JOIN orders o USING(order_id)
WHERE o.shipping_state = 'Iowa'
ORDER BY SUM(od.order_sales) OVER (PARTITION BY p.product_category) DESC
LIMIT 1
;

/* Question		10. What is the most popular product in that category across all states in 2016? */

SELECT product_name, SUM(quantity) AS count_quantity_by_name
FROM product
LEFT JOIN order_details USING (product_id)
LEFT JOIN orders USING(order_id)
WHERE EXTRACT(YEAR FROM order_date) = 2016
			AND product_category = 'Furniture'
GROUP BY 1
ORDER BY count_quantity_by_name DESC
LIMIT 1
;

/* Question		11. Which customer got the most discount in the data? (in total amount) */

WITH retail_prices AS (
      SELECT customer_id,order_sales
             ,ROUND(order_sales / (1 - order_discount)::NUMERIC, 2) AS retail_prices
      FROM order_details
  		LEFT JOIN orders USING(order_id)
      LEFT JOIN customers USING(customer_id)
  		),
		sales_price_customer AS (
			SELECT  customer_id, SUM(order_sales) AS total_salesprices
      FROM order_details
      LEFT JOIN orders USING(order_id)
      LEFT JOIN customers USING(customer_id)
      GROUP BY customer_id
      )
SELECT 	customer_id, customer_name,
				SUM(retail_prices) AS total_retail_prices, total_salesprices,
        SUM(retail_prices) - total_salesprices AS total_discounts
FROM customers
JOIN sales_price_customer USING (customer_id)
JOIN retail_prices USING (customer_id)
--WHERE total_salesprices IS NOT NULL
GROUP BY customer_id, customer_name, total_salesprices
ORDER BY total_discounts DESC
LIMIT 3
;

/* Question		12. How widely did monthly profits vary in 2018? */

WITH monthly_profits AS (
      SELECT EXTRACT(month FROM order_date) as month, SUM(order_profits) AS monthly_profit
      FROM orders
      LEFT JOIN order_details USING(order_id)
      WHERE EXTRACT(YEAR FROM order_date) = 2018
      GROUP BY EXTRACT(month FROM order_date)
      ORDER BY month
  		)
SELECT 	month, monthly_profit,
--				LAG(monthly_profit) OVER (ORDER BY month) AS previous_profit,
				CASE WHEN LAG(monthly_profit) OVER (ORDER BY month) IS NULL THEN NULL  
        ELSE (monthly_profit - LAG(monthly_profit) OVER (ORDER BY month)) END AS month_difference,
        ROUND(CASE WHEN LAG(monthly_profit) OVER (ORDER BY month) IS NULL THEN NULL
        ELSE (monthly_profit - LAG(monthly_profit) OVER (ORDER BY month)) *100 / LAG(monthly_profit) OVER (ORDER BY month)
        END ::NUMERIC,2) AS percent_change
FROM monthly_profits
GROUP BY month, monthly_profit
;

/* Question		13. Which was the biggest order regarding sales in 2015? */

SELECT 	order_id, 
				SUM(order_sales) AS biggest_order_sales
FROM orders 
FULL JOIN order_details USING(order_id)
WHERE EXTRACT(year FROM order_date) = 2015
GROUP BY order_id
ORDER BY SUM(order_sales) DESC
LIMIT 1
;

/* Question		14. What was the rank of each city in the East region in 2015 in quantity? */

WITH total_quantity AS (
      SELECT SUM(quantity) AS total_quantity, shipping_city, shipping_region
      FROM orders
      LEFT JOIN order_details USING(order_id)
      WHERE shipping_region = 'East'
  					AND EXTRACT(YEAR FROM order_date) = 2015
      GROUP BY shipping_city, shipping_region
      ORDER BY total_quantity DESC
  		)
SELECT RANK() OVER (ORDER BY total_quantity DESC), shipping_city, total_quantity
FROM total_quantity
GROUP BY shipping_city, total_quantity
;

/* Question		15. Display customer names for customers who are in the segment 'Consumer' or
									'Corporate! How many customers are there in total? */

SELECT 	customer_name, customer_segment,
				COUNT(customer_segment) OVER (PARTITION BY customer_segment) AS total_segments,
        COUNT(customer_id) OVER () AS total_customer
FROM customers
WHERE 1=1	AND customer_segment IN ('Consumer', 'Corporate')
;

/* Question		16. Calculate the difference between the largest and smallest order quantities for product id '100.' */

SELECT product_id, MAX(quantity), MIN(quantity),
				MAX(quantity)-MIN(quantity) AS quantity_difference
FROM order_details
WHERE product_id = 100
GROUP BY product_id
;

/* Question		17. Calculate the percent of products that are within the category 'Furniture! */

SELECT	ROUND((COUNT(CASE WHEN product_category = 'Furniture' THEN 1 END) * 100.0) / COUNT(*),2) AS furniture_percentage
FROM product
;

/*
WITH cte AS (
SELECT --distinct p.product_category
  		 SUM(CASE WHEN product_category IN ('Furniture') THEN 1 END) AS Furniture
  		,SUM(CASE WHEN product_category IN ('Technology') THEN 1 END) AS Technology
  		,SUM(CASE WHEN product_category IN ('Office Supplies') THEN 1 END) AS Office_Supplies
      ,SUM(CASE WHEN product_category IN ('Furniture','Technology','Office Supplies') THEN 1 END)::NUMERIC AS all_products
			
--		,COUNT(p.product_name) OVER (PARTITION BY p.product_category) products_by_category
FROM product p
)
SELECT ROUND(Furniture / all_products *100.0,2) AS perc_furniture
			,ROUND(Technology / all_products *100.0,2) AS perc_technology
      ,ROUND(Office_Supplies / all_products *100.0,2) AS perc_office_supplies
FROM cte;
*/


/* Question		18. Display the number of product manufacturers with more than 1 product in the product table. */

WITH total_products AS (
      SELECT product_manufacturer, COUNT(product_id) AS total_products
      FROM product
      GROUP BY product_manufacturer
      ORDER BY total_products ASC
  		)
SELECT product_manufacturer ,total_products
FROM total_products
WHERE total_products > 1
ORDER BY total_products 

SELECT product_manufacturer, COUNT(product_id) AS count_product_ids
FROM product
GROUP BY product_manufacturer
HAVING COUNT(product_id) > 1
;


/* Question		19. Show the product_subcategory and the total number of products in the subcategory.
									Show the order from most to least products and then by product_subcategory name ascending. */

SELECT product_subcategory ,COUNT(product_id) AS total_products
FROM product
GROUP BY product_subcategory
ORDER BY total_products DESC ,product_subcategory ASC
;

/* Question		20. Show the product_id(s), the sum of quantities, where the total sum of its product quantities is greater than or equal to 100. */

SELECT product_id, SUM(quantity) AS sum_quantities
FROM order_details
WHERE quantity >= 100
GROUP BY product_id
ORDER BY product_id ASC
;


/* ⭐ Bonus question:		Join all database tables into one dataset that includes all unique columns and download it as a .csv file. */

SELECT *
FROM customers c
JOIN orders o USING(customer_id)
JOIN order_details od USING(order_id)
JOIN product p USING(product_id)
;