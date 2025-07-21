--------------------------
------Single entity-------
--------------------------

--Prepare a list of offices sorted by country, state, city.

SELECT * FROM Offices
ORDER BY country, state, City;

--How many employees are there in the company?
SELECT COUNT(*) As Total_Employees
FROM Employees;

-- What is the total of payments received?
SELECT SUM(Amount) as Total_Payments
FROM Payments;

-- List the product lines that contain 'Cars'.
SELECT * FROM ProductLines
WHERE productLine LIKE '%Cars%';

-- Report total payments for October 28, 2004.
SELECT SUM(amount) AS [Total Amount for 28th oct 2004]
FROM Payments
WHERE CAST(PaymentDate as DATE) = '2004-10-28';

-- Report those payments greater than $100,000.
-- obs em SQL (seguindo padrão americano), o ponto é usado para decimais.
SELECT * FROM Payments
WHERE Amount > 100000
ORDER BY Amount Desc;

--List the products in each product line.
SELECT ProductName, productLine FROM Products
ORDER BY productLine ASC;

--How many products in each product line?
SELECT 
	COUNT(DISTINCT productName) AS [Total Product Amount],
	productLine
FROM
	Products
GROUP BY productLine
ORDER BY [Total Product Amount] DESC;

--What is the minimum payment received?
SELECT * 
FROM Payments
WHERE amount = (
	SELECT 
		MIN(amount) 
	FROM Payments);

--List all payments greater than twice the average payment.
SELECT *
FROM Payments
WHERE amount > (
	SELECT (AVG(amount))*2
	FROM Payments);

-- OU MOSTRANDO MAIS DADOS

SELECT *, 
       (SELECT AVG(amount) * 2 FROM Payments) AS Threshold,
	   (SELECT AVG(amount) FROM Payments) as Media
FROM Payments
WHERE amount > (
	SELECT AVG(amount) * 2
	FROM Payments
);

-- MAIS OTIMIZADO
WITH Stats AS (
    SELECT 
        AVG(amount) AS Media, 
        AVG(amount) * 2 AS Threshold
    FROM Payments
)
SELECT 
    p.*, 
    s.Threshold, 
    s.Media
FROM Payments p
CROSS JOIN Stats s
WHERE p.amount > s.Threshold;

--What is the average percentage markup of the MSRP on buyPrice?
SELECT 
productName,
AVG(((MSRP - buyPrice) / MSRP)*100) AS Average_Markup_Percentage
FROM Products
GROUP BY productName;

--How many distinct products does ClassicModels sell?
SELECT COUNT(DISTINCT(productCode)) AS Amount_Distinct_products 
FROM Products;

--Report the name and city of customers who don't have sales representatives?
SELECT 
	customerName, 
	city 
FROM Customers
WHERE salesRepEmployeeNumber IS NULL

--What are the names of executives with VP or Manager in their title? 
--Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.

SELECT 
    CONCAT(firstName, ' ', lastName) AS [Employees VP and Manager]
FROM Employees
WHERE jobTitle LIKE '%VP%' 
   OR jobTitle LIKE '%Manager%';

--Which orders have a value greater than $5,000?
SELECT 
	orderNumber,
	SUM(priceEach * quantityOrdered) AS Total_Order
FROM OrderDetails
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 5000 
ORDER BY orderNumber DESC