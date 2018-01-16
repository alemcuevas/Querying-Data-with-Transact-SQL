/*Your reports are returning the correct records, but you would like to modify how these records are displayed.

Write a query to return the product ID of each product, together with the product name formatted as upper case and a column named ApproxWeight with the weight of each product rounded to the nearest whole unit. 
Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select ProductID and use the appropriate functions with the appropriate columns
SELECT ProductID, UPPER(NAME) AS ProductName, ROUND(WEIGHT, 0) AS ApproxWeight
FROM SalesLT.Product;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*It would be useful to know when AdventureWorks started selling each product.

Extend your query to include columns named SellStartYear and SellStartMonth containing the year and month in which AdventureWorks started selling each product. The month should be displayed as the month name (e.g. 'January'). 
Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight,
       -- get the year of the SellStartDate
       YEAR(SellStartDate) as SellStartYear,
       -- get the month datepart of the SellStartDate
       DATENAME(m, SellStartDate) as SellStartMonth
FROM SalesLT.Product;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*It would also be useful to know the type of each product.

Extend your query to include a column named ProductType that contains the leftmost two characters from the product number. Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) as SellStartYear,
       DATENAME(m, SellStartDate) as SellStartMonth,
       -- use the appropriate function to extract substring from ProductNumber
       LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*Categorical data can be less useful in certain cases. Here, you only want to look at numeric product size data.

Extend your query to filter the product returned so that only products with a numeric size are included. Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, 0) AS ApproxWeight,
       YEAR(SellStartDate) as SellStartYear,
       DATENAME(m, SellStartDate) as SellStartMonth,
       LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
-- filter for numeric product size data
WHERE ISNUMERIC(Size) = 1;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The sales manager would like a list of customers ranked by sales.

Write a query that returns a list of company names with a ranking of their place in a list of highest TotalDue values from the SalesOrderHeader table. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select CompanyName and TotalDue columns
SELECT CompanyName, TotalDue AS Revenue,
       -- get ranking and order by appropriate column
       RANK() OVER (ORDER BY TotalDue DESC) AS RankByRevenue
FROM SalesLT.SalesOrderHeader AS SOH
-- use appropriate join on appropriate table
JOIN SalesLT.Customer AS C
ON SOH.CustomerID = C.CustomerID;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The product manager would like aggregated information about product sales.

Write a query to retrieve a list of the product names and the total revenue calculated as the sum of the LineTotal from the SalesLT.SalesOrderDetail table, with the results sorted in descending order of total revenue. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select the Name column and use the appropriate function with the appropriate column
SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
-- use the appropriate join
JOIN SalesLT.Product AS P
-- join based on ProductID
ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The product manager would like aggregated information about product sales.

Modify the previous query to include sales totals for products that have a list price of more than 1000. Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
-- filter as per the instructions
WHERE ListPrice > 1000
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The product manager would like aggregated information about the products which grossed a very large amount.

Modify the previous query to only include products with total sales greater than 20000. Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
-- add having clause as per instructions
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC;
