DECLARE @borrowerID INT
SET @borrowerID = 2;

SELECT CONCAt(Borrowers.FirstName, Borrowers.LastName) as [borrower name], Books.BookID, Title, Author, Genre, CurrentStatus
FROM Books 
JOIN Loans ON Books.BookID = Loans.BookID
JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
WHERE Borrowers.BorrowerID = @borrowerID
GO