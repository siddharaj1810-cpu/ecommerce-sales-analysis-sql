USE EcommerceSalesProject;
GO

/* Customer Sales Ranking
Business question: Who are the highest-value customers based on their total sales?

Requirements:
1. Display CustomerID, CustomerName, and TotalSales.
2. Exclude cancelled orders.
3. Calculate each customer's total sales.
4. Rank customers by TotalSales in descending order.
5. Display the rank alongside each customer.
*/
WITH CTE_Customer_Sales AS (
	SELECT 
		c.CustomerID,
		c.CustomerName,
		SUM(od.Quantity * od.UnitPrice) TotalSales
	FROM Orders o
	INNER JOIN Customers c
	ON c.CustomerID = o.CustomerID
	INNER JOIN OrderDetails od
	ON od.OrderID = o.OrderID
	WHERE o.Status <> 'Cancelled'
	GROUP BY 
		c.CustomerID,
		c.CustomerName
)
SELECT 
	CustomerID,
	CustomerName,
	TotalSales,
	RANK() OVER (ORDER BY TotalSales DESC) CustomerRank
FROM CTE_Customer_Sales;

/* Product Sales Contribution %
Business question: What percentage of total sales does each product contribute?
Requirements:
1. Display ProductName.
2. Calculate TotalSales for each product.
3. Calculate each product's percentage contribution to total sales.
4. Exclude cancelled orders.
5. Sort by TotalSales descending.
*/
WITH CTE_Product_Sales AS(
	SELECT 
		p.ProductID,
		p.ProductName,
		SUM(od.Quantity * od.UnitPrice) ProductSales
	FROM OrderDetails od
	INNER JOIN Products p
	ON p.ProductID= od.ProductID
	INNER JOIN Orders o
	ON od.OrderID = o.OrderID
	WHERE o.Status <> 'Cancelled'
	GROUP BY 
		p.ProductID,
		p.ProductName
)
SELECT 
	ProductID,
	ProductName,
	ProductSales,
	ROUND((CAST(ProductSales AS float) / SUM(Productsales) OVER () * 100),2) PercentageContribution
FROM CTE_Product_Sales
ORDER BY ProductSales DESC;

/* Monthly Running Total Sales
Business question: How do sales accumulate over time, month by month?
Requirements:
1. Display Year and Month.
2. Calculate MonthlySales.
3. Calculate cumulative sales using a running total.
4. Exclude cancelled orders.
5. Sort chronologically by year and month.
*/
WITH CTE_Month_sales AS (
	SELECT 
		YEAR(o.OrderDate) Year,
		MONTH(o.OrderDate) Month,
		SUM(od.Quantity * od.UnitPrice) MonthlySales 
	FROM Orders o
	INNER JOIN OrderDetails od
	ON o.OrderID = od.OrderID
	WHERE o.Status <> 'Cancelled'
	GROUP BY 
		YEAR(o.OrderDate),
		MONTH(o.OrderDate)
)
SELECT
	Year,
	Month,
	MonthlySales,
	SUM(MonthlySales) OVER (ORDER BY Year,Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) RunningTotal
FROM CTE_Month_sales;

/* Month-over-Month Sales Growth
Business question: Are sales increasing or decreasing compared with the previous month?

Requirements:
1. Calculate monthly sales, excluding cancelled orders.
2. Display Year, Month, and MonthlySales.
3. Retrieve the previous month's sales.
4. Calculate the difference between current and previous month.
5. Calculate percentage growth or decline.
6. Sort chronologically.
*/
WITH CTE_Month_Sales AS (
    SELECT 
        YEAR(o.OrderDate) AS Year,
        MONTH(o.OrderDate) AS Month,
        SUM(od.Quantity * od.UnitPrice) AS MonthlySales
    FROM Orders o
    INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
    WHERE o.Status <> 'Cancelled'
    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
),
CTE_Previous_Month AS (
    SELECT
        Year,
        Month,
        MonthlySales,
        LAG(MonthlySales) OVER (
            ORDER BY [Year], [Month]
        ) AS PreviousMonthSales
    FROM CTE_Month_Sales
)
SELECT
    Year,
    Month,
    MonthlySales,
    PreviousMonthSales,
    MonthlySales - PreviousMonthSales AS SalesDifference,
    ROUND(
        CAST(MonthlySales - PreviousMonthSales AS FLOAT)
        / NULLIF(PreviousMonthSales, 0) * 100,
        2
    ) AS GrowthPercentage
FROM CTE_Previous_Month
ORDER BY 
	Year,
	Month;

/* Customer Segmentation
Business question: Which customers contribute the most to the business, based on their total spending?
Requirements
1. Calculate total sales for each customer.
2. Exclude cancelled orders.
3. Categorize customers into three segments using CASE WHEN:
   - High Value
   - Medium Value
   - Low Value
4. Display:
   - CustomerID
   - CustomerName
   - TotalSales
   - CustomerSegment
*/
WITH CTE_TotalSales AS (
	SELECT 
		c.CustomerID,
		c.CustomerName,
		SUM(od.Quantity * od.UnitPrice) TotalSales 
	FROM Customers c
	INNER JOIN Orders o
		ON c.CustomerID = o.CustomerID
	INNER JOIN OrderDetails od
		ON od.OrderID = o.OrderID
	WHERE o.Status <> 'Cancelled'
	GROUP BY 
		c.CustomerID,
		c.CustomerName
)
SELECT
	CustomerID,
	CustomerName,
	TotalSales,
	CASE 
		WHEN TotalSales > 80000 THEN 'High Value'
		WHEN TotalSales > 40000 THEN 'Medium Value'
		ELSE 'Low Value'
	END CustomerSegment
FROM CTE_TotalSales
ORDER BY TotalSales DESC;