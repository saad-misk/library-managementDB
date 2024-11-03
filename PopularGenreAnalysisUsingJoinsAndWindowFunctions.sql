DECLARE @TargetMonth INT = 5;
DECLARE @TargetYear INT = 2023;

WITH GenreBorrowCount AS (
	SELECT
		Books.Genre,
		COUNT(Loans.LoanID) as BorrowCount
	FROM 
		Loans
	JOIN 
		Books ON Books.BookID = Loans.BookID
	WHERE 
		MONTH(Loans.DateBorrowed) = @TargetMonth
		AND YEAR(Loans.DateBorrowed) = @TargetYear
	GROUP BY 
		Books.Genre
),
RankedGenre AS (
	SELECT 
		Genre,
		BorrowCount,
		RANK() OVER (ORDER BY BorrowCount DESC) AS GenreRank
	FROM
		GenreBorrowCount
)

SELECT TOP(1) *
FROM RankedGenre