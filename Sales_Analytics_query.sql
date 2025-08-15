#Q1 Total number of customers in each segment.

SELECT segment, count(customer_id) as Count_customer_id FROM customers
group by segment;

#--> Customer distribution is fairly balanced across segments, with Consumers slightly leading, suggesting no single segment dominates the customer base.

#Q2 Top 10 customers by total sales amount.

SELECT t2.customer_id, Round(Sum(sales),2) AS Total_Sales FROM order_details t1
JOIN orders t2
on t1.order_id = t2.order_id
group by customer_id
order by Total_Sales desc
LIMIT 10;

#--> A small group of high-value customers drives a significant portion of revenue, ideal for targeted loyalty programs.

#Q3 Number of orders placed per customer.

SELECT customer_id, Count(order_id) AS Total_orders FROM orders
group by customer_id
order by Total_orders desc;

#--> A few customers place frequent orders, showing potential for subscription or retention strategies

#Q4 Customers who haven’t placed any orders in the last 6 months of available data.

SELECT 
    t1.customer_id, 
    t1.customer_name,
    MAX(t2.order_date) AS last_order_date
FROM customers t1
JOIN orders t2
    ON t1.customer_id = t2.customer_id
GROUP BY t1.customer_id, t1.customer_name
HAVING last_order_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY last_order_date ASC;

#--> These inactive customers present a re-engagement opportunity.

#Q5 Total sales and profit by region.

SELECT 
t3.region, 
Round(Sum(t1.sales),2) AS Total_sales, 
Round(Sum(t1.profit),2) AS Total_Profits 
FROM order_details t1
join orders t2
on t1.order_id = t2.order_id
join customers t3
on t2.customer_id = t3.customer_id
group by region;

#--> The East region generates the highest profit, making it a strong focus for scaling operations.

#Q6 Number of distinct customers in each region.

SELECT region, Count(DISTINCT customer_id) as Total_customers FROM customers
group by region
order by total_customers desc;

#--> Customer concentration is highest in the East, indicating a mature but competitive market.

#Q7 Customers who purchased products from all three categories.

SELECT t2.customer_id, Count(DISTINCT category) AS category_count FROM order_details t1
JOIN orders t2
on t1.order_id = t2.order_id
group by customer_id
having category_count =3
order by customer_id;

#--> Multi-category buyers are a valuable segment, showing strong brand trust and cross-selling potential.

#Q8 Repeat purchase rate

SELECT (COUNT(*)/ (select count(distinct customer_id) from orders))*100 as Repeat_Purchase_Rate FROM 

(SELECT customer_id FROM orders 
group by customer_id
Having Count(order_id)>1) subs;

#--> A high repeat purchase rate suggests strong customer loyalty and satisfaction.( 66.825% )

#Q9 Average order value (AOV) per customer segment.

SELECT t3.segment, Round(AVG(t1.sales),2) AS Average_sales FROM order_details t1
join orders t2
on t1.order_id = t2.order_id
join customers t3
on t2.customer_id = t3.customer_id
group by segment;

#-->The Consumer segment shows the highest AOV, signaling better upselling potential in B2B channels.

#Q10 Total sales, profit, and average discount per category

SELECT category,
Round(Sum(Sales),2) as total_sales, 
Round(Sum(Profit),2) AS total_profit, 
Round(AVG(discount),2) AS Average_discount 
FROM order_details
group by category;

#--> Furniture yields the highest profit despite competitive discounting, proving it’s a core revenue driver

#Q11 Products with the highest total discount given.

SELECT product_name FROM order_details
where discount = (SELECT Max(Discount) From order_details)
order by product_name;

#--> These products may need margin optimization or review of discount policies.

#Q12 Average profit margin by category.

SELECT category, Round((SUM(sales)/Sum(profit))*100,2) AS Profitmargin FROM order_details 
group by category;

#--> Technology has the lowest profit margin, suggesting high cost of goods or aggressive discounting.

#Q13 Top 5 most profitable products.

SELECT t1.product_id, t2.product_name, Round(SUM(t1.profit),2) AS total_profit FROM order_details t1
JOIN products t2
on t1.product_id = t2.product_id
group by product_id, product_name
order by total_profit desc 
LIMIT 5 ;

#--> These top performers should be prioritized in promotions and stock management.

#Q14 Impact of discount on profit. 

Select Round(AVG(profit),2) AS Average_profit_low_discount from order_details
where discount between 0 and 0.20;

Select Round(AVG(profit),2) AS Average_profit_medium_discount from order_details
where discount between 0.21 and 0.35;

Select Round(AVG(profit),2) AS Average_profit_high_discount from order_details
where discount between 0.36 and 0.50;

#--> Higher discounts correlate with lower average profit, indicating discounting should be strategic.

#Q15 Monthly sales trend.

SELECT date_format(order_date, '%M-%Y')AS months, Round(Sum(sales),2) FROM order_details t1
JOIN orders t2
on t1.order_id = t2.order_id
group by date_format(order_date, '%M-%Y');

#--> Sales peak during year-end months, suggesting seasonal demand patterns.

#Q16 Orders shipped late

SELECT * from orders
where ship_date > date_add(ship_date, INTERVAL 3 DAY);

#--> No shipment were late (less tan or equal to 3 days delivery)

#Q17  Number of returned orders per category.

SELECT t1.category, Count(*)AS returned_orders FROM order_details t1
JOIN returns t2
on t1.order_id = t2.order_id
group by category;

#--> Office Supplies has the highest returns, possibly due to size, damage risk, or product dissatisfaction.