-- 1. Report the account representative for each customer.
SELECT 
	c.customerName,
	CONCAT(e.firstName, ' ', e.lastName) AS [Account Representative]
FROM Customers c
LEFT JOIN Employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.salesRepEmployeeNumber IS NOT NULL
ORDER BY [Account Representative] DESC;

-- 2. Report total payments for Atelier graphique.
SELECT 
	c.customerName,
	SUM(p.amount) AS [total payments]
FROM
	Customers c
JOIN
	Payments p ON c.customerNumber = p.customerNumber
WHERE c.CustomerName = 'Atelier graphique'
GROUP BY c.customerName;

-- 3. Report the total payments by date ==== SINGLE ENTITY
SELECT
	SUM(amount) AS [Total Payments],
	CAST(paymentDate AS DATE) AS DATE
FROM Payments
GROUP BY paymentDate
ORDER BY paymentDate ASC;

-- 4. Report the products that have not been sold.
SELECT  *
FROM Products p
WHERE NOT EXISTS 
(
	SELECT *
	FROM OrderDetails o
	WHERE p.productCode = o.productCode
);

--  5.  Customers who have never placed an order
SELECT * FROM Customers c
WHERE NOT EXISTS
(
	SELECT *
	FROM Orders o
	WHERE c.customerNumber = o.customerNumber
);

-- 6. Total of Customers who have never placed an order
SELECT 
	COUNT(*) AS [Total Customers who never orderded]
	FROM Customers c
WHERE NOT EXISTS (	
	SELECT *
	FROM Orders o
	WHERE c.customerNumber = o.customerNumber );

-- 7. List the amount paid by each customer
SELECT
	c.customerName,
	SUM(p.amount) AS [Total paid]
FROM Customers c
JOIN Payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
ORDER BY 2 DESC; -- número da coluna ou usar [Total paid]


-- 8. How many orders have been placed by Herkku Gifts?
SELECT
	c.customerName,
	COUNT(o.orderNumber) AS [Total orders]
FROM Customers c
JOIN Orders o ON c.customerNumber = o.customerNumber
WHERE c.customerName = 'Herkku Gifts'
GROUP BY c.customerName;

-- 9. Who are the employees in Boston?
SELECT
	CONCAT(e.firstName, ' ', e.lastName) AS Employees,
	o.city
FROM Employees e
JOIN Offices o ON e.officeCode = o.officeCode
WHERE o.city ='Boston';

-- 10. Report those payments greater than $100,000. 
--Sort the report so the customer who made the highest payment appears first.
SELECT
	c.customerName,
	SUM(p.amount) AS [Payments Greater then $100,000]
FROM Customers c
JOIN Payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
HAVING SUM(p.amount) > 100000
ORDER BY [Payments Greater then $100,000] DESC;

-- 11. List the value of 'On Hold' orders.
SELECT
	o.orderNumber,
	o.status,
	SUM(od.quantityOrdered * od.priceEach) AS [Total of On Hold]
FROM
	Orders o
JOIN OrderDetails od ON o.orderNumber = od.orderNumber
WHERE o.status = 'On Hold'
GROUP BY o.orderNumber,	o.status
ORDER BY [Total of On Hold] DESC;

--12. Report the number of orders 'On Hold' for each customer.
SELECT
	c.customerName,
	COUNT(o.status) AS [Total of Orders On Hold]
FROM Customers c
JOIN Orders o ON c.CustomerNumber = o.customerNumber
WHERE o.status = 'On Hold'
GROUP BY c.customerName
ORDER BY [Total of Orders On Hold] DESC;