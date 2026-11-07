# ecommerce-sales-analysis-sql
E-commerce sales analysis using SQL Server, covering sales trends, customer behaviour, product performance, and advanced SQL analysis.
# E-commerce Sales Analysis using SQL

## Project Overview

This project focuses on analyzing a synthetic e-commerce sales dataset using Microsoft SQL Server. The objective is to explore sales performance, customer purchasing behaviour, product performance, and order trends using SQL queries to extract meaningful business insights.

The project covers 28 business-analysis tasks organized into six SQL scripts.

## Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL

## Database Structure

The database contains four main tables:

- **Customers** – Customer information
- **Orders** – Order dates and statuses
- **OrderDetails** – Product quantities and unit prices
- **Products** – Product names and categories

## SQL Analysis

1. **Sales Overview** – Overall sales, order counts, and sales performance.
2. **Product & Category Analysis** – Product-wise and category-wise sales performance.
3. **Monthly & Yearly Sales Analysis** – Monthly trends, yearly performance, running totals, and month-over-month growth.
4. **Customer Analysis** – Customer spending, order frequency, and customer rankings.
5. **Order & Purchase Behaviour** – Order status distribution, purchase patterns, and order-value analysis.
6. **Advanced SQL Analysis** – Customer ranking, sales contribution, running totals, growth analysis, and customer segmentation.

## SQL Concepts Used

- SELECT, WHERE, ORDER BY
- INNER JOIN and LEFT JOIN
- GROUP BY and HAVING
- Aggregate functions
- Subqueries
- Common Table Expressions (CTEs)
- CASE WHEN
- Window functions
- RANK() and DENSE_RANK()
- LAG()
- Running totals
- Percentage calculations

## Key Business Insights

- Total non-cancelled order value: **₹5,83,600**
- Delivered orders: 16 (66.67%)
- Shipped orders: 5 (20.83%)
- Cancelled orders: 3 (12.50%)
- Laptop generated the highest product sales value at ₹2,20,000.
- Aditya Rao was the highest-value customer, with ₹91,600 in sales.
- Four customers were classified as High Value using project-defined spending thresholds.

## Data Validation

Performed checks for:

- Duplicate OrderIDs
- NULL values in important order columns
- Customer references in the Orders table
- Customer-, product-, and order-level sales reconciliation

## Project Structure

```text
Ecommerce-Sales-Analysis/
│
├── README.md
│
└── SQL-Scripts/
    ├── 00_Database_Setuo.sql
    ├── 01_Sales_Overview.sql
    ├── 02_Product_Category_Analysis.sql
    ├── 03_Monthly_Yearly_Sales_Analysis.sql
    ├── 04_Customer_Analysis.sql
    ├── 05_Order_Purchase_Behaviour.sql
    └── 06_Advanced_SQL_Analysis.sql
```

## Dataset

This project uses a synthetic e-commerce sales dataset created for SQL practice and business analysis. It does not contain real company or customer transaction data.
