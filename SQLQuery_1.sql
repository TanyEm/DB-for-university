SELECT 
    title, 
    title_no 
FROM 
  library.dbo.title;
-----------------------
SELECT 
    title, 
    title_no 
FROM 
    library.dbo.title 
WHERE 
    title_no = 10;
-----------------------
SELECT 
    member_no,
    fine_assessed 
FROM 
    library.dbo.loanhist 
WHERE 
    fine_assessed BETWEEN 8.0 and 9.0;

SELECT 
    t.title, 
    t.author 
FROM 
    library.dbo.title t
WHERE 
    t.author = 'Charles Dickens' or t.author = 'Jane Austen'

SELECT 
    t.title, 
    t.title_no 
FROM 
    library.dbo.title t
WHERE 
    t.title like '%Adventures%' 

SELECT 
    l.member_no,
    l.fine_assessed,
    l.fine_paid 
FROM 
    library.dbo.loanhist l
WHERE 
    l.fine_paid IS NULL

SELECT DISTINCT
    a.city,
    a.state
FROM 
    library.dbo.adult a

SELECT DISTINCT
    t.title_no,
    t.title
FROM 
    library.dbo.title t
ORDER BY title

SELECT DISTINCT
    l.member_no,
    l.isbn,
    l.fine_assessed
FROM 
    library.dbo.loanhist l
WHERE l.fine_assessed IS NOT NULL

SELECT DISTINCT
    l.member_no,
    l.isbn,
    l.fine_assessed,
    fine_assessed*2 as 'double fine'
FROM 
    library.dbo.loanhist l
WHERE l.fine_assessed IS NOT NULL

SELECT
    LOWER( CONCAT(m.lastname, m.middleinitial, SUBSTRING(m.lastname, 1,2)) ) AS email_name
FROM 
    library.dbo.member m
WHERE m.lastname = 'Anderson'

SELECT
    CONCAT_WS(' ', 'The title is',  t.title, 'title number', CONVERT(char, t.title_no)) AS the_title
FROM 
  library.dbo.title t

EXEC sp_who

SELECT @@SPID

EXEC sp_who 51

SELECT @@VERSION

SELECT USER_NAME(),DB_NAME(),@@SERVERNAME

USE library
SELECT*
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'base table'