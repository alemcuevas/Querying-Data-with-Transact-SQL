/*Get the order ID and unit price for each order by joining the Orders table and the Order Details table.

Note that you need to use [Order Details] since the table name contains whitespace.*/

SELECT o.OrderID, od.UnitPrice
FROM dbo.Orders AS o
JOIN dbo.[Order Details] AS od
ON o.OrderID = od.OrderID;

----------------------------------------------------------------------------------------------------------------------------------

/*Get the order ID and first name of the associated employee by joining the Orders and Employees tables.*/

SELECT o.OrderID, e.FirstName
FROM dbo.Orders AS o
JOIN dbo.Employees AS e
ON o.EmployeeID = e.EmployeeID;

----------------------------------------------------------------------------------------------------------------------------------

/*Get the employee ID and related territory description for each territory an employee is in, by joining the Employees, EmployeeTerritories and Territories tables.*/

SELECT e.EmployeeID, t.TerritoryDescription
FROM dbo.Employees AS e
JOIN dbo.EmployeeTerritories AS et
ON e.EmployeeID = et.EmployeeID
JOIN dbo.Territories AS t
ON t.TerritoryID = et.TerritoryID
ORDER BY e.EmployeeID, t.TerritoryDescription;

----------------------------------------------------------------------------------------------------------------------------------

/*Select all the different countries from the Customers table and the Suppliers table using UNION.*/

SELECT Country
FROM dbo.Suppliers
UNION
SELECT Country
FROM dbo.Customers
ORDER BY Country;

----------------------------------------------------------------------------------------------------------------------------------

/*Select all the countries, including duplicates, from the Customers table and the Suppliers table using UNION ALL.*/

SELECT Country
FROM dbo.Suppliers
UNION ALL
Select Country
FROM dbo.Customers
Order by Country;

----------------------------------------------------------------------------------------------------------------------------------

/*Using the Products table, get the unit price of each product, rounded to the nearest dollar.*/

SELECT ROUND(UnitPrice, 0)
FROM dbo.Products;

----------------------------------------------------------------------------------------------------------------------------------

/*Using the Products table, get the total number of units in stock across all products.*/

SELECT SUM(UnitsInStock)
FROM dbo.Products;

----------------------------------------------------------------------------------------------------------------------------------

/*Using the Orders table, get the order ID and year of the order by using YEAR(). Alias the year as OrderYear.*/

SELECT OrderID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders;

----------------------------------------------------------------------------------------------------------------------------------

/*Using the Orders table, get the order ID and month of the order by using DATENAME(). Alias the month as OrderMonth.*/

SELECT OrderID, DATENAME(month, OrderDate) AS OrderMonth 
FROM dbo.Orders;

----------------------------------------------------------------------------------------------------------------------------------

/*Use LEFT() to get the first two letters of each region description from the Region table.*/

SELECT LEFT(RegionDescription, 2) AS RD 
FROM dbo.Region;

----------------------------------------------------------------------------------------------------------------------------------

/*Using the Suppliers table, select the city and postal code for each supplier, using WHERE and ISNUMERIC() to select only those postal codes which have no letters in them.*/

SELECT City, PostalCode FROM dbo.Suppliers
WHERE ISNUMERIC(PostalCode) = 1

----------------------------------------------------------------------------------------------------------------------------------

/*Use LEFT() and UPPER() to get the first letter (capitalized) of each region description from the Region table.*/

SELECT UPPER(LEFT(RegionDescription, 1)) AS RD
FROM dbo.Region;
