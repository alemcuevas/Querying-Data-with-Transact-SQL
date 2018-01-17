/*Use CHOOSE() and MONTH() to get the season in which each order was shipped from the Orders table. You should select the order ID, shipped date, and then the season aliased as ShippedSeason. You can copy and paste the below into your query.*/

SELECT OrderID, ShippedDate, CHOOSE(MONTH(ShippedDate),'Winter', 'Winter', 'Spring', 'Spring', 'Spring', 'Summer', 'Summer', 'Summer', 'Autumn', 'Autumn', 'Autumn', 'Winter') AS ShippedSeason
FROM Orders
WHERE ShippedDate IS NOT NULL;

----------------------------------------------------------------------------------------------------------------------------------

/*Using the Suppliers table, select the company name and use a simple IIF expression to display 'outdated' if a company has a fax number, or 'modern' if it doesn't. Alias the result of the IIF expression to Status.*/

SELECT CompanyName,
    CASE
       WHEN Fax IS NULL THEN 'modern'
     ELSE 'outdated'
   END AS Status
FROM Suppliers;

----------------------------------------------------------------------------------------------------------------------------------

/*Insert into the Region table the region ID 5 and the description 'Space'.

Then, in a second query, select the newly inserted data from the table using a WHERE clause.*/

INSERT INTO Region 
VALUES (5, 'Space');

SELECT * FROM Region 
WHERE RegionID = 5;

----------------------------------------------------------------------------------------------------------------------------------

/*Update the region descriptions in the Region table to be all uppercase, using SET and UPPER().

Next, select all data from the table to view your updates.*/

UPDATE Region
SET RegionDescription = UPPER(RegionDescription);

SELECT * FROM Region;
