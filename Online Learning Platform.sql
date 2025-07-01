create database onlineLearningPlatform

CREATE TABLE Instructors ( 
    InstructorID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
);



CREATE TABLE Categories ( 
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(50) 
);




CREATE TABLE Courses ( 
    CourseID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    InstructorID INT, 
    CategoryID INT, 
    Price DECIMAL(6,2), 
    PublishDate DATE, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
);

SELECT * FROM Courses

CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
);

SELECT * FROM Students


CREATE TABLE Enrollments ( 
    EnrollmentID INT PRIMARY KEY, 
    StudentID INT, 
    CourseID INT, 
    EnrollDate DATE, 
    CompletionPercent INT, 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
);



SELECT 
    S.StudentID,
    S.FullName AS StudentName,
    S.Email AS StudentEmail,
    S.JoinDate AS StudentJoinDate,

    E.EnrollmentID,
    E.EnrollDate,
    E.CompletionPercent,
    E.Rating,

    C.CourseID,
    C.Title AS CourseTitle,
    C.Price,
    C.PublishDate AS CoursePublishDate,

    I.InstructorID,
    I.FullName AS InstructorName,
    I.Email AS InstructorEmail,
    I.JoinDate AS InstructorJoinDate,

    Cat.CategoryID,
    Cat.CategoryName

FROM Enrollments E
INNER JOIN Students S ON E.StudentID = S.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID
INNER JOIN Instructors I ON C.InstructorID = I.InstructorID
INNER JOIN Categories Cat ON C.CategoryID = Cat.CategoryID;



-- Instructors 
INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');

-- Categories 
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business');


-- Courses 
INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01');


-- Students 
INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10');


-- Enrollments 
INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3);


-- Step 3:
-- 1. What is the difference between GROUP BY and ORDER BY?
-- The GROUP BY, we use it when we want to group rows that have same value (Type) in specified column (Column Name) and when want to use functions.
-- The ORDER BY, we use it when we want to sort a the column Decs or Acen or from large numbers to smallest.

-- 2. Why do we use HAVING instead of WHERE when filtering aggregate results?
-- We use HAVING to filter the rows before grouping it.

-- 3. What are common beginner mistakes when writing aggregation queries?
-- The order of writing the command like when we write the GROUP BY and HAVING.

-- 4. When would you use COUNT(DISTINCT ...), AVG(...), and SUM(...) together? 
-- Together, we utilize them to determine the average value of each unique item, count them, and compute the total in a single query.

-- 5. How does GROUP BY affect query performance, and how can indexes help?
--Using indexes on the grouped columns can assist speed up query performance by facilitating faster data retrieval and sorting, but GROUP BY can slow down query performance on huge data since it must scan and group many rows.


-- Step 4:

-- Beginner Level:

SELECT COUNT(StudentID) [Count total number of students]
FROM Students

SELECT COUNT(EnrollmentID) [Count total number of enrollments]
FROM Enrollments

SELECT AVG(Rating) [average rating of each course]
FROM Enrollments
GROUP BY CourseID

SELECT COUNT(CourseID) [Total number of courses per instructor]
FROM Courses
GROUP BY InstructorID

SELECT COUNT(CourseID) [Number of courses in each category]
FROM Courses
GROUP BY CategoryID

SELECT COUNT(StudentID) [Number of students enrolled in each course]
FROM Enrollments
GROUP BY CourseID

SELECT AVG(Price) [Average course price per category]
FROM Courses
GROUP BY CategoryID

SELECT MAX(Price) [Maximum course price]
FROM Courses

SELECT MIN(Rating) [MIN RATING], MAX(Rating) [MAX RATING], AVG(Rating) [AVG RATING]
FROM Enrollments

SELECT COUNT(StudentID)
FROM Enrollments
WHERE Rating = 5



-- Intermediate LeveL:

SELECT AVG(CompletionPercent) [Average completion percent per course]
FROM Enrollments
GROUP BY CourseID

SELECT StudentID, COUNT(CourseID) [NumberOfCourses]
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(CourseID) > 1;

SELECT Title, Price * COUNT(EnrollmentID) AS Revenue
FROM Courses, Enrollments
WHERE Courses.CourseID = Enrollments.CourseID
GROUP BY Title, Price;

SELECT I.FullName [InstructorName], COUNT(DISTINCT E.StudentID) [DistinctStudentCount]
FROM Instructors I INNER JOIN Courses C ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY I.FullName;


SELECT CA.CategoryName, COUNT(E.EnrollmentID) * 1.0 / COUNT(DISTINCT C.CourseID) AS AvgEnrollmentsPerCourse
FROM Categories CA INNER JOIN Courses C ON CA.CategoryID = C.CategoryID
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY CA.CategoryName;


SELECT I.FullName [InstructorName], ROUND(AVG(E.Rating), 2) [AvgRating]
FROM Instructors I INNER JOIN Courses C ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY I.FullName;


SELECT TOP 3 C.Title [CourseTitle], COUNT(E.EnrollmentID) [EnrollmentCount]
FROM Courses C INNER JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.Title

SELECT AVG(DATEDIFF(DAY, E.EnrollDate, '2023-05-01')) [AvgDaysToComplete]
FROM Enrollments E
WHERE E.CompletionPercent = 100;