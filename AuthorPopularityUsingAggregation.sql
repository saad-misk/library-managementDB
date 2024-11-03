SELECT 
	Author,
	COUNT(Loans.LoanID) AS BorrowingFrequency,
	RANK() OVER (ORDER BY COUNT(Loans.LoanID) DESC) AS AuthorRank
FROM
	Books
JOIN 
	Loans ON Books.BookID = Loans.BookID
Group By Author
ORDER BY BorrowingFrequency DESC;