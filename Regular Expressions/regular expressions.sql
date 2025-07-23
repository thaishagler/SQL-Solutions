--------------------------
---Regular Expressions----
--------------------------

--1. Find products containing the name 'Ford'
SELECT * FROM Products
WHERE productName LIKE '%Ford%'

--2. List products ending in 'ship'.
SELECT * FROM Products
WHERE productName LIKE '%ship'

--3. Report the number of customers in Denmark, Norway, and Sweden.
SELECT 
	COUNT(DISTINCT customerNumber) AS [Total Customers],
	country
FROM Customers
WHERE country IN ('Denmark', 'Norway', 'Sweden')
GROUP BY country

--4. What are the products with a product code in the range S700_1000 to S700_1499?
SELECT * FROM Products
WHERE productCode BETWEEN 'S700_1000' AND 'S700_1499'
ORDER BY productCode ASC;

--5. Which customers have a digit in their name?
SELECT * FROM Customers
WHERE customerName LIKE '%[0-9]%';

--6. List the names of employees called Dianne or Diane.
SELECT * FROM Employees
WHERE LOWER(firstName) IN ('Dianne', 'Diane');

--7. List the products containing ship or boat in their product name.
SELECT * FROM Products
WHERE LOWER(productName) LIKE '%SHIP%' OR lOWER(productName) LIKE '%BOAT%';

--8. List the products with a product code beginning with S700.
SELECT * FROM Products
WHERE productCode LIKE 'S700%';

--9. List the names of employees called Larry or Barry.
SELECT * FROM Employees
WHERE firstName IN ('Larry', 'Barry');

--10. List the names of employees with non-alphabetic characters in their names.
SELECT * FROM Employees
WHERE PATINDEX('%[^A-Za-z ]%', firstName) > 0 
   OR PATINDEX('%[^A-Za-z ]%', lastName) > 0;

--11. List the vendors whose name ends in Diecast
SELECT * FROM Products
WHERE productVendor LIKE '%Diecast';