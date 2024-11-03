CREATE PROCEDURE sp_BorrowedBooksReport 
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Books.BookID,
        Books.Title,
        Books.Author,
        Borrowers.BorrowerID,
        Borrowers.FirstName + ' ' + Borrowers.LastName AS BorrowerName,
        Loans.DateBorrowed,
        Loans.DueDate,
        ISNULL(Loans.DateReturned, 'Not Returned') AS DateReturned
    FROM 
        Loans
    JOIN 
        Books ON Loans.BookID = Books.BookID
    JOIN 
        Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
    WHERE 
        Loans.DateBorrowed BETWEEN @StartDate AND @EndDate
    ORDER BY 
        Loans.DateBorrowed;
END;
