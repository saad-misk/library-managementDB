SELECT 
	Borrowers.BorrowerID,
	Borrowers.FirstName,
	Borrowers.LastName,
	COUNT(Loans.LoanID) as TotalBorrowed,
	RANK() OVER (ORDER BY COUNT(Loans.LoanID) DESC) AS RankBorrowing
FROM
	Borrowers
JOIN
	Loans ON Borrowers.BorrowerID = Loans.BorrowerID
GROUP BY 
	Borrowers.BorrowerID,
	Borrowers.FirstName,
	Borrowers.LAstName