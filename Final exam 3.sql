/*Use a subquery to get the product name and unit price of products from the Products table which have a unit price greater than the average unit price from the Order Details table.*/

SELECT ProductName, UnitPrice 
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM [Order Details]);

-----------------------------------------------------------------------------------------------------------------------------------

/*Select from the Employees and Orders tables. Use a subquery to get the first name and employee ID for employees who were associated with orders which shipped from the USA.*/

SELECT FirstName, EmployeeID
FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM Orders WHERE ShipCountry = 'USA');

-----------------------------------------------------------------------------------------------------------------------------------

/*Create a new temporary table called ProductNames which has one field called ProductName (a VARCHAR of max length 40). Insert into this table the names of every product from the Products table. Select all columns from the ProductNames table you created. */

CREATE TABLE #ProductNames
(ProductName VARCHAR(40));

INSERT INTO #ProductNames
SELECT ProductName FROM Products;

SELECT * FROM #ProductNames;
