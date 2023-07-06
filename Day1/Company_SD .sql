SELECT e.Dno,d.Dname,e.SSN,e.Superssn
FROM dbo.Departments as d
join dbo.Employee e
on e.Dno = d.Dnum

#2.	Display the name of the departments and the name of the projects under its control.

SELECT d.Dname,p.Pname
FROM dbo.Departments as d
join dbo.Project as p
on p.Dnum = d.Dnum

3.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly.

SELECT e.Fname +' '+e.Lname as 'Full_Name',d.Dnum,e.Salary
FROM dbo.Employee as e
join dbo.Departments as d
on e.Dno = d.Dnum
WHERE d.Dnum = 30 AND e.Salary/12 between 100 and 200

4.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.

SELECT e.Fname+' '+e.Lname as 'Full_Name',w.Hours
FROM dbo.Employee as e
join dbo.Departments as d
on e.Dno = d.Dnum
join dbo.Works_for as w
on w.ESSn = e.SSN 
WHERE w.Hours >= 10

5.	Find the names of the employees who directly supervised with Kamel Mohamed.

SELECT e.Fname +' '+e.Lname as 'Full_Name',s.Fname+' '+s.Lname as 'Full_Name'
FROM dbo.Employee as e
JOIN dbo.Employee as s
ON s.Superssn = e.SSN
WHERE s.Fname+' '+s.Lname ='Kamel Mohamed'

6.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.

SELECT e.Fname+' '+e.Lname as 'Full_Name',p.Pname
FROM dbo.Employee as e 
JOIN dbo.Departments as d
ON d.Dnum = e.Dno
JOIN dbo.Project as p
ON p.Dnum = d.Dnum
ORDER BY p.Pname

7.	For each project located in Cairo City , find the project number,
the controlling department name ,the department manager last name ,address and birthdate

SELECT p.City,p.Pnumber,d.Dname,e.Lname,e.Address,e.Bdate
FROM dbo.Project as p
JOIN dbo.Departments as d
ON p.Dnum = d.Dnum
JOIN dbo.Employee as e
ON e.Superssn = d.MGRSSN
WHERE p.City = 'Cairo'

8.	Display All Data of the mangers

SELECT *
FROM dbo.Employee as e
JOIN dbo.Employee as m
ON e.SSN = m.Superssn

9.	Display All Employees data and the data of their dependents even if they have no dependents

SELECT *
FROM dbo.Employee as e
LEFT JOIN dbo.Dependent as d
ON d.ESSN = e.SSN

select @@VERSION
select @@SERVERNAME
