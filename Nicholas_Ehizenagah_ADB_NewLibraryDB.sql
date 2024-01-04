

CREATE DATABASE NewLibraryDB;

  Use NewLibraryDB; 

CREATE TABLE MemberAddress(
AddressID Int IDENTITY(1,1) PRIMARY KEY,
Address1 nvarchar(100) NOT NULL,
Address2 nvarchar(100) NULL,
City nvarchar(20) NOT NULL,
Postcode nvarchar(10) NOT NULL)
  
  -- Create MemberInformation Table

CREATE TABLE MembersInformation(
MemberID Int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(20) NOT NULL, 
MiddleName nvarchar(20) NULL,
LastName nvarchar(20) NOT NULL,
DateOfBirth Date NOT NULL,
AddressID Int NOT NULL FOREIGN KEY(AddressID) REFERENCES MemberAddress(AddressID),
Username nvarchar(20) UNIQUE NOT NULL,
MemberPassword nvarchar(15) UNIQUE NOT NULL,
Email nvarchar(50) UNIQUE NULL CHECK(Email LIKE '%_@_%._%'),
Telephone nvarchar(20) NULL,
MembershipEndedDate Date NOT NULL);





-- Create Item Table

CREATE TABLE ItemTypes(
ItemTypeID Int IDENTITY(1,1) PRIMARY KEY,
ItemType nvarchar(20) NOT NULL);



-- Create Library Catalogue

CREATE TABLE LibraryCatalogue(
ItemID Int IDENTITY(1,1) PRIMARY KEY,
ItemTitle nvarchar(50) NOT NULL,
ItemTypeID int NOT NULL FOREIGN KEY(ItemTypeID) REFERENCES ItemTypes(ItemTypeID), 
Author nvarchar(30) NOT NULL,
YearPublished Date NOT NULL,
Date_ItemAdded Date NOT NULL,
ItemStatus nvarchar(20) NOT NULL,
LostOrRemovedIdentifiedDate Date NULL, 
ISBN nvarchar(30) NULL);

--Dont Run Loan History Table Creation

CREATE TABLE LoanHistory(
LoanID  int IDENTITY(1,1) NOT NULL PRIMARY KEY,
MemberID  int  NOT NULL FOREIGN KEY(MemberID) REFERENCES MembersInformation(MemberID),
ItemID  int  NOT NULL FOREIGN KEY(ItemID) REFERENCES LibraryCatalogue(ItemID),
ItemDateTakenOut date NOT NULL,
ItemDueBackDate date NOT NULL, 
ReturnedDate date NULL,
DaysOverdue int NULL);


-- Five Overdue Table Creation  


CREATE TABLE FineOverdue(
FineOverdueID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
MemberID  int  NOT NULL FOREIGN KEY(MemberID) REFERENCES MembersInformation(MemberID),
TotalFine money NOT NULL,
TotalFineRepaid money NOT NULL, 
OutstandingBalance money NULL);


--Creation of Fine Payment

CREATE TABLE FineRepayment(
FineRepaymentID  int IDENTITY(1,1) NOT NULL PRIMARY KEY,
MemberID  int  NOT NULL FOREIGN KEY(MemberID) REFERENCES MembersInformation(MemberID),
FineOverdueID int  NOT NULL FOREIGN KEY(FineOverdueID) REFERENCES FineOverdue(FineOverdueID),
AmountPaid money NOT NULL,
PaidDate datetime NOT NULL);

-- Data Inserting into the Member Address tables that was created
INSERT INTO MemberAddress (Address1, Address2, City, Postcode)
VALUES ('23 Silver Birch Drive', NULL, 'Bolton', 'BL1 8AR'),
       ('44 Park Street', 'Suite 5', 'Bolton', 'BL2 6ZS'),
       ('12 Hawthorn Lane', 'Flat 1', 'Bolton', 'BL3 2LE'),
       ('67 Oak Avenue', 'Apartment 3', 'Bolton', 'BL4 0WA'),
       ('89 Elm Street', NULL, 'Bolton', 'BL5 5HD'),
       ('5 Willow Road', 'Floor 2', 'Bolton', 'BL6 9SA'),
       ('33 Poplar Close', NULL, 'Bolton', 'BL7 7DJ'),
       ('72 Acacia Avenue', 'Suite 8', 'Bolton', 'BL8 0AR'),
       ('19 Beechwood Drive', 'Flat 2', 'Bolton', 'BL9 6FG'),
       ('36 Chestnut Grove', NULL, 'Bolton', 'BL2 2FG');


--Inseriting values into Member Information

INSERT INTO MembersInformation (FirstName, MiddleName, LastName, DateOfBirth, AddressID, Username, MemberPassword,
Email, Telephone, MembershipEndedDate)
VALUES 
('Avery', 'Mae', 'Baker', '1990-05-17', 1, 'abaker', 'password1', 'abaker@example.com', '555-1234', '2022-06-30'),
('Ethan', 'James', 'Carter', '1985-09-22', 2, 'ecarter', 'password2', 'ecarter@example.com', NULL, '2021-12-31'),
('Olivia', 'Grace', 'Davis', '1999-02-03', 3, 'odavis', 'password3', 'odavis@example.com', '555-5678', '2023-01-31'),
('Evelyn', 'Rose', 'Gonzalez', '1982-11-08', 4, 'egonzalez', 'password4', 'egonzalez@example.com', '555-9876', '2022-06-30'),
('Jackson', 'Caleb', 'Hall', '1998-07-14', 5, 'jhall', 'password5', 'jhall@example.com', NULL, '2024-12-31'),
('Mila', 'Skye', 'Jackson', '1993-01-01', 6, 'mjackson', 'password6', 'mjackson@example.com', '555-4321', '2022-06-30'),
('Henry', 'Charles', 'Lee', '1995-04-19', 7, 'hlee', 'password7', 'hlee@example.com', NULL, '2023-01-31'),
('Ella', 'Faith', 'Miller', '1988-08-27', 8, 'emiller', 'password8', 'emiller@example.com', '555-8765', '2022-06-30'),
('Liam', 'Jacob', 'Nguyen', '1996-03-12', 9, 'lnguyen', 'password9', 'lnguyen@example.com', NULL, '2021-12-31'),
('James', 'Michael', 'Young', '1983-12-17', 10, 'jyoung', 'password15', 'weinwright@example.com', NULL, '2022-06-30');
  
--Insert Values into Item Type

 Insert Into ItemTypes (ItemType) 
 Values ('Books'), ('Journals'), ('DVD'), ('Other Media');
 
 -- Insert Values into the Library Catalogue

INSERT INTO LibraryCatalogue (ItemTitle, ItemTypeID, Author, YearPublished, Date_ItemAdded, ItemStatus, LostOrRemovedIdentifiedDate, ISBN)
VALUES
('The Great Gatsby', 1, 'F. Scott Fitzgerald', '1925-04-10', '2022-03-01', 'Available', NULL, '978-3-16-148410-0'),
('To Kill a Mockingbird', 1, 'Harper Lee', '1960-07-11', '2022-03-01', 'Available', NULL, '978-0-446-31078-9'),
('The Catcher in the Rye', 1, 'J.D. Salinger', '1951-07-16', '2022-03-01', 'Checked Out', '2022-03-10', '978-3-16-148410-0'),
('The New York Times Magazine', 2, 'The New York Times', '2022-03-27', '2022-03-27', 'On Loan', NULL, NULL),
('Breaking Bad: Season 1', 3, 'Vince Gilligan', '2008-01-20', '2022-03-27', 'Checked Out', '2022-04-03', NULL),
('The Office: Season 1', 3, 'Greg Daniels', '2005-03-24', '2022-03-27', 'Available', NULL, NULL),
('The Game of Life', 4, 'Nick Stone', '2019-03-27', '2022-03-27', 'Available', NULL, NULL),
('Monopoly', 4, 'Ross Ehiz', '2017-03-27', '2017-04-27', 'Checked Out', '2022-03-30', NULL),
('National Geographic', 2, 'National Geographic Society', '2022-04-01', '2022-04-01', 'On Loan', NULL, NULL),
('Harry Potter and the Sorcerer Stone', 1, 'J.K. Rowling', '1997-06-26', '2022-04-01', 'Available', NULL, '978-0-747-54136-2');

-- Inserting values into Loan History table

INSERT INTO LoanHistory (MemberID, ItemID, ItemDateTakenOut, ItemDueBackDate, ReturnedDate, DaysOverdue)
VALUES 
(1, 1, '2022-03-01', '2023-04-05', NULL, NULL),
(2, 4, '2022-03-05', '2023-04-02', '2022-03-10', 5),
(3, 9, '2022-03-10', '2023-04-04', '2022-03-11', 1),
(4, 5, '2022-03-12', '2023-04-01', '2022-03-26', 0),
(5, 7, '2022-03-15', '2023-04-02', NULL, NULL),
(6, 10, '2022-03-18', '2023-04-01', '2022-03-21', 3),
(7, 8, '2022-03-22', '2023-04-05', NULL, NULL),
(8, 6, '2022-03-25', '2023-04-02', '2022-04-01', 2),
(9, 8, '2022-03-28', '2023-04-04', NULL, NULL),
(10, 1, '2022-04-18', '2023-04-02', '2022-04-21', 2);

-- Insert values into Fine Overdue table.

INSERT INTO FineOverdue (MemberID, TotalFine, TotalFineRepaid, OutstandingBalance)
VALUES (1, 50.00, 20.00, 30.00),
       (2, 75.00, 0.00, 75.00),
       (3, 10.00, 10.00, 0.00),
       (4, 20.00, 0.00, 20.00),
       (5, 100.00, 70.00, 30.00),
       (6, 30.00, 20.00, 10.00),
       (7, 40.00, 0.00, 40.00),
       (8, 90.00, 50.00, 40.00),
       (9, 15.00, 5.00, 10.00),
       (10, 60.00, 0.00, 60.00);


-- Inserting values into Fine Repayment table
INSERT INTO FineRepayment (MemberID, FineOverdueID, AmountPaid, PaidDate)
VALUES 
  (1, 1, 10.50, '2023-04-01 13:45:00'),
  (2, 2, 5.25, '2023-04-02 10:30:00'),
  (3, 3, 7.00, '2023-04-03 14:20:00'),
  (4, 4, 3.50, '2023-04-04 12:10:00'),
  (5, 5, 2.75, '2023-04-05 16:00:00'),
  (6, 6, 9.00, '2023-04-05 18:30:00'),
  (7, 7, 11.50, '2023-04-04 08:15:00'),
  (8, 8, 6.75, '2023-04-03 11:45:00'),
  (9, 9, 8.25, '2023-04-02 17:20:00'),
  (10, 10, 12.00, '2023-04-01 09:00:00');

	
--Question 2 A Search the catalogue for matching character strings by title. 
-- Results should be sorted with most recent publication date first. 
-- This will allow them to query the catalogue looking for a specific item.


CREATE PROCEDURE SearchLibraryCatalogueByItemTitle
@title nvarchar(100)
AS
BEGIN
SELECT ItemID, ItemTitle, ItemTypeID, Author, YearPublished, Date_Itemadded, LostOrRemovedIdentifiedDate, ItemStatus
FROM LibraryCatalogue
WHERE [ItemTitle] LIKE '%' + @title + '%'
ORDER BY [YearPublished] DESC
END


--Assuming that you want to retrieve items with similar authors
--based on a given author name from our Database

CREATE PROCEDURE SearchCatalogueByTitle
@Title nvarchar(30)
AS
BEGIN
SELECT ItemTitle, Author
FROM LibraryCatalogue
WHERE ItemTitle LIKE '%' + @Title + '%'
ORDER BY YearPublished DESC;
END;

EXEC SearchCatalogueByTitle @Title = 'Kill'


--Question 2 b

---Return a full list of all items currently on loan which have a due date of less 
-- Than five days from the current date (i.e., the system date when the query is run)

CREATE PROCEDURE GetItemDueBackDateWithinFiveDays
AS
BEGIN
    SELECT ItemDueBackDate
    FROM LoanHistory
    WHERE DATEDIFF(day, GETDATE(), ItemDueBackDate) < 5
    AND DATEDIFF(day, GETDATE(), ItemDueBackDate) >= 0
    ORDER BY ItemDueBackDate DESC;
END

Exec GetItemDueBackDateWithinFiveDays


--Question 2 (C) Insert a new member into the database


ALTER TABLE MembersInformation
ADD MembershipStartDate Date NOT NULL DEFAULT GETDATE();

INSERT INTO MembersInformation (FirstName, MiddleName, LastName,
DateOfBirth, AddressID, Username, MemberPassword, Email, Telephone,
MembershipEndedDate, MembershipStartDate)
VALUES ('Roseline', 'O', 'Ehizenagah', '1980-01-01', 1, 'RoseEhiz', 'password1023##', 'roseehiz@gmail.com', '123-456-7890', '2024-12-31', GETDATE());


select * from MembersInformation


--Question 2 (D) Update the details for an existing member

--This statement would update the email address
--for the member with MemberID 9 to "newemail@gmail.com"

UPDATE MembersInformation
SET Email = 'newemail@gmail.com'
WHERE MemberID = 9;

--Check the outcom

SELECT * FROM MembersInformation WHERE MemberID = 9;


--Question 3 

--The library wants be able to view the loan history, showing all previous and current 
--loans, and including details of the item borrowed, borrowed date, due date and any 
--associated fines for each loan. You should create a view containing all the required information.

-- Answer to Q 3


CREATE VIEW LoanHistoryView AS
SELECT lh.LoanID, lc.ItemTitle, mi.FirstName, mi.LastName, 
       lh.ItemDateTakenOut, lh.ItemDueBackDate, lh.ReturnedDate, 
       lh.DaysOverdue,
       CASE 
           WHEN lh.ReturnedDate IS NULL AND lh.ItemDueBackDate < GETDATE() 
                THEN DATEDIFF(day, lh.ItemDueBackDate, GETDATE()) * 0.5 
           WHEN lh.ReturnedDate > lh.ItemDueBackDate 
                THEN DATEDIFF(day, lh.ItemDueBackDate, lh.ReturnedDate) * 0.5 
           ELSE 0 
       END AS Fines
FROM LoanHistory lh
JOIN LibraryCatalogue lc ON lh.ItemID = lc.ItemID
JOIN MembersInformation mi ON lh.MemberID = mi.MemberID;


--Create View to show overdue items

CREATE VIEW OverdueItems
AS
SELECT LC.ItemID, LC.ItemTitle, LH.MemberID, LH.ItemDueBackDate, DATEDIFF(day, LH.ItemDueBackDate, GETDATE()) AS OverdueDays
FROM LibraryCatalogue LC
INNER JOIN LoanHistory LH ON LC.ItemID = LH.ItemID
WHERE LH.ItemDueBackDate IS NULL AND LH.ItemDueBackDate < GETDATE();


--User-defined function to calculate fines:

CREATE FUNCTION CalculateFines(@DaysOverdue INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @Fines MONEY;
    IF @DaysOverdue <= 7
        SET @Fines = @DaysOverdue * 0.50;
    ELSE IF @DaysOverdue <= 14
        SET @Fines = @DaysOverdue * 1.00;
    ELSE IF @DaysOverdue <= 30
        SET @Fines = @DaysOverdue * 2.00;
    ELSE
        SET @Fines = @DaysOverdue * 5.00;
    RETURN @Fines;
END;


-- check the outcome 

SELECT dbo.CalculateFines(5) AS 'Fines for 5 days overdue'

--Question 4

-- Trigger to update ItemAvailability when an Item is returned 

CREATE TRIGGER UpdateItemAvailabilityOnReturn
ON LoanHistory
AFTER DELETE
AS
BEGIN
    UPDATE LibraryCatalogue
    SET ItemStatus = 4
    WHERE ItemID = (SELECT ItemID FROM deleted);
END;


--I update the ItemStatus column with the string value "Available"
--when the trigger is fired after a record is deleted from the LoanHistory table.

CREATE OR ALTER TRIGGER UpdateItemAvailabilityOnReturn
ON LoanHistory
AFTER DELETE
AS
BEGIN
    UPDATE LibraryCatalogue
    SET ItemStatus = 'Available'
    WHERE ItemID = (SELECT ItemID FROM deleted);
END;


-- First, make sure the ItemStatus of the item in LibraryCatalogue is 'On Loan'
UPDATE LibraryCatalogue
SET ItemStatus = 'On Loan'
WHERE ItemID = 4;

-- Next, delete a row from the LoanHistory table
DELETE FROM LoanHistory WHERE LoanID = 4;

-- Finally, check if the ItemStatus in LibraryCatalogue is updated to 'Available'
SELECT ItemStatus FROM LibraryCatalogue WHERE ItemID = 4;

select * from LibraryCatalogue


--Question 5

--You should provide a function, view, or SELECT query which allows the library to 
--identify the total number of loans made on a specified date. 

CREATE FUNCTION dbo.GetTotalLoansOnDate (@ItemDateTakenOut DATE)
RETURNS INT
AS
BEGIN
    DECLARE @TotalLoans INT;
    SET @TotalLoans = (SELECT COUNT(*) FROM LoanHistory WHERE ItemDateTakenOut = @ItemDateTakenOut);
    RETURN @TotalLoans;
END;

SELECT dbo.GetTotalLoansOnDate('2023-04-05') AS TotalLoans;

-- 7 . If there are any other database objects such as views, stored procedures, user-defined 
--functions, or triggers which you think would be relevant to the library given the brief 
--above, you will obtain higher marks for providing these along with an explanation of 
--their functionality.

--- (1)
--This is a stored procedure named UpdateItemAvailability. It takes two input parameters @ItemID and @NewStatus, 
--which are used to update the ItemStatus column of the LibraryCatalogue table based on the specified @ItemID. 
--This procedure can be executed whenever there is a need to update the availability 
--status of an item in the library catalogue.

CREATE PROCEDURE UpdateItemAvailability
    @ItemID INT,
    @NewStatus VARCHAR(20)
AS
BEGIN
    UPDATE LibraryCatalogue
    SET ItemStatus = @NewStatus
    WHERE ItemID = @ItemID
END

--uodate item on loan
EXEC UpdateItemAvailability @ItemID = 4, @NewStatus = 'On Loan';

SELECT ItemStatus
FROM LibraryCatalogue
WHERE ItemID = 4;


--(2) The above code creates a stored procedure named GetAvailableItems. 
--This procedure retrieves all the items in the LibraryCatalogue table that have an
--ItemStatus of 'Available'. The procedure does not accept any input parameters and 
--returns all available items.This procedure can be used by library staff to quickly 
--view all available items in the library.

CREATE PROCEDURE GetAvailableItems
AS
BEGIN
    SELECT *
    FROM LibraryCatalogue
    WHERE ItemStatus = 'Available';
END

--Viewing output

EXEC GetAvailableItems;

--(3)  The trigger updates the "DaysOverdue" field in the "LoanHistory" 
--table whenever the "ReturnedDate" field is updated, by calculating the difference 
--between the "ItemDueBackDate" and "ReturnedDate" minus 1 day. It uses the "inserted"
--table to identify the relevant loan IDs.

CREATE OR ALTER TRIGGER UpdateLoanHistoryOnItemReturn
ON LoanHistory
AFTER UPDATE
AS
BEGIN
    IF UPDATE(ReturnedDate)
    BEGIN
        UPDATE LoanHistory
        SET DaysOverdue = DATEDIFF(day, ItemDueBackDate, ReturnedDate) - 1
        WHERE LoanID IN (SELECT LoanID FROM inserted)
    END
END

-- check the code
SELECT DaysOverdue
FROM LoanHistory
WHERE LoanID = 10;

--(4) This is a SQL Server user-defined scalar function named CalculateLateFee
--that takes an integer input parameter @DaysOverdue and returns the corresponding 
--late fee as a monetary value. The function calculates the late fee by multiplying the
--number of days overdue by a constant factor of 0.10 and returns the result.


CREATE FUNCTION CalculateLateFee(@DaysOverdue INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @LateFee MONEY;
    SET @LateFee = @DaysOverdue * 0.10;
    RETURN @LateFee;
END;

--Check the code

SELECT dbo.CalculateLateFee(25) AS LateFee;

--7(5) 

CREATE PROCEDURE spResetPassword 
    @Username VARCHAR(20),
    @NewPassword VARCHAR(15)
AS
BEGIN
    -- Check if the username exists in the Users table
    IF EXISTS (SELECT * FROM MembersInformation WHERE Username = @Username)
    BEGIN
        -- Update the password for the given username
        UPDATE MembersInformation SET MemberPassword = @NewPassword WHERE Username = @Username;
        PRINT 'Password successfully reset.';
    END
    ELSE
    BEGIN
        -- If the username does not exist, raise an error
        RAISERROR('Username not found.', 16, 1);
    END
END

EXEC spResetPassword 'abaker', 'new_password'


select * from MembersInformation
