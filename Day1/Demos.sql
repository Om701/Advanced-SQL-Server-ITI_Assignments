---------------------------Cross join---------------------------------

select * from Student
Select * from Department

--Cross join (Standered)
select [St_Fname] , [Dept_Name]
from [dbo].[Student] , [dbo].[Department]

--- Cross join (T Sql Syntax)
select [St_Fname] , [Dept_Name]
from [dbo].[Student] cross join [dbo].[Department]




--------------------------Inner join=Equi joins------------------------
--Find Student names and their Departments name

select s.St_Fname , d.Dept_Name
from Student s , Department d
where d.Dept_Id = s.Dept_Id

select s.St_Fname , d.Dept_Name
from Student s inner join Department d
on d.Dept_Id = s.Dept_Id






--Find Student names and their Departments name and Dept_Id
select s.St_Fname , d.Dept_Name , d.Dept_Id
from Student s , Department d
where d.Dept_Id = s.Dept_Id





--Find Students Name and department info

select s.St_Fname , d.*
from Student s , Department d
where d.Dept_Id = s.Dept_Id






--Find Students name and thier Dept_Name who live in cairo

select s.St_Fname , d.Dept_Name  , s.St_Address
from Student s , Department d
where d.Dept_Id = s.Dept_Id and s.St_Address = 'cairo'








-----------------------Left Outer join------------------------
--Find Student names and thier department even they have 
--department or not 


select s.St_Fname , d.Dept_Name
from Student s left outer join Department d
on d.Dept_Id = s.Dept_Id




---------------------Right Outer join----------------------
--Find student names and department names even department
--has students or not


select s.St_Fname , d.Dept_Name
from Student s Right outer join Department d
on d.Dept_Id = s.Dept_Id


---------Full
select s.St_Fname , d.Dept_Name
from Student s Full outer join Department d
on d.Dept_Id = s.Dept_Id








--------------------Self Join------------------------------
--Find Student name and their leaders name

select S.St_Fname StdName , L.St_Fname  LedName
from Student S , Student L
where L.St_Id = S.St_super




----Find Student name and their leaders Information
select S.St_Fname StdName , L.*
from Student S , Student L
where L.St_Id = S.St_super






--Find Student names and their courses and course grades

select s.St_Fname , c.Crs_Name , sc.Grade
from Student s , Stud_Course sc , Course c
where s.St_Id = sc.St_Id and c.Crs_Id = sc.Crs_Id







--another way using microsoft syntax
select s.St_Fname , c.Crs_Name , sc.Grade
from Student s inner join Stud_Course sc 
on s.St_Id = sc.St_Id 
inner join Course c
on c.Crs_Id = sc.Crs_Id



--Find Student names and Department name 
--and their courses and course grades








----------------------------Joins with DML----------------------------
--Joins with Update
--Increase grade 10 marks for alex students
update Stud_Course
set Grade +=10
from Student s , Stud_Course sc 
where s.St_Id = sc.St_Id and s.St_Address='alex'








--------------------------Rewrite Queries----------------
--Joins with Insert
create table TopStudent
( Id int , 
Std_Name varchar(20),
Grade int 
)

insert into TopStudent(Id , Grade)

select s.St_Id , sc.Grade
from Student s , Stud_Course sc
where s.St_Id = sc.St_Id and Grade >80

select * from TopStudent







--Joins with Delete 

delete s
from Student s , Stud_Course sc 
where s.St_Id = sc.St_Id and sc.Grade <75

----sub query 
--In select (1 , 15) 

select St_Id , (select count(St_Id) from Student) as Total
from Student 

select * from 
(
select St_Fname+' ' +St_Lname as fullName , St_Age 
from Student 
) newTable
where  fullName = 'ahmed hassan'


--where 

select * 
from Student 
having st_age < avg(St_Age) 


----Check 
select Dept_Name
from Department
where Dept_Id  not in (
select distinct s.Dept_Id
from Student s
where Dept_Id is not null
)


-------------------------Union family ------
--union all , union , intersect , except

select s.St_Fname 
from Student s
except 
select i.Ins_Name
from Instructor i

select s.St_Fname 
from Student s
union 
select i.Ins_Name
from Instructor i

select s.St_Fname 
from Student s
intersect 
select i.Ins_Name
from Instructor i