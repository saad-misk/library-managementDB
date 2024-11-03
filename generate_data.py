from faker import Faker
import random
import datetime

fake = Faker()

# Generate Books
# with open("seed_books.sql", "w") as f:
#     f.write("INSERT INTO Books (BookID, Title, Author, ISBN, PublishedDate, Genre, ShelfLocation, CurrentStatus) VALUES\n")
#     genres = ["Fiction", "Non-Fiction", "Mystery", "Fantasy", "Sci-Fi", "Biography"]
#     for i in range(1, 1001):
#         title = fake.sentence(nb_words=3)
#         author = fake.name()
#         isbn = fake.isbn13()
#         published_date = fake.date_between(start_date="-20y", end_date="today")
#         genre = random.choice(genres)
#         shelf_location = f"Shelf-{random.randint(1, 100)}"
#         status = random.choice(['Available', 'Borrowed'])
#         f.write(f"({i}, '{title}', '{author}', '{isbn}', '{published_date}', '{genre}', '{shelf_location}', '{status}'),\n")
#     f.write(";")

# Generate Borrowers
# email_list = []
# with open("seed_borrowers.sql", "w") as f:
#     f.write("INSERT INTO Borrowers (BorrowerID, FirstName, LastName, Email, DateOfBirth, MembershipDate) VALUES\n")
#     for i in range(1, 1001):
#         first_name = fake.first_name()
#         last_name = fake.last_name()
#         email = fake.email()
#         while( email in email_list ) :
#             email = fake.email()
#         email_list.append(email)
#         dob = fake.date_of_birth(minimum_age=18, maximum_age=75)
#         membership_date = fake.date_between(start_date="-10y", end_date="today")
#         f.write(f"({i}, '{first_name}', '{last_name}', '{email}', '{dob}', '{membership_date}'),\n")
#     f.write(";")

# Generate Loans
with open("seed_loans.sql", "w") as f:
    f.write("INSERT INTO Loans (LoanID, BookID, BorrowerID, DateBorrowed, DueDate, DateReturned) VALUES\n")
    for i in range(1, 1001):
        book_id = random.randint(1, 1000)
        borrower_id = random.randint(1, 1000)
        date_borrowed = fake.date_between(start_date="-2y", end_date="today")
        due_date = date_borrowed + datetime.timedelta(days=14)
        date_returned = due_date + datetime.timedelta(days=random.randint(0, 30)) if random.choice([True, False]) else "NULL"
        if( date_returned == "NULL" ): 
            f.write(f"({i}, {book_id}, {borrower_id}, '{date_borrowed}', '{due_date}', {date_returned}),\n")
        else :
            f.write(f"({i}, {book_id}, {borrower_id}, '{date_borrowed}', '{due_date}', '{date_returned}'),\n")
    f.write(";")
