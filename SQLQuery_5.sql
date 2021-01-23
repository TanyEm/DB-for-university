-------------------------------------
WITH juvenile AS (
    SELECT 
        adult_member_no, 
        count(member_no) AS No_Of_Children 
    FROM [dbo].[juvenile]
    GROUP BY adult_member_no
    HAVING count(member_no) > 3
)  

SELECT 
    adult_member_no, 
    No_Of_Children, 
    expr_date 
FROM juvenile , (
    SELECT 
        member_no, 
        expr_date 
    FROM [dbo].[adult]
) AS adult 
WHERE member_no IN (adult_member_no);
-------------------------------------
WITH juvenile AS (
    SELECT 
        adult_member_no, 
        count(member_no) AS No_Of_Children 
    FROM [dbo].[juvenile]
    GROUP BY adult_member_no
    HAVING count(member_no) > 3
)  

SELECT adult_member_no, 
	No_Of_Children, 
	expr_date 
FROM juvenile  
INNER JOIN (
    SELECT 
        member_no, 
        expr_date 
    FROM [dbo].[adult]
) AS adult ON juvenile.adult_member_no = adult.member_no;
-------------------------------------
SELECT 
    firstname, 
	lAStname, 
   isbn, 
	(SELECT max(fine_paid) AS max 
    FROM loanhist 
    WHERE member_no = l.member_no), 
	l.member_no  
	FROM member AS m, 
		 (SELECT 
            member_no, 
		 	isbn, 
		 	fine_paid
		  FROM loanhist
        ) AS l 
WHERE l.member_no = m.member_no
-------------------------------------
SELECT m.firstname, 
	   m.lAStname, 
	   l.isbn, 
	   l.fine_paid
FROM member AS m
INNER JOIN (
    SELECT 
        member_no, 
	 	isbn, 
	 	fine_paid
    FROM loanhist
) AS l ON m.member_no = l.member_no
WHERE l.fine_paid = (
    SELECT 
        max(fine_paid) AS max 
    FROM loanhist
)
GROUP BY m.firstname, 
	   m.lAStname, 
	   l.isbn,
	   l.fine_paid;
-------------------------------------
SELECT 
    t.title_no AS title_no, 
	title, 
	l.isbn AS isbn,
	total_reserved
FROM title AS t, 
	 loan AS l, 
	 (SELECT 
        isbn, 
        count(*) AS total_reserved  
    FROM reservation AS r 
    GROUP BY isbn 
    HAVING count(*) > 50) AS r
WHERE t.title_no = l.title_no
AND l.isbn = r.isbn
GROUP BY t.title_no, title, l.isbn, total_reserved;
-------------------------------------
SELECT t.title_no AS title_no, 
	title, 
	l.isbn AS isbn,
	total_reserved
FROM title AS t, 
	 loan AS l, 
	 (SELECT 
        isbn, 
        count(*) AS total_reserved  
    FROM reservation AS r 
    GROUP BY isbn
) AS r
WHERE t.title_no = l.title_no
AND l.isbn = r.isbn
AND total_reserved in (1,2,3,4)
GROUP BY t.title_no, title, l.isbn, total_reserved;
-------------------------------------
WITH m AS (SELECT 
    firstname, 
    lAStname, 
    member_no 
FROM member)

SELECT 
    m.firstname, 
    m.lAStname, 
    m.member_no, 
    SUM(loanhist.fine_paid) AS sum_fine_paid 
FROM m, loanhist

WHERE m.member_no = loanhist.member_no
GROUP BY m.firstname, m.lAStname, m.member_no
HAVING SUM(loanhist.fine_paid) > 5;