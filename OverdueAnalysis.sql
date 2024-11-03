SELECT 
	Books.BookID,
	Books.Title,
	Books.Author,
	Borrowers.BorrowerID,
	Borrowers.FirstName,
	Borrowers.LastName,
	Loans.DateBorrowed,
	Loans.DueDate,
	DATEDIFF(DAY, Loans.DateBorrowed, ISNULL(Loans.DateReturned, GETDATE())) AS OverdueDays
FROM
	Loans
JOIN 
	Books ON Loans.BookID = Books.BookID
JOIN 
	Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
ORDER BY OverdueDays DESC;