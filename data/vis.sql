USE AdventureWorks2025

-- SELECT * FROM Production.ProductCategory
-- SELECT * FROM Production.ProductSubcategory
-- SELECT * FROM Production.Product

-- Part One SQL ----------------------------------------------------

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
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY [Year], [MonthNr]

-- Part Four SQL ---------------------------------------------------- 

SELECT
    YEAR(OrderDate) AS [Year],
    SUM(TotalDue) AS TotalSales,
    COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY [Year]

-- Part Five SQL ---------------------------------------------------- 

SELECT TOP 10
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.Name, pc.Name
ORDER BY TotalSales DESC

-- Part Six SQL ---------------------------------------------------- 

SELECT
    st.Name AS Region,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(DISTINCT c.CustomerID) AS CustomerCount
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
GROUP BY st.Name
ORDER BY TotalSales DESC;

-- Part Seven SQL ---------------------------------------------------- 

SELECT
    st.Name AS Region,
    CASE
        WHEN s.BusinessEntityID IS NOT NULL THEN 'Store'
        ELSE 'Individual'
    END AS CustomerType,
    SUM(soh.TotalDue) / COUNT(soh.SalesOrderID) AS AvgOrderValue
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
LEFT JOIN Sales.Store AS s ON c.StoreID = s.BusinessEntityID
GROUP BY st.Name,
    CASE
        WHEN s.BusinessEntityID IS NOT NULL THEN 'Store'
        ELSE 'Individual'
    END;