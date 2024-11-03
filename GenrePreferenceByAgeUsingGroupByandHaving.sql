WITH AgeGroups AS (
    SELECT 
        Borrowers.BorrowerID,
        Books.Genre,
        DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) AS Age,
        CASE 
            WHEN DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
            WHEN DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
            WHEN DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
            WHEN DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
            WHEN DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
            WHEN DATEDIFF(YEAR, Borrowers.DateOfBirth, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
            ELSE '60+' 
        END AS AgeGroup
    FROM 
        Loans
    JOIN 
        Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
    JOIN 
        Books ON Loans.BookID = Books.BookID
)
SELECT 
    AgeGroup,
    Genre,
    COUNT(*) AS GenreBorrowCount
FROM 
    AgeGroups
GROUP BY 
    AgeGroup, 
    Genre
HAVING 
    COUNT(*) = (
        SELECT MAX(GenreBorrowCount)
        FROM (
            SELECT Genre, COUNT(*) AS GenreBorrowCount
            FROM AgeGroups AS InnerGroup
            WHERE InnerGroup.AgeGroup = AgeGroups.AgeGroup
            GROUP BY Genre
        ) AS GenreCounts
    )
ORDER BY 
    AgeGroup;
