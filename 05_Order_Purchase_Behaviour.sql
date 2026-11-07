USE EcommerceSalesProject;
GO

/* Order status distribution 
- Count the number of orders for each status.
- Display Status and TotalOrders.
- Calculate the percentage of total orders for each status.
- Sort by TotalOrders, highest first. */
WITH CTE_TotalOrders AS
(
	SELECT 
		Status,
		COUNT (*) StatusOrders
	FROM Orders
	GROUP BY Status
)
SELECT 
	Status,
	StatusOrders,
	ROUND(StatusOrders / CAST (SUM(StatusOrders) OVER() AS FLOAT) * 100,2) Percentage
FROM CTE_TotalOrders
ORDER BY StatusOrders DESC;

/* Average products per order
Business question: On average, how many product units are purchased in each non-cancelled order?
Requirements:
1. Exclude cancelled orders.
2. Calculate the total quantity for each individual order.
3. Calculate the average of those order quantities.
4. Return the average quantity per order.
*/
SELECT 
	od.OrderID,
	SUM(od.Quantity) OrderQuantity,
	AVG (SUM(od.Quantity)) OVER() AvgOrderQuantity
FROM OrderDetails od
INNER JOIN Orders o
ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY od.OrderID;

/*Highest-value individual orders
Business question: Which five individual orders generated the highest sales value?
Requirements:
1. Display OrderID, CustomerName, OrderDate, and OrderValue.
2. Exclude cancelled orders.
3. Calculate the total value of each order.
4. Return only the top five orders.
5. Sort from highest to lowest order value.
*/
SELECT TOP 5
	o.OrderID,
	c.CustomerName,
	o.OrderDate,
	SUM(od.Quantity * od.UnitPrice) OrderValue
FROM Orders o
INNER JOIN Customers c
ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY 	
	o.OrderID,
	c.CustomerName,
	o.OrderDate
ORDER BY SUM(od.Quantity * od.UnitPrice) DESC;

/*First and Most Recent Order per Customer.
Business question
The business manager wants to know when each customer made their first purchase and when they made their most recent purchase.
Requirements
1. Display CustomerID and CustomerName.
2. Find the first order date using MIN().
3. Find the latest order date using MAX().
4. Exclude cancelled orders.
5. Include only customers who have at least one non-cancelled order.
*/
SELECT 
	c.CustomerID,
	c.CustomerName,
	MIN(o.OrderDate) FirstOrder,
	MAX(o.OrderDate) LastOrder
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.Status <> 'Cancelled'
GROUP BY 
	c.CustomerID,
	c.CustomerName;

/*Repeat customers
Business question: Which customers have purchased more than once?
Requirements:
1. Display CustomerID, CustomerName and TotalOrders.
2. Exclude cancelled orders.
3. Count each order only once.
4. Include customers with more than one non-cancelled order.
5. Sort by TotalOrders in descending order.
*/
SELECT 
	c.CustomerID,
	c.CustomerName,
	COUNT(o.OrderID) TotalOrders
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.Status <> 'Cancelled'
GROUP BY 
	c.CustomerID,
	c.CustomerName
HAVING COUNT(o.OrderID) > 1
ORDER BY TotalOrders DESC;