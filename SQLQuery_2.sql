SELECT TOP 4 WITH TIES 
    p.SalesPersonID, 
    p.Bonus 
FROM Sales.SalesPerson p
ORDER BY Bonus DESC
---------------------
SELECT TOP 4
    p.SalesPersonID, 
    p.Bonus 
FROM Sales.SalesPerson p
ORDER BY Bonus DESC
--------------------
SELECT TOP 4 WITH TIES 
    p.SalesPersonID, 
    p.Bonus 
FROM Sales.SalesPerson p
ORDER BY Bonus DESC
--------------------
SELECT COUNT(1) 
FROM HumanResources.Employee
--------------------
SELECT COUNT(ManagerID) 
FROM HumanResources.Employee
--------------------
SELECT 
    ProductID, 
    Count(OrderQty) as 'Count' 
FROM 
    Sales.SalesOrderDetail ProductID 
GROUP BY ProductID
--------------------
SELECT 
    ProductID,
    Count(OrderQty) as Qty
FROM Sales.SalesOrderDetail ProductID 
GROUP BY ProductID 
ORDER BY Qty DESC
--------------------
SELECT 
    ProductID, 
    Count(OrderQty) as Qty
FROM Sales.SalesOrderDetail ProductID 	
GROUP BY ProductID 
HAVING Count(OrderQty) > 2000
ORDER BY Qty DESC
--------------------
SELECT 
    ProductID, 
    SpecialOfferID, 
    AVG(UnitPrice), 
    SUM(LineTotal) 
FROM Sales.SalesOrderDetail	
GROUP BY ProductID, SpecialOfferID
--------------------
SELECT 
    ProductID, 
    SpecialOfferID, 
    AVG(UnitPrice) as AveregePrice, 
    SUM(LineTotal) as Summary 
FROM Sales.SalesOrderDetail
GROUP BY ProductID, SpecialOfferID
ORDER BY ProductID
--------------------
SELECT 
    SalesQuota, 
    SUM(SalesYTD) as TotalSalesYTD 
FROM Sales.SalesPerson
GROUP BY SalesQuota
--------------------
SELECT 
    SalesQuota, 
    SUM(SalesYTD) 'TotalSalesYTD', 
    GROUPING(SalesQuota) AS 'Grouping'  
FROM Sales.SalesPerson  
GROUP BY SalesQuota WITH ROLLUP
--------------------
SELECT 
    ProductID, 
    SUM(LineTotal) AS 'SUM'
FROM Sales.SalesOrderDetail
WHERE UnitPrice < 5
GROUP BY ProductID
ORDER BY ProductID
--------------------
SELECT 
    ProductID, 
    SUM(LineTotal) AS 'SUM'
FROM Sales.SalesOrderDetail
WHERE UnitPrice < $5.00
GROUP BY CUBE (ProductID, OrderQty)
ORDER BY ProductID DESC