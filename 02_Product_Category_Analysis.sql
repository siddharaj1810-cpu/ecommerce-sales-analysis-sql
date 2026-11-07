USE EcommerceSalesProject

-- Product-wise sales - Find each product's name and its total sales value.
SELECT 
	p.ProductID,
	p.ProductName,
	SUM(od.Quantity * od.UnitPrice) AS TotalSalesValue
FROM Products p 
INNER JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

-- Product ranking - Display products from highest sales value to lowest.
SELECT 
	p.ProductID,
	p.ProductName,
	SUM(od.Quantity * od.UnitPrice) AS TotalSalesValue
FROM Products p 
INNER JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSalesValue DESC;

-- Category performance - calculate the total sales value for each product category.
SELECT 
	p.Category,
	SUM(od.Quantity * od.UnitPrice) AS TotalSalesValue
FROM Products p 
INNER JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalSalesValue DESC;

-- Which product sells the highest number of units?
SELECT 
	p.ProductID,
	p.ProductName,
	SUM(od.Quantity) AS TotalQuantitySold
FROM Products p 
INNER JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantitySold DESC;