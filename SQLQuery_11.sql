Use [AdventureWorks]
GO
CREATE TABLE [HumanResources].[JobCandidateHistory](
[JobCandidateID][int] NOT NULL UNIQUE,
[Resume][xml] NULL,
[Rating][int] NOT NULL CONSTRAINT [DF_JobCandidateHistory] Default (5),
[RejectedDate][datetime] NOT NULL,
[ContactID][int] NULL, 
CONSTRAINT [FK_JobCandidateHistory_Contact_ContactID] FOREIGN KEY (ContactID) REFERENCES [Person].[Contact](ContactId),
CONSTRAINT [CK_JobCandidateHistory_Rating] CHECK ([Rating]>=0 AND [Rating]<=10)
) ON [PRIMARY];
-----------------------------
Use [AdventureWorks]
GO
CREATE TRIGGER dJobCandidate on [HumanResources].[JobCandidate]
FOR DELETE 
AS INSERT INTO [HumanResources].[JobCandidateHistory]( 
       [JobCandidateID]
      ,[Resume]
      ,[RejectedDate]
      ,[ContactID])
  SELECT 
	[JobCandidateID]
	,[Resume]
	,GETDATE()
	,NULL
FROM DELETED;
GO
-----------------------
Use [AdventureWorks]
GO
DELETE FROM HumanResources.JobCandidate 
WHERE JobCandidateID = (Select MIN(JobCandidateID) FROM HumanResources.JobCandidate);

SELECT * 
FROM HumanResources.JobCandidateHistory;
TRUNCATE TABLE HumanResources.JobCandidateHistory;
----------------------------
Use [AdventureWorks]
GO
CREATE TRIGGER OrderDetailNotDiscontinued  on [Sales].[SalesOrderDetail] 
FOR INSERT 
AS 
     DECLARE @DiscontinuedDate datetime
	 set @DiscontinuedDate = (select DiscontinuedDate from [Production].[Product] where ProductID = (Select ProductID from INSERTED))
	begin
		if @DiscontinuedDate != NULL 
			RAISERROR('ERROR!', 18, 1)
			ROLLBACK TRANSACTION CURRENT_TRANSACTION_ID;
	end;
;

Select ProductID, Name from Production.Product
where DiscontinuedDate is not NULL;

Update Production.Product
set DiscontinuedDate = GETDATE()
where ProductID =680;

insert [Sales].[SalesOrderDetail] (SalesOrderID, OrderQty, ProductID, SpecialOfferID, UnitPrice,UnitPriceDiscount)
VALUES (43660, 5, 1, 1, 1431, 0);