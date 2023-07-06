-----------------------Functions 
--Scaler 
-- 
create function GetInsSalary (@InsId int)
returns money
   begin
   
   declare @Sal money
      select @Sal = i.Salary
	  from Instructor i
	  where i.Ins_Id = @InsId
  return @Sal
   end 
--Execute Scaler 
select dbo.GetInsSalary(6)



create function StdMessage (@StdId int )
returns varchar(100)
  begin 
     declare @Msg varchar(100) , @Fname varchar(20) , @Lname varchar(20) 
	 
	 select @Fname = s.St_Fname , @Lname= s.St_Lname
	 from Student s
	 where s.St_Id =8

	 set @Msg = 
	 (
	 select case 
	       when @Fname is null and @Lname is null then 'First name & last name are null'
		   when @Fname is not null and @Lname is null then 'last name is null'
		   when @Fname is null and @Lname is not null then 'First name is null'
		   else 'both are not null'
		   end
		)
		return @Msg
  end

  select dbo.StdMessage(14)


--Inline function -Function body Includes Select Only
create function CouseTopic ( @TopicId int )
returns table
as
return 
(

select t.Top_Id , t.Top_Name , c.Crs_Name
from Course c , Topic t
where t.Top_Id = c.Top_Id and t.Top_Id = @TopicId
)


select * from CouseTopic (3)
--------------------------------Multi Statment 

create Function FormatRsult (@format varchar(20))
returns @tab table (id int , name varchar(100))
as
begin 


end 

return 
end 


-------------------------------------------Index-----------------------------------------
--Clustered index on pk by default 


--non clustered index 999 --2016 


--1024 







---------------------------------
declare c1 cursor
for select s.St_Id , s.St_Fname
     from Student s

for read only    --update 

declare @id int , @name varchar(50)

open c1
fetch c1 into @id , @name 

while @@fetch_status=0
   begin 
        select @id , @name 
		fetch c1 into @id , @name 
   end 
close c1
deallocate c1


-----------------------------------------------------
allNames = [ahmed , mona , amr ,      ]

declare c1 cursor 
for select s.St_Fname
    from Student s
for read only

declare @name varchar(20) , @AllNames varchar(300)

open c1 
fetch c1 into @name 
while @@FETCH_STATUS=0
	begin 
		 set @AllNames = concat(@AllNames , ',' , @name)
		 fetch c1 into @name 
	end 
select @AllNames
close c1
deallocate c1


declare c1 cursor 
for 
    select i.Salary
    from Instructor i
for update 
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS =0
    begin 
	     if @sal >=3000
		   update Instructor set Salary = @sal+@sal*0.2
		   where current of c1 

		else
		  update Instructor set Salary = @sal+@sal*0.1
		  where current of c1 

    fetch c1 into @sal
	end 
	close c1 
	deallocate c1



	select * from Student



declare c1 cursor 
for select s.St_Fname
    from Student s
	where St_Address ='cairo'
for read only

declare @name varchar(20) , @counter int =0
open c1 
fetch c1 into @name 
while @@FETCH_STATUS=0
	begin 
		if(@name ='ahmed')
		  begin 
		    fetch c1 into @name 
			if(@name ='amr')
			set @counter+=1
		  end
	fetch c1 into @name 
	end 
select @counter
close c1
deallocate c1







