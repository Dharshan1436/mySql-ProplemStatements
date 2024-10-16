create database assignment;
use assignment;
create table Authors (
author_id int Primary Key,
first_name varchar(30),
last_name varchar(20),
date_of_birth date,
nationality varchar(20)
);

desc Authors;

create  table Members(
member_id int Primary Key,
first_name varchar(30),
last_name varchar(20),
date_of_birth date,
contact_number bigint,
email varchar(30),
membership_date date
);

desc members;

create table Books(
book_id int Primary Key,
title varchar(50),
author_id  int,
publication_year year,
genre varchar(20),
isbn varchar(30),
available_copies int,
foreign key(author_id) references Authors(author_id)
);

desc Books;

create table Loans(
loan_id int Primary Key,
book_id  int ,member_id  int,
loan_date date,return_date date,
actual_return_date date,
foreign key(book_id) references Books(book_id),
 foreign key(member_id) references Members(member_id) 
 ) ;
 
desc Loans;

create table Staff(
staff_id int Primary Key,
first_name varchar(30),
last_name varchar(30),
position varchar(30),
contact_number bigint,
email varchar(30),
hire_date date);

desc Staff;


-- DDL Queries --
alter table Books add language VARCHAR(30);

alter table Staff rename column   position to  job_title ;

alter table  members drop email;



INSERT INTO Authors (author_id, first_name, last_name, date_of_birth, nationality) VALUES
(1, 'Arundhati', 'Roy', '1961-11-24', 'Indian'),
(2, 'Gabriel', 'Garcia Marquez', '1927-03-06', 'Colombian'),
(3, 'George', 'Orwell', '1903-06-25', 'British'),
(4, 'Haruki', 'Murakami', '1949-01-12', 'Japanese'),
(5, 'J.K.', 'Rowling', '1965-07-31', 'British');


INSERT INTO Books (book_id, title, author_id, publication_year, genre, isbn, available_copies, language) VALUES
(1, 'The God of Small Things', 1, 1997, 'Fiction', '9780679457312', 5, 'English'),
(2, 'One Hundred Years of Solitude', 2, 1967, 'Magical Realism', '9780060883287', 3, 'Spanish'),
(3, '1984', 3, 1949, 'Dystopian', '9780451524935', 7, 'English'),
(4, 'Kafka on the Shore', 4, 2002, 'Fiction', '9781400079278', 4, 'Japanese'),
(5, 'Harry Potter and the Sorcerer''s Stone', 5, 1997, 'Fantasy', '9780439708180', 6, 'English');

INSERT INTO Members (member_id, first_name, last_name, date_of_birth, contact_number, membership_date) VALUES
(1, 'Ravi', 'Sharma', '1995-07-15', 9876543210, '2023-01-01'),
(2, 'Asha', 'Patel', '1988-03-22', 9876543211, '2022-05-15'),
(3, 'Raj', 'Mehta', '2000-11-10', 9876543212, '2024-02-10'),
(4, 'Sita', 'Kumar', '1992-08-05', 9876543213, '2023-03-20'),
(5, 'Vikram', 'Singh', '1985-09-30', 9876543214, '2021-12-05');

INSERT INTO Loans (loan_id, book_id, member_id, loan_date, return_date, actual_return_date) VALUES
(1, 1, 1, '2024-09-01', '2024-09-15', '2024-09-14'),
(2, 2, 2, '2024-09-05', '2024-09-20', NULL),
(3, 3, 3, '2024-09-10', '2024-09-25', '2024-09-24'),
(4, 4, 4, '2024-10-01', '2024-10-15', NULL),
(5, 5, 5, '2024-10-05', '2024-10-20', NULL);

INSERT INTO Staff (staff_id, first_name, last_name, job_title, contact_number, email, hire_date) VALUES
(1, 'Anita', 'Desai', 'Librarian', 9876543215, 'anita.desai@example.com', '2022-01-15'),
(2, 'Rajesh', 'Kumar', 'Assistant', 9876543216, 'rajesh.kumar@example.com', '2021-06-10'),
(3, 'Sunita', 'Mehta', 'Manager', 9876543217, 'sunita.mehta@example.com', '2023-03-01'),
(4, 'Vijay', 'Sharma', 'Technician', 9876543218, 'vijay.sharma@example.com', '2020-09-20'),
(5, 'Priya', 'Singh', 'Clerk', 9876543219, 'priya.singh@example.com', '2024-04-05');


select * from authors;
select * from books;
select * from members;
select * from loans;
select * from staff;

-- DML Queries --
-- Insert new data into the books table: --

INSERT INTO Authors (author_id, first_name, last_name, date_of_birth, nationality) VALUES
(6, 'J.D.', 'Salinger', '1919-01-01', 'American');
INSERT INTO Books (book_id, title, author_id, publication_year, genre, isbn, available_copies, language) VALUES
(6, 'The Catcher in the Rye', 6, 1951, 'Fiction', '9780316769488', 4, 'English');

-- Update a member's contact number --
update members set contact_number = 7859648745 where member_id=1;

--  Delete a specific loan record --
delete  from loans where loan_id=1;

--  Insert a new loan record: --
insert into loans values(1,1,1,"2024-10-08","2024-10-23",null);

-- Join Queries --
 -- 1. Retrieve all books along with their authors:
 SELECT 
    b.book_id, 
    b.title, 
    a.first_name AS author_first_name, 
    a.last_name AS author_last_name, 
    b.publication_year, 
    b.genre, 
    b.isbn, 
    b.available_copies, 
    b.language
FROM 
    Books b
JOIN 
    Authors a ON b.author_id = a.author_id;
    
 -- 2. Find all books currently on loan along with member details:   
    SELECT 
    l.loan_id, 
    b.title, 
    m.first_name AS member_first_name, 
    m.last_name AS member_last_name, 
    l.loan_date, 
    l.return_date, 
    l.actual_return_date
FROM 
    Loans l
JOIN 
    Books b ON l.book_id = b.book_id
JOIN 
    Members m ON l.member_id = m.member_id
WHERE 
    l.actual_return_date IS NULL; 
    
-- 3. List all books borrowed by a specific member:
SELECT 
    l.loan_id, 
    b.title, 
    l.loan_date, 
    l.return_date, 
    l.actual_return_date
FROM 
    Loans l
JOIN 
    Books b ON l.book_id = b.book_id
JOIN 
    Members m ON l.member_id = m.member_id
WHERE 
    m.member_id = 1;
    
    
    
    -- 4. Get the total number of books and the total available copies for each genre:
    SELECT 
    genre, 
    COUNT(book_id) AS total_books, 
    SUM(available_copies) AS total_available_copies
FROM 
    Books
GROUP BY 
    genre;
    
    
    
    -- 5. Find all staff members who are librarians and their hire dates:
    SELECT 
    staff_id, 
    first_name, 
    last_name, 
    hire_date
FROM 
    Staff
WHERE 
    job_title = 'Librarian';