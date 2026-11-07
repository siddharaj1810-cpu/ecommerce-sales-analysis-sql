USE EcommerceSalesProject

-- Monthly sales analysis - Calculate the total sales value for each month.
SELECT 
	YEAR(o.OrderDate) Year,
	MONTH(o.OrderDate) Month,
	SUM(od.Quantity * od.UnitPrice) TotalSales
FROM Orders o 
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY MONTH(o.OrderDate),YEAR(o.OrderDate)
ORDER BY YEAR(o.OrderDate),MONTH(o.OrderDate);

-- Highest-performing month - Which month and year generated the highest sales?
SELECT TOP 1
	YEAR(o.OrderDate) Year,
	MONTH(o.OrderDate) Month,
	SUM(od.Quantity * od.UnitPrice) TotalSales
FROM Orders o 
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY MONTH(o.OrderDate),YEAR(o.OrderDate)
ORDER BY TotalSales DESC;

-- Yearly sales analysis - How much sales value did the business generate in each year?

SELECT
	YEAR(o.OrderDate) Years,
	SUM(od.Quantity * od.UnitPrice) TotalSales
FROM Orders o
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY YEAR(o.OrderDate)
ORDER BY TotalSales DESC;

-- Best-performing year - Which year generated the highest sales?
SELECT TOP 1
	YEAR(o.OrderDate) Years,
	SUM(od.Quantity * od.UnitPrice) TotalSales
FROM Orders o
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY YEAR(o.OrderDate)
ORDER BY TotalSales DESC;