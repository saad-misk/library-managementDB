--CREATE DATABASE LibraryManagement;
--GO

USE LibraryManagement;
GO

CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(255) NOT NULL,
    ISBN CHAR(13) UNIQUE NOT NULL,
    PublishedDate DATE,
    Genre NVARCHAR(100),
    ShelfLocation NVARCHAR(50),
    CurrentStatus NVARCHAR(10) CHECK (CurrentStatus IN ('Available', 'Borrowed')) NOT NULL
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    DateOfBirth DATE,
    MembershipDate DATE DEFAULT GETDATE()
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT FOREIGN KEY REFERENCES Books(BookID) ON DELETE CASCADE,
    BorrowerID INT FOREIGN KEY REFERENCES Borrowers(BorrowerID) ON DELETE CASCADE,
    DateBorrowed DATE NOT NULL,
    DueDate DATE NOT NULL,
    DateReturned DATE NULL
);
