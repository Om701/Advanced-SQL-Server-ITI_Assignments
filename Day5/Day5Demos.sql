-----------------------------Window Functions---------------------------------

--1-Aggrigate window functions 
-- Sum , Avg , Min , Max ,Count 

select s.St_Id , s.St_Fname,s.St_Age  , count(s.St_Id) over(partition by s.St_Address ), s.St_Address 
from Student s
where St_Address ='Cairo'

--2-Ranking Window functions

select * , ROW_NUMBER() over (order by st_Age desc) as RN
from Student

select * , Ntile(3) over (order by st_Age desc) as RN
from Student


------------------------------------------------------------


select * 
from (
		select * , Dense_Rank() over (partition by Dept_id order by st_age desc ) as D
		from Student 
		where Dept_id is not null
	) as NewTable
where D <=2



-----------------------------------------------------------------------

select St_Id , St_Fname from 
(
select s.St_Id , S.St_Fname , s.St_Address , c.Crs_Name , sc.Grade , 
       Dense_Rank() over (partition by c.Crs_Name order by sc.Grade  desc) as DN
from Student s , Course c , Stud_Course sc
where s.St_Id = sc.St_Id and c.Crs_Id = sc.Crs_Id
) as newTable
where DN=2


--Value Window Function (lag() , lead() , First_Value() , Last_Value())





--------------------CTE 
--Find Top 3 aged student in each dept
--using sub query
select * from
(
	select * , DENSE_RANK() over ( partition by Dept_id order by st_age desc) DR
	from Student 
	where Dept_Id is not null

	) newTable
where DR <=3 

--using cte

with agedStudent
as
(
	select * , DENSE_RANK() over ( partition by Dept_id order by st_age desc) DR
	from Student 
	where Dept_Id is not null
)
select * from agedStudent
where DR <= 3




create table t
(
id int , 
name varchar(20),
age int
)
insert into t values( 1 , 'Doaa' , 25 ) , ( 1 , 'Nada' , 26 )

with cte 
as 
(
	select * from t
)
delete from cte where id =1


select * from t



create table tttttt
(
id int , 
name varchar(20),
age int
)

------------------------Batch script transaction----------------------------

select * from Student
select * from sgshghg

create table parent (pid int primary key)
go
create table child (cid int foreign key references parent(pid))

insert into parent values(1)
insert into parent values(2)
insert into parent values(3)
insert into parent values(4)

insert into child values(1)
insert into child values(2)
insert into child values(3)
insert into child values(11)

delete from child

begin transaction 
	insert into child values(1)
	insert into child values(2)
	insert into child values(3)
	insert into child values(11)


alter proc kjhfn
as 
 begin try
    insert into child values(1)
	insert into child values(2)
	insert into child values(3)
	insert into child values(11)
	commit
end try
begin catch 
	select 'sjhjk'
end catch 



select * from child

----------------------------------------index----------------------

create table std
(
id int primary key ,
sname varchar(20)
)

create nonclustered index iii
on std(sname)








create table std1
(
id int ,
sname varchar(20)
)

--only one clustered index in table 
-- up to 999 non clustered in table 

select * from std1 where id =1

create clustered index i1
on std1(id)




--------------------------------indexed view---------------------------------
alter view VIndexed
with schemabinding
as 
select s.St_Id ,  St_Fname  , s.St_Address
from dbo.Student s

create unique clustered index IndixedTest
on VIndexed(St_Id )


select * from VIndexed where St_Id = 1