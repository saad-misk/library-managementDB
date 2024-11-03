CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)  
RETURNS DECIMAL(10, 2)
AS BEGIN
		DECLARE	@DueDate DATE,
				@DateReturned DATE,
				@OverDueDate INT,
				@Fee DECIMAL(10, 2) = 0;

		SELECT @DueDate = DueDate,
			   @DateReturned = DateReturned
		FROM Loans
		WHERE LoanID = @LoanID;


		SET @DateReturned = ISNULL(@DateReturned, GETDATE());

		SET @OverDueDate = DATEDIFF(DAY, @DueDate, @DateReturned);

		IF @OverDueDate > 0
		BEGIN
		
			SET @Fee = CASE 
							WHEN @OverDueDate <= 30 THEN (@OverDueDate * 1)
							ELSE (30 * 1) + ((@OverDueDate - 30) * 2)
						END

		END

		RETURN @Fee;

	END