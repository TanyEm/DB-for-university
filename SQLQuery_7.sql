USE AdventureWorks
GO
CREATE VIEW HumanResources.vEmployeeDetails WITH SCHEMABINDING
 AS SELECT
e.[EmployeeID]
,c.[Title]
,c.[FirstName]
,c.[MiddleName]
,c.[LastName]
,c.[Suffix]
,e.[Title] AS [JobTitle]
,c.[Phone]
,c.[EmailAddress]
,c.[EmailPromotion]
,a.[AddressLine1] 
,a.[AddressLine2]
,a.[City]
,sp.[Name] AS [StateProvinceName]
,a.[PostalCode]
,cr.[Name] AS [CountryRegionName]
,c.[AdditionalContactInfo]
FROM [HumanResources].[Employee] e
INNER JOIN [Person].[Contact] c
ON c.[ContactID] = e.[ContactID]
INNER JOIN [HumanResources].[EmployeeAddress] ea
ON e.[EmployeeID] = ea.[EmployeeID]
INNER JOIN [Person].[Address] a
ON ea.[AddressID] = a.[AddressID]
INNER JOIN [Person].[StateProvince] sp
ON sp.[StateProvinceID] = a.[StateProvinceID]
INNER JOIN [Person].[CountryRegion] cr
ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
-------------------------------------------------
SELECT TOP (1000) [EmployeeID]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[JobTitle]
      ,[Phone]
      ,[EmailAddress]
      ,[EmailPromotion]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvinceName]
      ,[PostalCode]
      ,[CountryRegionName]
      ,[AdditionalContactInfo]
  FROM [AdventureWorks].[HumanResources].[vEmployeeDetails]
-------------------------------------------------
USE AdventureWorks

CREATE UNIQUE CLUSTERED INDEX IX_vEmployeeDetails
ON HumanResources.vEmployeeDetails (EmployeeID)
-------------------------------------------------
sp_depends @objname = N'HumanResources.vEmployeeDetails ' ;
-------------------------------------------------
sp_help @objname = N'HumanResources.vEmployeeDetails ' ;