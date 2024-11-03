WITH UnreturnedBooks AS (
	SELECT BorrowerID, COUNT(*) AS UnreturnedCount
	FROM loans
	WHERE DateReturned is null
	GROUP BY BorrowerID
)

SELECT Borrowers.BorrowerID, Borrowers.FirstName, Borrowers.LastName, UnreturnedCount
FROM UnreturnedBooks
JOIN Borrowers on Borrowers.BorrowerID = UnreturnedBooks.BorrowerID
WHERE UnreturnedCount >= 2;