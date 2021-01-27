CREATE PROCEDURE Sales.GetDiscounts
AS
SELECT Description,
 DiscountPct,
 Type,
 Category,
 StartDate,
 EndDate,
 MinQty,
 MaxQty
FROM Sales.SpecialOffer
ORDER BY StartDate, EndDate
----------------------
EXEC Sales.GetDiscounts
----------------------
CREATE PROCEDURE Sales.GetDiscountsForCategory
@Category nvarchar(50)
AS
SELECT Description,
 DiscountPct,
 Type,
 Category,
 StartDate,
 EndDate,
 MinQty,
 MaxQty
FROM Sales.SpecialOffer
WHERE Category = @Category
ORDER BY StartDate, EndDate 
----------------------
EXEC Sales.GetDiscountsForCategory 'Reseller'
----------------------
CREATE PROCEDURE Sales.GetDiscountsForCategoryAndDate
@Category nvarchar(50),
@DateToCheck datetime = NULL
AS
IF (@DateToCheck IS NULL)
 SET @DateToCheck = GetDate()
SELECT Description,
 DiscountPct,
 Type,
 Category,
 StartDate,
 EndDate,
 MinQty,
 MaxQty
FROM Sales.SpecialOffer
WHERE Category = @Category
 AND @DateToCheck BETWEEN StartDate AND EndDate
ORDER BY StartDate, EndDate 
----------------------
EXEC Sales.GetDiscountsForCategoryAndDate 'Reseller'
----------------------
DECLARE @DateToCheck datetime
SET @DateToCheck = DateAdd(month, 1, GETDATE())
EXEC Sales.GetDiscountsForCategoryAndDate 'Reseller', @DateToCheck
----------------------
CREATE PROCEDURE Sales.AddDiscount
 @Description nvarchar(255),
 @DiscountPct smallmoney,
 @Type nvarchar(50),
 @Category nvarchar(50),
 @StartDate datetime,
 @EndDate datetime,
 @MinQty int,
 @MaxQty int,
 @NewProductID int OUTPUT
AS
BEGIN TRY
 INSERT Sales.SpecialOffer (Description, DiscountPct, Type, Category,
 StartDate, EndDate, MinQty, MaxQty)
 VALUES (@Description, @DiscountPct, @Type, @Category, @StartDate,
 @EndDate, @MinQty, @MaxQty)
 SET @NewProductID = SCOPE_IDENTITY()
 RETURN 0
END TRY
BEGIN CATCH
 INSERT dbo.ErrorLog
 (UserName, ErrorNumber, ErrorSeverity,
 ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
 VALUES
 (CONVERT(sysname, CURRENT_USER), ERROR_NUMBER(),
 ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(),
 ERROR_LINE(), ERROR_MESSAGE() )
 RETURN -1
END CATCH
----------------------
DECLARE @StartDate datetime, @EndDate datetime
SET @StartDate = GetDate()
SET @EndDate = DateAdd(month, 1, @StartDate)
DECLARE @NewId int
EXEC Sales.AddDiscount
 'Half price off everything', 0.5,
 'Seasonal Discount',
 'Customer',
 @StartDate,
 @EndDate,
 0,
 20,
 @NewID OUTPUT
SELECT @NewID 
----------------------
DECLARE @StartDate datetime, @EndDate datetime
SET @StartDate = GetDate()
SET @EndDate = DateAdd(month, 1, @StartDate)
DECLARE @NewId int, @ReturnValue int
EXEC @ReturnValue = Sales.AddDiscount
 'Half price off everything',
 -0.5, -- UNACCEPTABLE VALUE
 'Seasonal Discount',
 'Customer',
 @StartDate,
 @EndDate,
 0,
 20,
 @NewID OUTPUT
IF (@ReturnValue = 0)
 SELECT @NewID
ELSE
 SELECT TOP 1 * FROM dbo.ErrorLog ORDER BY ErrorTime DESC
