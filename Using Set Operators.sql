/*Customers can have two kinds of address: a main office address and a shipping address. The accounts department wants to ensure that the main office address is always used for billing, and have asked you to write a query that clearly identifies the different types of address for each customer.

Write a query that retrieves the company name, first line of the street address, city, and a column named AddressType with the value 'Billing' for customers where the address type in the SalesLT.CustomerAddress table is 'Main Office'. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select the CompanyName, AddressLine1 columns
-- alias as per the instructions
SELECT CompanyName, AddressLine1, City, 'Billing' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
-- join based on CustomerID
ON c.CustomerID = ca.CustomerID
-- join another table
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
-- filter for where the correct AddressType
WHERE AddressType = 'Main Office';

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The ideal solution to the previous exercise has been included in the sample code on the right. Can you adapt it slightly to generate a very similar result?

Adapt the query to retrieve the company name, first line of the street address, city, and a column named AddressType with the value 'Shipping' for customers where the address type in the SalesLT.CustomerAddress table is 'Shipping'. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- edit this
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
-- edit this
WHERE ca.AddressType = 'Shipping';

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*The code on the right contains the two queries from the previous exercises.

Use UNION ALL to combine the results returned by the two queries to create a list of all customer addresses that is sorted by company name and then address type.
*/

SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
-- edit this as per the instructions
UNION ALL
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName, AddressType;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*You have created a master list of all customer addresses, but now you have been asked to create filtered lists that show which customers have only a main office address, and which customers have both a main office and a shipping address.

Write a query that returns the company name of each company that appears in a table of customers with a 'Main Office' address, but not in a table of customers with a 'Shipping' address.
*/

SELECT c.CompanyName
FROM SalesLT.Customer AS c
-- join the CustomerAddress table
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
EXCEPT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
-- use the appropriate join to join the CustomerAddress table
JOIN SalesLT.CustomerAddress AS ca
-- join based on CustomerID
ON c.CustomerID = ca.CustomerID
-- use the appropriate join to join the Address table
JOIN SalesLT.Address AS a
ON ca.AddressID = a.AddressID
-- filter for the appropriate AddressType
WHERE AddressType = 'Shipping'
ORDER BY c.CompanyName;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*This exercise builds upon your work in the previous exercise.

Write a query that returns the company name of each company that appears in a table of customers with a 'Main Office' address, and also in a table of customers with a 'Shipping' address. Make sure to use the aliases provided, and default column names elsewhere.
*/

-- select the CompanyName column
SELECT c.CompanyName
-- from the appropriate table
FROM SalesLT.Customer AS c
-- use the appropriate join with the appropriate table
JOIN SalesLT.CustomerAddress AS ca
-- join based on CustomerID
ON c.CustomerID = ca.CustomerID
-- use the appropriate join with the appropriate table
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
-- filter based on AddressType
WHERE ca.AddressType = 'Main Office'
INTERSECT
-- select the CompanyName column
SELECT c.CompanyName
FROM SalesLT.Customer AS c
-- use the appropriate join with the appropriate table
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
-- join based on AddressID
ON ca.AddressID = a.AddressID
-- filter based on AddressType
WHERE ca.AddressType = 'Shipping'
ORDER BY c.CompanyName;

