/*Retrieving Customer Data
AdventureWorks Cycles is a company that sells directly to retailers, who then sell products to consumers. Each retailer that is an AdventureWorks customer has provided a named contact for all communication from AdventureWorks.
The sales manager at AdventureWorks has asked you to generate some reports containing details of the company's customers to support a direct sales campaign. Let's start with some basic exploration.

Familiarize yourself with the Customer table by writing a Transact-SQL query that retrieves all columns for all customers.

1.*/
-- select all columns
-- from the SalesLT.Customer table
SELECT *
FROM SalesLT.Customer;

--------------------------------------------------------------------------------------------------------------------------------

/*Create a table that lists all customer contact names. The table should include the Title, FirstName, MiddleName, LastName and Suffix of all customers.

2.*/
-- select the Title, FirstName, MiddleName, LastName and Suffix columns
-- from the Customer table
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

--------------------------------------------------------------------------------------------------------------------------------
/*
• Complete the query to list the following elements for all customers:
• The salesperson
• A column named CustomerName that displays how the customer contact should be greeted (e.g. "Mr Smith").
• The customer's phone number (Phone)
• Don't forget to space out the contents of your CustomerName column with + ' ' + and use the alias provided.

3.*/
-- finish the query
SELECT SalesPerson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

--------------------------------------------------------------------------------------------------------------------------------

/*As a reminder, if you want to build a string with an integer (e.g. id) you can use:
CAST(id AS VARCHAR)
Put it to the test; as you continue to work with the AdventureWorks customer data, you must create queries for reports that have been requested by the sales team.

Provide a list of all customer companies in the format <Customer ID>: <Company Name> (e.g. 78: Preferred Bikes). You'll need to use both CAST() and VARCHAR in your solution. Don't forget to use the alias provided.

4.*/
-- cast the CustomerID column to a VARCHAR and concatenate with the CompanyName column
SELECT CAST(CustomerID AS VARCHAR) + ': ' + CompanyName AS CustomerCompany
FROM SalesLT.Customer;

--------------------------------------------------------------------------------------------------------------------------------

/*The SalesLT.SalesOrderHeader table contains records of sales orders. You have been asked to retrieve data for a report that shows:
	• The sales order number and revision number in the format <Order Number> (<Revision>) (e.g. SO71774 (2)).
	• The order date converted to ANSI standard format yyyy.mm.dd (e.g. 2015.01.31).

Complete the query on the right to create the 2-column table that's specified above.

5.*/
-- finish the query
SELECT SalesOrderNumber + ' (' + STR(RevisionNumber, 1) + ')' AS OrderRevision,
	   CONVERT(NVARCHAR(30), OrderDate, 102) AS OrderDate
FROM SalesLT.SalesOrderHeader;

--------------------------------------------------------------------------------------------------------------------------------

/*In this exercise, you'll write a query that returns a list of customer names.
The list should consist of a single field in the format:
	• <first name> <last name> (e.g. Keith Harris) if the middle name is unknown,
	• <first name> <middle name> <last name> (e.g. Jane M. Gates) if a middle name is stored in the database.
Retrieve customer contact names including middle names when they're known.

6.*/
-- use ISNULL to check for middle names and concatenate with FirstName and LastName
SELECT FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName
AS CustomerName
FROM SalesLT.Customer;

--------------------------------------------------------------------------------------------------------------------------------

/*Customers may provide AdventureWorks with an email address, a phone number, or both. If an email address is available, then it should be used as the primary contact method; if not, then the phone number should be used.
Here, you will write a query that returns a list of customer IDs in one column, and a second column named PrimaryContact that contains the email address if known, and otherwise the phone number.
Note: In the sample data provided in AdventureWorksLT, there are no customer records without an email address. Therefore, to verify that your query works as expected, we have run the following UPDATE statement to remove some existing email addresses before you write your query. (Don't worry, you'll learn about UPDATE statements later in the course!)

UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;
Write a query that returns a list of customer IDs in one column, and a second column called PrimaryContact that contains the email address if known, and otherwise the phone number.

7.*/
-- select the CustomerID, and use COALESCE with EmailAddress and Phone columns
SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

--------------------------------------------------------------------------------------------------------------------------------

/*You have been asked to create a query that returns a list of sales order IDs and order dates with a column named ShippingStatus that contains the text "Shipped" for orders with a known ship date, and "Awaiting Shipment" for orders with no ship date.
Note: In the sample data provided in AdventureWorksLT, there are no SalesOrderHeader records without a ship date. Therefore, to verify that your query works as expected, we have run the following UPDATE statement to remove some existing ship dates before you write your query. (Again, don't worry, you'll learn about UPDATE statements later in the course!)

UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;
Write a query to list sales order IDs and order dates with a column named ShippingStatus that contains the text 'Shipped' for orders with a known ship date, and 'Awaiting Shipment' for orders with no ship date.

8.*/
SELECT SalesOrderID, OrderDate,
  CASE
    WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
    ELSE 'Shipped'
  END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;










