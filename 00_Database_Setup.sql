
-- PROJECT: E-commerce Sales Analysis

IF DB_ID('EcommerceSalesProject') IS NULL
    CREATE DATABASE EcommerceSalesProject;
GO

USE EcommerceSalesProject;
GO

-- 1. Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    SignupDate DATE
);

-- 2. Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);

-- 3. Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE,
    Status VARCHAR(30),
    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- 4. Order details
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

-- Insert customers
INSERT INTO Customers VALUES
(1, 'Aarav Sharma', 'Mumbai', '2025-01-10'),
(2, 'Rohan Patel', 'Pune', '2025-02-15'),
(3, 'Arjun Mehta', 'Mumbai', '2025-03-20'),
(4, 'Vikram Singh', 'Delhi', '2025-04-05'),
(5, 'Rahul Verma', 'Pune', '2025-05-12'),
(6, 'Karan Shah', 'Bengaluru', '2025-06-18'),
(7, 'Aditya Rao', 'Mumbai', '2025-07-22'),
(8, 'Kabir Joshi', 'Delhi', '2025-08-11'),
(9, 'Dev Malhotra', 'Bengaluru', '2025-09-03'),
(10, 'Ishaan Gupta', 'Pune', '2025-10-19');

-- Insert products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Smartphone', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Office Chair', 'Furniture', 8000),
(106, 'Desk', 'Furniture', 12000),
(107, 'Monitor', 'Electronics', 15000),
(108, 'Mouse', 'Accessories', 800);

-- Insert orders
INSERT INTO Orders VALUES
(1001, 1, '2025-01-15', 'Delivered'),
(1002, 2, '2025-01-20', 'Delivered'),
(1003, 3, '2025-02-05', 'Shipped'),
(1004, 1, '2025-02-18', 'Delivered'),
(1005, 4, '2025-03-10', 'Cancelled'),
(1006, 5, '2025-03-22', 'Delivered'),
(1007, 6, '2025-04-02', 'Delivered'),
(1008, 7, '2025-04-17', 'Shipped'),
(1009, 8, '2025-05-06', 'Delivered'),
(1010, 9, '2025-05-21', 'Cancelled'),
(1011, 10, '2025-06-12', 'Delivered'),
(1012, 2, '2025-06-25', 'Delivered'),
(1013, 3, '2025-07-08', 'Shipped'),
(1014, 4, '2025-07-19', 'Delivered'),
(1015, 5, '2025-08-03', 'Delivered'),
(1016, 6, '2025-08-28', 'Cancelled'),
(1017, 7, '2025-09-14', 'Delivered'),
(1018, 8, '2025-10-09', 'Delivered'),
(1019, 9, '2025-11-16', 'Shipped'),
(1020, 10, '2025-12-05', 'Delivered'),
(1021, 1, '2026-01-12', 'Delivered'),
(1022, 3, '2026-02-14', 'Delivered'),
(1023, 5, '2026-03-11', 'Shipped'),
(1024, 7, '2026-04-19', 'Delivered');

-- Insert order details
INSERT INTO OrderDetails VALUES
(1,1001,101,1,55000),
(2,1001,103,2,2000),
(3,1002,102,1,25000),
(4,1002,108,2,800),
(5,1003,107,1,15000),
(6,1003,104,2,1500),
(7,1004,103,3,2000),
(8,1004,108,1,800),
(9,1005,101,1,55000),
(10,1006,105,2,8000),
(11,1006,104,1,1500),
(12,1007,106,1,12000),
(13,1007,108,3,800),
(14,1008,102,2,25000),
(15,1009,107,2,15000),
(16,1009,103,1,2000),
(17,1010,106,1,12000),
(18,1011,101,1,55000),
(19,1011,104,2,1500),
(20,1012,102,1,25000),
(21,1013,105,1,8000),
(22,1013,108,2,800),
(23,1014,106,2,12000),
(24,1015,103,4,2000),
(25,1015,104,2,1500),
(26,1016,102,1,25000),
(27,1017,107,1,15000),
(28,1017,108,2,800),
(29,1018,101,1,55000),
(30,1018,103,2,2000),
(31,1019,102,1,25000),
(32,1020,105,2,8000),
(33,1020,104,1,1500),
(34,1021,107,1,15000),
(35,1021,108,2,800),
(36,1022,101,1,55000),
(37,1022,103,1,2000),
(38,1023,106,1,12000),
(39,1023,104,2,1500),
(40,1024,102,1,25000);
GO
