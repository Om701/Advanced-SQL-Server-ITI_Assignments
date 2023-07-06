--Reduce network traffic 
--Sequrity
--Take parameter 
--Icreatce per
--SErver Error
--Hide Bussiness Rules

------------------------------Types SP 
--1- Built in sp 


sp_bindrule 
sp_unbindrule 
sp_helpconstraint  'Student'
sp_helptext 

--2 user defined sp
create proc GetStd
as
    select * from Student

--call proc 
GetStd

execute GetStd

--take add return std inf0
create proc GetstdByAddress @add varchar(20)
as
  select s.St_Id , s.St_Fname , s.St_Address
  from Student s
  where s.St_Address = @add


  GetstdByAddress 'cairo'

  ------------Stored DML
  create proc InsertStd @id int , @name varchar(30)
  as 
     begin try 

	    insert into Student (St_Id , St_Fname ) values (@id , @name)

	 end try
	 begin catch
	   select 'Dublicat id'
	 end catch

InsertStd 66 ,'Ahmed'



----
create proc SumXY @x int =100 , @y int =100
as
  select @x+@y

SumXY 3 , 7

SumXY @y =9 , @x=8

SumXY 6



-----
alter proc GetStdAges @age1 int , @age2 int 
as
   select St_Id , St_Fname
   from Student
   where St_Age between @age1 and @age2


GetStdAges 20 , 25



declare @t table (Id int , Sname varchar(30))
insert into @t
execute GetStdAges 20 , 25
select * from @t



----------Stored with return

create proc GetStdAge @id int 
as 
   declare @age int 

   select @age=s.St_Age
   from Student s
   where s.St_Id = @id 

return @age


declare @age int 
execute @age = GetStdAge 5
select @age




create proc GetStdName @id int 
as 
   declare @name varchar(30) 

   select @name=s.St_Fname
   from Student s
   where s.St_Id = @id 

return @name

GetStdName 5




--Input 
--output 

alter proc GetStdName @id int , @name varchar(20) output , @age int output 
with encryption
as 
   select @name=s.St_Fname , @age = s.St_Age 
   from Student s
   where s.St_Id = @id 


declare @n varchar(20) , @a int 
execute GetStdName 6 ,  @n output , @a output 
select @n , @a


sp_helptext 'GetStdName'

alter proc Test @SupId int , @id int 
as 
  update studt set [St_super]=@SupId where st_id = @id

Test 1,1



-------------------------------Tigger 
--Can't call
--Can't send param


create trigger t1
on student
after insert -- instead of , for ==after
as  
   select 'New student Added'

--test
insert into student (St_Id , St_Fname) values (16 , 'Ali')


--------------------------------------------
create trigger t2
on student
after update
as 
  select getdate()

--test
update Student set St_Age+=1 


-------------------------------
create trigger t3
on student
instead of delete
as 
  select 'Not allowed for user = '+SUSER_NAME()

delete from Student  where St_Id=16

select * from Student




----------------
alter trigger HR.t4
on HR.[Department]
instead of insert ,update , delete
as
  select 'Select only allowd'

 update HR.Department 
    set Dept_Name='Cloud'
	where Dept_Id = 70

create schema HR 
go 
alter schema HR transfer Department


alter trigger HR.t5
on HR.[Department]
for insert
as
  select 'Hola'





create trigger t6
on Student 
after update
 as 
   if UPDATE(St_fname)
      select 'hi'

update Student set St_Lname ='test' where St_Id=16


----------------------------------------------------------------------------------

inserted 
deleted

delete -->table deleted contains deleted date 
       --> table inserted empty

insert --> table inserted contains insered data 
       --> deleted Empty

update -->inserted contian Updated data
       --> deleted contains data befor update



alter trigger t7
on course
after insert 
as 
  select [Crs_Name] from inserted
  select * from deleted


  insert into Course( [Crs_Id],[Crs_Name]) values (1250 , 'Test')



  ---------------------------------------------------------------------------
  alter trigger t8
  on course
  after delete
  as 
    if (format(getdate() , 'dddd')='thursday')
	 begin 
	     select 'not allowed to delete today'
		 insert into Course
		 select * from deleted
      end 

delete from Course where Crs_Id =1250


---------------------------------------Audit Tables----------------
create table history
(
name varchar(50) ,
date date ,
OldId int ,
_NewId int
)

create trigger t9
on Topic
after update 
as 
   if update(Top_id)
      begin
	        declare @old int , @new int
			select @new =Top_id from inserted
			select @old =Top_id from deleted
			insert into history values( SUSER_NAME() , getdate() ,@old , @new)
	  end


	  update Topic set Top_Id =444 where Top_Id=6
select * from history


----Runtime trigger 



delete from [Departments]
output getdate() , deleted.Dname 
where Dnum =40


update Departments
set Dname = 'Dtest'
output SUSER_NAME() , inserted.Dname , deleted.Dname
where Dnum=50


insert into Departments(Dnum , Dname) 
output 'welcome'
values(60 , 'jhdgcjhcb')

-------
drop trigger t2





create trigger t15
on database 
after drop_table
as
 select 'not allowed'
 rollback


 create table e (id int)

 drop table e