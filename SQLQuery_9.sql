CREATE FUNCTION Sales.GetMaximumDiscountCategory(@Category NVARCHAR(50))
RETURNS SMALLMONEY
AS
BEGIN
    RETURN (SELECT DISTINCT MAX(DiscountPct) 
            FROM Sales.SpecialOffer 
            WHERE Category = @Category AND StartDate < GETDATE() AND GETDATE() < EndDate);
END
GO
---------------------------------
SELECT Sales.GetMaximumDiscountCategory('Reseller') AS MaxDiscountPct;
---------------------------------
CREATE FUNCTION Sales.GetMaximumDiscountForDate(@DateToCheck DATETIME)
RETURNS TABLE
AS
RETURN
(SELECT Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty
FROM Sales.SpecialOffer
WHERE @DateToCheck BETWEEN StartDate AND EndDate)
---------------------------------
SELECT * 
FROM Sales.GetMaximumDiscountForDate(GETDATE())
ORDER BY DiscountPct DESC
---------------------------------
CREATE FUNCTION Sales.GetDiscountedProducts()
RETURNS TABLE
AS
RETURN (SELECT PP.ProductID, PP.Name, PP.ListPrice, SSO.Description AS DiscountDescription, SSO.DiscountPct AS DiscountPersentage,
		PP.ListPrice*SSO.DiscountPct AS DiscountAmount,
		PP.ListPrice - PP.ListPrice*SSO.DiscountPct AS DiscountPrice
		FROM Sales.SpecialOfferProduct SSOP 
		JOIN Sales.SpecialOffer SSO ON SSOP.SpecialOfferID = SSO.SpecialOfferID
		JOIN Production.Product PP ON SSOP.ProductID = PP.ProductID)
GO
---------------------------------
SELECT * FROM Sales.GetDiscountedProducts();
---------------------------------

