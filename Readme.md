# SQL Sales Analysis Project

## 📌 Project Overview
This project contains a collection of SQL queries designed to analyze sales, customer behavior, product performance, and discount impacts.  
The dataset simulates an e-commerce / retailscenario, covering orders, customers, products, returns, and shipping details.

## 📂 Dataset Structure
The database consists of the following key tables:
- customers – Customer details (ID, name, segment, region)
- orders – Order-level information (order date, ship date, customer ID)
- order_details – Product-level order details (sales, profit, discount, category)
- products – Product catalog (product name, category, sub-category)
- returns – Returned orders information

## 📊 Key Insights
The queries help answer:
- Sales trends and performance across regions, segments, and categories
- Top customers and profitable products
- Discount impact on profitability
- Customer retention and repeat purchase rate
- Monthly sales trends

## 🗂 SQL Queries
This project covers 17 SQL analysis questions:

1. Total number of customers in each segment
2. Top 10 customers by total sales
3. Most frequent buyers
4. Customers inactive in last 6 months
5. Total sales & profit by region
6. Distinct customers by region
7. Customers purchasing all three categories
8. Repeat purchase rate
9. Average order value per segment
10. Sales, profit & discount per category
11. Products with highest total discount
12. Average profit margin by category
13. Top 5 most profitable products
14. Impact of discount on profit
15. Monthly sales trend
16. Orders shipped late
17. Returned orders per category

## 🛠 SQL Functions & Concepts Used
- Aggregation: SUM(), AVG(), COUNT()
- Joins: INNER JOIN, LEFT JOIN
- Grouping: GROUP BY, HAVING
- Date functions: DATE_FORMAT(), DATE_SUB(), DATE_ADD()
- Filtering: WHERE with ranges & conditions
- Ordering & Limiting: ORDER BY, LIMIT



