CREATE PROCEDURE sp_AddNewBorrower
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Email NVARCHAR(255),
    @DateOfBirth DATE,
    @MembershipDate DATE,
    @NewBorrowerID INT OUTPUT  -- Output parameter for the new BorrowerID
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the email already exists
    IF EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
    BEGIN
        -- If email exists, return an error message
        RAISERROR('A borrower with this email already exists.', 16, 1);
        RETURN;
    END

    -- Insert the new borrower if email is unique
    INSERT INTO Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
    VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

    -- Get the newly inserted BorrowerID
    SET @NewBorrowerID = SCOPE_IDENTITY();

    -- Return the new BorrowerID
    RETURN;
END;