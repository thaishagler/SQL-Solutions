--------------------------
------Many to Many--------
--------------------------


--1. List products sold by order date.
SELECT
	p.productName,
	o.orderdate,
	FORMAT(o.orderDate, 'dddd') AS dia_semana
FROM
	Products p
JOIN OrderDetails od ON p.productCode = od.productCode
JOIN Orders o ON od.orderNumber = o.orderNumber
ORDER BY o.orderdate DESC

--2. List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
SELECT
	o.*
FROM
	Products p
JOIN OrderDetails od ON p.productCode = od.productCode
JOIN Orders o ON od.orderNumber = o.orderNumber
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY o.orderdate DESC;

--3. List the names of customers and their corresponding order number where a 
-- particular order from that customer has a value greater than $25,000?
SELECT 
	c.customerName,
	o.orderNumber,
	SUM(od.quantityOrdered * od.priceEach) AS [value greater than $25,000]
FROM
	Customers c
JOIN Orders o ON c.customerNumber = o.customerNumber
JOIN OrderDetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName, o.orderNumber
HAVING SUM(od.quantityOrdered * od.priceEach) > 25000
ORDER BY [value greater than $25,000] DESC

--4. Are there any products that appear on all orders?
SELECT
	p.*
FROM
	Products p
JOIN OrderDetails od ON p.productcode = od.productCode
WHERE EXISTS (
	SELECT * FROM OrderDetails);


-- 4. Are there any products that appear on all orders? --- REFORÇAR
SELECT od.productCode
FROM orderdetails od
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY od.productCode
HAVING COUNT(DISTINCT o.orderNumber) = (SELECT COUNT(DISTINCT orderNumber) FROM orders);

-- 5. List the names of products sold at less than 80% of the MSRP.
SELECT 
	p.productName,
	od.priceEach,
	p.MSRP,

FROM OrderDetails od
JOIN Products p ON od.productCode = p.productCode 
WHERE 
    od.priceEach < 0.8 * p.MSRP
ORDER BY od.priceEach DESC;

--6. Reports those products that have been sold with a markup of 100% or more 
-- (i.e.,  the priceEach is at least twice the buyPrice)

SELECT
	p.ProductName,
	od.priceEach,
	p.buyPrice,
	ROUND(((od.priceEach - p.buyPrice) / p.buyPrice) * 100, 2) AS markupPercent
FROM Products p
JOIN OrderDetails od ON p.productCode = od.productCode
WHERE od.priceEach >= 2 * p.buyPrice
ORDER BY markupPercent DESC

--7. List the products ordered on a Monday.
SELECT
	p.productName,
	o.orderDate,
    DATENAME(WEEKDAY, o.orderDate) AS weekdayName
FROM
	Products p
JOIN OrderDetails od ON p.productCode = od.productCode
JOIN Orders o ON od.orderNumber = o.orderNumber
WHERE DATENAME(WEEKDAY, o.orderDate) = 'Segunda-Feira'  -- 2 = Monday (depends on DATEFIRST setting)
ORDER BY o.orderDate DESC;

-- OU
SET DATEFIRST 1;  -- Segunda-feira como dia 1
SELECT
    p.productName,
    o.orderDate,
FROM
    Products p
JOIN OrderDetails od ON p.productCode = od.productCode
JOIN Orders o ON od.orderNumber = o.orderNumber
WHERE DATEPART(WEEKDAY, o.orderDate) = 1
ORDER BY o.orderDate DESC;

--8. What is the quantity on hand for products listed on 'On Hold' orders?
SELECT 
	SUM(od.quantityOrdered) AS [Quantity On Hold],
	p.productName
FROM Products p
JOIN OrderDetails od ON p.productCode = od.productCode
JOIN Orders o ON od.orderNumber = o.orderNumber
WHERE o.status = 'On Hold'
GROUP BY p.productName,	o.status