create table exam
(
id int, 
ques varchar(30)
)

--Local tables --session table 
create table #exam
(
id int, 
ques varchar(30)
)

insert into #exam values(1 , 'tttt')
select * from #exam

--global tables 
create table ##exam
(
id int, 
ques varchar(30)
)
insert into ##exam values(1 , 'tttt')
select * from ##exam


-----Order by

select s.St_Id , s.St_Fname , s.St_Lname
from Student s
order by 3

------Top 
select top(3) Salary
from Instructor
order by Salary desc

--
select top 10 percent s.St_Age
from Student s
order by s.St_Age desc

----------
declare @t int = 50
select @t =50000
select @t

declare @t int = 50
set @t =88
select @t

declare @age int = (select AVG(s.St_Age) from Student s)

select @age






declare @age int = (select s.St_Age from Student s where St_id =4)

select @age as 'jjjjj'

select s.St_Age from Student s where St_Address ='alex'


decLARE @id int =( select s.St_Id from Student s where s.St_Id =2) , 
        @name varchar(20) =( select s.St_Fname from Student s where s.St_Id =2)

select @id , @name

decLARE @id int ,@name varchar(20)

select @id= s.St_Id , @name =s.St_Fname
from Student s
where s.St_Id =2

select @id , @name 


declare @name varchar(20) ='Mohamed', @id int =7  , @dept int

update Student
set St_Fname = @name , @dept = Dept_id
where St_Id = @id

select @dept as 'Dept'


---table var
declare @t table (col1 int , col2 varchar(20))

insert into @t
select s.St_Id , s.St_Fname
from Student s

select * from @t

declare @T int = 6
select top(@T) *
from Instructor 
order by Salary desc 

------------dynamic Query

declare @x varchar(30) ='[Ins_Degree]' , @y varchar(50) = '[dbo].[Instructor]'
execute ('select '+@x+' from '+@y+' where [Ins_Id] = 1' )



-----------------------------Globle var----------------------
select @@SERVERNAME
select @@VERSION

update Student 
set St_Age+=1
select @@ROWCOUNT


select * from rtjgi
go
select @@ERROR 

create table t444
(
id int identity (1 , 4),
name varchar(10)
)
insert into t444 values('DDDD')
select * from t444
select @@IDENTITY

-------------------------------Contarl flow ---------------------------
--if , else 
--begin end
--if exists , if not exists
--while , continue , break 
--case
--iif
--waitfor--
--Choose 
------------------------IF , else-----------------------------
declare @r varchar(20) 
update Student
set St_Age+=1
where St_Address ='alex'

select @r= @@ROWCOUNT

if @r > 0 
     print @r+' rows affected'

else
    begin 
	  print ' No rows affected'
	end 
-------------------------------------------------------------
if exists (select * from sys.tables where name = 'rdgxrtg')
    select 'Table exicted'
else
 create table rdgxrtg(id int )


 -----While 

 declare @x int = 10 
 while @x <20 
     begin
	      set @x+=1 
		  if(@x =14)
		    continue
          if(@x = 16)
		    break
		  select @x  --11 , 12 , 13 , 15
	 end 

----Case--
case
   when con1 then Res
   when con2 then 
   else  res
end


declare @id int = 2 , @age int

select @age=s.St_Age 
from Student s
where St_Id = @id

select case 
           when @age >20 and @age <=28 then 'you can apply'
		   when @age >25 then 'Sorry you can not apply'
           else 'not allowed'
       end



----iif(condition , value if condition true , 'value id cond false)

select s.St_Id , s.St_Fname,s.St_Age , iif(s.St_Age >30 , 'not allowed' , 'allowed')
from Student s 
-----------------------
select s.St_Fname , isnull(s.St_Lname , s.St_Address)
from Student s

select s.St_Fname , Coalesce(s.St_Lname , s.St_Address , 'No Data')
from Student s

select nullif('t' , 'tjhvjh')

select len(s.St_Fname )
from Student s

select power(Salary, 2)
from Instructor


select convert( varchar(20) , getdate() , 108)

select format(getdate() , 'dddd/MMMM:yyyy')

----------------------Scalar-----------------
--String GetStudentName (int id){}

create function GetStudentName (@id int )
returns varchar(50)
	begin 
		declare @name varchar(50)
		select @name =s.St_Fname
		from Student s
		where s.St_Id = @id
		return @name
	end

select dbo.GetStudentName(5)

------------------------------inline Function----------
--function take dept_id retrun ins_name , annualSalary

create function GetInsInf (@did int)
returns table 
as
return 
		( select i.Ins_Name , i.Salary * 12 as annSalary
		   from Instructor i
		   where i.Dept_Id = @did
		)

select * from GetInsInf(10)


-----------------Multi
--table GetStudentData (@fromat varchar(20))

create function GetStudentsData(@format varchar(20))
returns @tab table (id int , ename varchar(50))
as
  begin
       if(@format='first')
			insert into @tab
			select s.St_Id , s.St_Fname
			from Student s
       else if (@format='last')
	        insert into @tab
			select s.St_Id , s.St_Lname
			from Student s
       else if (@format='full')
	        insert into @tab
			select s.St_Id ,s.St_Fname+' '+s.St_Lname
			from Student s
   return 
  end

select * from dbo.GetStudentsData('last')