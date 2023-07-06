#1.	Display instructor Name and Department Name 
#Note: display all the instructors if they are attached to a department or not

SELECT i.Ins_Name,d.Dept_Name
FROM dbo.Instructor as i
left JOIN dbo.Department as d
on d.Dept_Id = i.Dept_Id

#2.	Display student full name and the name of the course he is taking
#For only courses which have a grade  

SELECT s.St_Fname+' '+s.St_Lname as "full name",c.Crs_Name,sc.Grade
FROM dbo.Student as s
join dbo.Stud_Course as sc
on sc.St_Id=s.St_Id
join dbo.Course as c
on sc.Crs_Id=c.Crs_Id
where sc.Grade is not null

#3.	Display number of courses for each topic name

SELECT COUNT(c.Crs_Name) as "number of courses" ,t.Top_Name
FROM dbo.Course as c
JOIN dbo.Topic as t
on c.Top_Id = t.Top_Id
GROUP BY t.Top_Name

#4.	Display max and min salary for instructors

SELECT MAX(Salary) AS "MAX_Salary", MIN(Salary) AS "MIN_Salary"
FROM dbo.Instructor

#5.	Display instructors who have salaries less than the average salary of all instructors.

SELECT Ins_Name,Salary 
FROM dbo.Instructor 
WHERE Salary <( SELECT AVG(salary) FROM dbo.Instructor)

#6.	Display the Department name that contains the instructor who receives the minimum salary.

SELECT d.Dept_Name, i.Ins_Name, MIN(i.Salary) as"minimum salary"
FROM dbo.Department AS d
JOIN dbo.Instructor AS i ON d.Dept_Id = i.Dept_Id
GROUP BY d.Dept_Name, i.Ins_Name

