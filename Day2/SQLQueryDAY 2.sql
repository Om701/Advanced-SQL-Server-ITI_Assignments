1.	Create the following schema and transfer the following tables to it 
a.	Company Schema 
i.	Department table (Programmatically)
ii.	Project table (visually)


CREATE SCHEMA company_schema 

CREATE TABLE company_schema.Department (
Dname nvarchar(50) null,
Dnum int  PRIMARY KEY,
MGRSSN int null,
MGRStart_Date datetime null,
constraint FK_MGRStart_date foreign key(MGRSSN)REFERENCES dbo.Employee(SSN)
)

b.	Human Resource Schema
i.	  Employee table (Programmatically)

CREATE SCHEMA resource_schema

CREATE TABLE resource_schema.Employee(
Fname nvarchar(50) null,
Lname nvarchar(50) null,
SSN int PRIMARY KEY not null,
Bdate datetime null,
Address NVARCHAR(50) NULL,
Sex nvarchar(50) null,
Salary int null,
Superssn int null,
Dno int null,
CONSTRAINT FK_Superssn FOREIGN KEY (Superssn) REFERENCES dbo.employee(SSN),
CONSTRAINT FK_Dnumber FOREIGN KEY (Dno) REFERENCES dbo.Departments(Dnum)
)

Part 1: Use ITI DB

use ITI

1.	Create a view that displays student full name, course name if the student has a grade more than 50.

CREATE VIEW grade_50 AS
SELECT s.St_Fname+' '+s.St_Lname as 'Full_name',c.Crs_Name,sc.Grade
FROM dbo.Student as s
JOIN dbo.Stud_Course as sc
ON sc.St_Id = s.St_Id
JOIN dbo.Course as c
ON sc.Crs_Id = c.Crs_Id
WHERE sc.Grade > 50

SELECT * 
FROM grade_50

2.	Create an Encrypted view that displays manager names and the topics they teach.

CREATE view managers with Encryption AS
SELECT i.Ins_Name as 'Manager_name',d.Dept_Name,t.Top_Name
FROM dbo.Department as d
JOIN dbo.Instructor as i
ON d.Dept_Manager = i.Ins_Id
JOIN dbo.Ins_Course as Ic
ON ic.Ins_Id = I.Ins_Id
join DBO.Course as c
ON ic.Crs_Id = c.Crs_Id
JOIN dbo.Topic as t
ON t.Top_Id = c.Top_Id

drop view encrypted_view_managers_topics

SELECT *
FROM managers

3.	Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
Note: Prevent the users to run the following query Update V1 set st_address=’tanta’ Where st_address=’alex’.

CREATE VIEW V1 AS
SELECT * 
FROM dbo.Student as s
WHERE s.St_Address IN ('Alex','Cairo')

CREATE TRIGGER PreventUpdateOnV1
ON V1
INSTEAD OF UPDATE
AS
BEGIN
  RAISERROR('Update on V1 not allowed',16,1)
  ROLLBACK TRANSACTION
END
4.	Create temporary table [Session based] on Company DB to save employee name and his today task.

use Company_SD
CREATE TEMPORARY TABLE DailyTasks(
employee_name nvarchar(50),
today_task nvarchar(100)
)

Part 3: Use Company DB

USE Company_SD

1.	Fill the Create a view that will display the project name and the number of employees work on it

CREATE VIEW ProjectEmployees AS
SELECT p.Pname,COUNT (E.Fname) as 'number of employees'
FROM dbo.Works_for as w
JOIN dbo.Project as p
ON w.Pno = p.Pnumber
JOIN dbo.Employee as e
ON W.ESSn = E.SSN
GROUP BY p.Pname

2.	Create a view named  “v_count “ that will display the project name and the number of hours for each one

CREATE VIEW V_count AS 
SELECT p.Pname,COUNT(w.Hours) as' hours for project'
FROM dbo.Project as p
JOIN dbo.Works_for as w
ON w.Pno = p.Pnumber
GROUP BY p.Pname

3.	Create a view named   “v_D30” that will display employee number, project number, hours of the projects in department 300.

CREATE VIEW V_D30 AS
SELECT p.Pnumber,COUNT(e.Fname)as'employee number',COUNT(w.Hours)as'hours of the project'
FROM Works_for as w
JOIN Project as p
ON p.Pnumber = w.Pno
JOIN Employee as e
ON w.ESSn = e.SSN
WHERE p.Pnumber = 300
GROUP BY p.Pnumber

4.	Create a view named ” v_project_500” that will display the emp no. for the project 500, use the previously created view  “v_D30”

CREATE VIEW v_project_500 AS
SELECT p.Pnumber,COUNT(e.Fname)as'employee number',COUNT(w.Hours)as'hours of the project'
FROM Works_for as w
JOIN Project as p
ON p.Pnumber = w.Pno
JOIN Employee as e
ON w.ESSn = e.SSN
WHERE p.Pnumber = 500
GROUP BY p.Pnumber

5.	Delete the views  “v_D30” and “v_count”

DROP VIEW V_D30,V_count

6.	Display the project name that contains the letter “c” Use the previous view created in Q#1

SELECT Project.Pname
FROM company_schema.project_table
WHERE Project.Pname Like'%c%'

7.	add new column Enter_Date in Works_for table and insert data in it then create view name
“v_2021_check” that will display employee no., which must be from the first of January and the last of December 2021.
this view will be used to insert data so make sure that the coming new data matchs the condition.A

ALTER TABLE dbo.Works_for ADD Enter_Date date
insert INTO Works_for VALUES (223344,700,100,'2021-01-01')

CREATE VIEW v_2021_check AS 
SELECT e.Fname+' '+e.Lname as 'Full_Name' ,w.ESSn,w.Enter_Date
FROM Works_for AS W
JOIN Employee AS e
ON w.ESSn = e.SSN
WHERE w.Enter_Date BETWEEN '2021-01-01' AND '2021-12-31'

8.	Create Rule for Salary that is less than 2000 using rule.

CREATE RULE rule_Salary_Less_Than_2000
AS
@salary <2000

9.	Create a new user defined data type named loc with the following Criteria:
•	#nchar(2) 
•	#default: NY 
•	#create a rule for this Data type :values in (NY,DS,KW)) and associate it to the location column

CREATE TYPE loc FROM nchar(2)
CREATE RULE loc_check
AS
	@loc IN ('NY','DS','KW')

ALTER TABLE employee ADD location loc  CONSTRAINT CHK_LOC DEFAULT 'NY' WITH VALUES

10.	Create New table Named newStudent, and use the new UDD (user defined data type) on it.
a.	Make ID column and don’t make it identity.

CREATE TABLE newstudent(
ID int NOT NULL,
name varchar(50),
location loc
)