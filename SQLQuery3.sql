create database CompanyDB

use CompanyDB

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
	work varchar(10),
	primary key (work),
	foreign key (employeeSsn) references employee(employeeSsn),
	foreign key (projectNumber) references projects(projectNumber)
);