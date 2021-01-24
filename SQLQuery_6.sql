USE AdventureWorks
GO
CREATE TABLE HumanResources.JobCandidateHistory(
 JobCandidateID int NOT NULL UNIQUE,
 Resume xml NULL,
 Rating int NOT NULL CONSTRAINT DF_JobCandidateHistory_Rating
 Default (5),
 RejectedDate datetime NOT NULL,
 ContactID int NULL,
 CONSTRAINT FK_JobCandidateHistory_Contact_ContactID
 FOREIGN KEY(ContactID) REFERENCES Person.Contact (ContactID),
 CONSTRAINT CK_JobCandidateHistory_Rating
 CHECK (Rating >= 0 AND Rating <= 10)
) ON [PRIMARY] 