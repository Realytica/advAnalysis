USE AdventureWorks2025

-- Part One SQL ----------------------------------------------------
-- SELECT * FROM Production.ProductCategory
-- SELECT * FROM Production.ProductSubcategory
-- SELECT * FROM Production.Product


SELECT
    pc.Name AS CategoryName,
    COUNT(DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID  = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY ProductCount DESC

-- Part Two SQL ---------------------------------------------------- 

SELECT
    pc.Name AS Category,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON p.ProductID = sod.ProductID
JOIN Production.ProductSubcategory psc ON psc.ProductSubcategoryID = p.ProductSubcategoryID
JOIN Production.ProductCategory pc ON pc.ProductCategoryID = psc.ProductCategoryID
GROUP BY pc.Name
ORDER BY TotalSales DESC

-- Part Three SQL ---------------------------------------------------- 

SELECT
    YEAR(OrderDate) AS [Year],
    MONTH(OrderDate) AS [MonthNr],
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY
    YEAR(OrderDate), MONTH(OrderDate)
ORDER BY
    [Year], [MonthNr]

-- Part Four SQL ---------------------------------------------------- 

SELECT
    YEAR(OrderDate) AS [Year],
    SUM(TotalDue) AS TotalSales,
    COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY [Year]

-- Part Five SQL ---------------------------------------------------- 

-- Part Six SQL ---------------------------------------------------- 

-- Part Seven SQL ---------------------------------------------------- 