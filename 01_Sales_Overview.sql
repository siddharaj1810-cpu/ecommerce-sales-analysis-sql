USE EcommerceSalesProject

-- How many orders are recorded in Orders table?
SELECT
	COUNT(*) AS TotalOrders
FROM Orders;

-- Find the number of orders for each status, such as Delivered, Shipped, and Cancelled.
SELECT
	Status,
	COUNT(*) NumberOfOrders
FROM Orders
GROUP BY Status
ORDER BY NumberOfOrders DESC;

-- Calculate the total value of all order items using quantity and unit price from OrderDetails.
SELECT
	SUM(Quantity * UnitPrice) AS GrossOrderValue
FROM OrderDetails;

-- Calculate the value of items belonging to orders whose status is not Cancelled.
SELECT
	SUM(od.Quantity * od.UnitPrice) NotCancelledOrderValue
FROM Orders o
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
WHERE NOT o.Status = 'Cancelled';

