/*AdventureWorks products each have a standard cost that indicates the cost of manufacturing the product, and a list price that indicates the recommended selling price for the product. This data is stored in the SalesLT.Product table.

Whenever a product is ordered, the actual unit price at which it was sold is also recorded in the SalesLT.SalesOrderDetail table.

Use subqueries to compare the cost and list prices for each product with the unit prices charged in each sale.

Retrieve the product ID, name, and list price for each product where the list price is higher than the average unit price for all products that have been sold.
*/

-- select the ProductID, Name, and ListPrice columns
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
-- filter based on ListPrice
WHERE ListPrice > 
-- get the average UnitPrice
(SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail)
ORDER BY ProductID;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*AdventureWorks is interested in finding out which products are being sold at a loss.

Retrieve the product ID, name, and list price for each product where the list price is 100 or more, and the product has been sold for (strictly) less than 100.

Remember, the ProductID in your subquery will be from the SalesLT.SalesOrderDetail table.
*/

SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductID IN
  -- select ProductID from the appropriate table
  (SELECT ProductID FROM SalesLT.SalesOrderDetail
   WHERE UnitPrice < 100)
AND ListPrice >= 100
ORDER BY ProductID;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*In order to get an idea of how many products are selling above or below list price, you want to gather some aggregate product data.

Retrieve the product ID, name, cost, and list price for each product along with the average unit price for which that product has been sold. Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT ProductID, Name, StandardCost, ListPrice,
-- get the average UnitPrice
(SELECT AVG(UnitPrice)
 -- from the appropriate table, aliased as SOD
 FROM SalesLT.SalesOrderDetail  AS SOD
 -- filter when the appropriate ProductIDs are equal
 WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
ORDER BY P.ProductID;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*AdventureWorks is interested in finding out which products are costing more than they're being sold for, on average.

Filter the query for the previous exercise to include only products where the cost is higher than the average selling price. Make sure to use the aliases provided, and default column names elsewhere.
*/

SELECT ProductID, Name, StandardCost, ListPrice,
(SELECT AVG(UnitPrice)
 FROM SalesLT.SalesOrderDetail AS SOD
 WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
-- filter based on StandardCost
WHERE StandardCost >
-- get the average UnitPrice
(SELECT AVG(UnitPrice)
 -- from the appropriate table aliased as SOD
 FROM SalesLT.SalesOrderDetail AS SOD
 -- filter when the appropriate ProductIDs are equal
 WHERE P.ProductID = SOD.ProductID)
ORDER BY P.ProductID;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The AdventureWorksLT database includes a table-valued user-defined function named dbo.ufnGetCustomerInformation. Use this function to retrieve details of customers based on customer ID values retrieved from tables in the database.

Retrieve the sales order ID, customer ID, first name, last name, and total due for all sales orders from the SalesLT.SalesOrderHeader table and the dbo.ufnGetCustomerInformation function. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select SalesOrderID, CustomerID, FirstName, LastName, TotalDue from the appropriate tables
SELECT SOH.SalesOrderID, SOH.CustomerID, CI.FirstName, CI.LastName, SOH.TotalDue
FROM SalesLT.SalesOrderHeader AS SOH
-- cross apply as per the instructions
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) AS CI
-- finish the clause
ORDER BY SOH.SalesOrderID;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*Use the table-valued user-defined function dbo.ufnGetCustomerInformation again to retrieve details of customers based on customer ID values retrieved from tables in the database.

Retrieve the customer ID, first name, last name, address line 1 and city for all customers from the SalesLT.Address and SalesLT.CustomerAddress tables, using the dbo.ufnGetCustomerInformation function. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select the CustomerID, FirstName, LastName, Addressline1, and City columns from the appropriate tables
SELECT CA.CustomerID, CI.FirstName, CI.LastName, A.Addressline1, A.City
FROM SalesLT.Address AS A
JOIN SalesLT.CustomerAddress AS CA
-- join based on AddressID
ON A.AddressID = CA.AddressID
-- cross apply as per instructions
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CustomerID) AS CI
ORDER BY CA.CustomerID;
