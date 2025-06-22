-- DDL:

create table employee (
	employeeSsn int,
	employeeDoB date,
	employeeGender varchar(10),
	employeeFname varchar(20),
	employeeLname varchar(20),
	supervisorId int,
	departmentNumber int,
	primary key (employeeSsn),
	foreign key (supervisorId) references employee(employeeSsn)
);


create table department (
	departmentNumber int,
	employeeSsn int,
	departmentName varchar(50),
	hiringDate date,
	primary key (departmentNumber),
	foreign key (employeeSsn) references employee(employeeSsn) 
);


create table departmentLocations (
	departmentNumber int,
	locations varchar(50),
	primary key (locations),
	foreign key (departmentNumber) references department(departmentNumber)
);


create table dependents (
	employeeSsn int,
	dependentName varchar(20),
	dependentGender varchar(10),
	dependentDoB date,
	primary key (dependentName),
	foreign key (employeeSsn) references employee (employeeSsn)
);


create table projects (
	projectNumber int,
	projectName varchar(50),
	locations varchar(50),
	city varchar(30),
	departmentNumber int,
	primary key (projectNumber),
	foreign key (departmentNumber) references department(departmentNumber)
);


create table work (
	employeeSsn int,
	projectNumber int,
	work varchar(50),
	primary key (work),
	foreign key (employeeSsn) references employee(employeeSsn),
	foreign key (projectNumber) references projects(projectNumber)
);


-- DML:

-- Employee Table DML:
INSERT INTO employee (employeeSsn, employeeDoB, employeeGender, employeeFname, employeeLname, supervisorId, departmentNumber)
VALUES
(1002, '1990-07-22', 'Female', 'Fatima', 'Al-Zakwani', 1001, 1),
(1003, '1985-03-18', 'Male', 'Salim', 'Al-Balushi', 1001, 2),
(1004, '1995-11-30', 'Female', 'Aisha', 'Al-Harthy', 1002, 1),
(1005, '1992-01-12', 'Male', 'Nasser', 'Al-Hinai', 1003, 2),
(1006, '1992-01-12', 'Male', 'Majid', 'Al-Hinai', 1004, 5);


SELECT * FROM employee;

UPDATE employee
SET employeeFname = 'Khalid', employeeLname = 'Al-Ramadhani'
WHERE employeeSsn = 1001

SELECT * FROM employee;

DELETE FROM employee
WHERE employeeFname = 'Ahmed'



-- Department Table DML:
INSERT INTO department (departmentNumber, employeeSsn, departmentName, hiringDate)
VALUES
(10, null, 'AL MADENA', '1992-01-12'),
(50, null, 'AL HAMRA', '1992-01-12'),
(30, null, 'AL RAMIZ', '1992-01-12'),
(19, null, 'AL KANZ', '1992-01-12'),
(20, null, 'AL RAWABI', '1992-01-12');

SELECT * FROM department

UPDATE department
SET departmentName = 'AL-KHADRA',  hiringDate = '2025-01-22'
WHERE departmentName = 'AL MADINA'

SELECT * FROM department

DELETE FROM department
WHERE departmentName = 'AL-KHADRA'



-- Department locations Table DML:
INSERT INTO departmentLocations(departmentNumber, locations)
VALUES
(10, 'DUBAI'),
(19, 'MABELLA 8'),
(50, 'MABELLA 7');


SELECT * FROM departmentLocations

UPDATE departmentLocations
SET locations = 'MAWALEH'
WHERE departmentNumber = 20

SELECT * FROM departmentLocations

DELETE FROM departmentLocations
WHERE locations = 'MAWALEH'



-- Dependents Table DML:
INSERT INTO dependents(employeeSsn, dependentName, dependentGender, dependentDoB)
VALUES
(1002, 'Ahmed', 'Male', '1990-07-22'),
(1003, 'Fatma','Female', '1985-03-18'),
(1004, 'Anisa', 'Female', '1995-11-30'),
(1005, 'Mohammed', 'Male','1992-01-12'),
(1006, 'Abdulrahman', 'Male', '1992-01-12');


SELECT * FROM dependents

UPDATE dependents
SET dependentName = 'Nadir'
WHERE employeeSsn = 1002

SELECT * FROM dependents

DELETE FROM dependents
WHERE employeeSsn = 1004


-- Projects Table DML:
INSERT INTO projects(projectNumber, projectName, locations, city, departmentNumber)
VALUES
--(49926, 'Mabella City', 'Muscat', 'Mabella', 70),
(49926, 'Khoud City', 'Muscat', 'Khoud', 20),
(499267, 'Muscat City', 'Muscat', 'Khoud', 30),
(499298, 'Seeb City', 'Muscat', 'Seeb', 19),
(499297, 'Mawaleh City', 'Muscat', 'Mawaleh', 50),
(499289, 'Bowshar City', 'Muscat', 'Bowshar', 10);


SELECT * FROM projects

UPDATE projects
SET projectName = 'Alam City'
WHERE projectNumber = 49924

SELECT * FROM projects

DELETE FROM projects
WHERE projectNumber = 49924



-- Work Table DML:
INSERT INTO work(employeeSsn, projectNumber, work)
VALUES
(1002, 499267, 'HR'),
(1003, 499298, 'Marketing'),
(1004, 499297, 'Sales'),
(1005, 499289, 'IT'),
(1006, 49926, 'Help Desk');


SELECT * FROM work

UPDATE work
SET work = 'CS'
WHERE projectNumber = 499267

SELECT * FROM work

DELETE FROM work
WHERE projectNumber = 499267