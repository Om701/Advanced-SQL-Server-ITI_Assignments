---------------------------------------------------------------------------------------

--XML
--http://msdn.microsoft.com/en-us/library/ms190922.aspx
--The FOR XML clause is central to XML data retrieval in SQL Server 2005. This clause
--instructs the SQL Server query engine to return the data as an XML stream rather than
--as a rowset

--The FOR XML clause has four modes to control XML Formate:
--1)RAW
--Transforms each row in the result set into an XML element


select * from Student
for xml raw('Student') , Elements ,Root('Students')







--RAW mode queries can include aggregated columns and GROUP BY clauses.
--Find number of students per address
select St_Address,COUNT(st_id) NumOfStd from Student
where St_Address is not null
group by St_Address
for xml raw('Student'),ELEMENTS,ROOT('STUDENTS')

--u can only present data as elemets or attributes
--using For XML Path is the solution for representing mixed "elemets and attributes"
--for each separate row

--JOIN problem



select Topic.Top_Id,Top_Name,Crs_Id,Crs_Name 
from Topic ,Course 
where Topic.Top_Id=Course.Top_Id
for xml raw ('topic'),ELEMENTS

--should be nested topic includes courses
--using For XML Auto is the solution for this problem

--2)AUTO
--http://msdn.microsoft.com/en-us/library/ms188273.aspx
--Returns query results in a simple, nested XML tree. Each table in the FROM clause 
--for which at least one column is listed in the SELECT clause is represented as an XML 
--element. The columns listed in the SELECT clause are mapped to the appropriate element attributes.
select Topic.Top_Id,Top_Name,Crs_Id,Crs_Name 
from Topic ,Course 
where topic.Top_Id=Course.Top_Id
for xml auto,elements

--Benifets of For XML Auto
--1)Each row returned by the query is represented by an XML element with the same name
--2)the child elements are collated correctly with their parent
--3)Each column in the result set is represented by an attribute, unless the ELEMENTS option is specified
	
	
	
	select Topic.Top_Id,Topic.Top_Name,Crs_Id,Crs_Name 
	from Course ,Topic 
	where Topic.Top_Id=Course.Top_Id
	for xml auto,elements,root('Courses_Inside_Topics')
--4)Aggregated columns and GROUP BY clauses are not supported in AUTO mode
--queries (although you use an AUTO mode query to retrieve aggregated data
--from a view that uses a GROUP BY clause).



--3)PATH
--Provides a simpler way to mix elements and attributes, and to 
--introduce additional nesting for representing complex properties.
--Easier than Explicit mode

select st_id "@StudId",
	   St_Fname "StudentName/FirstName",
	   St_Lname "StudentName/LastName",
	   St_Address "Address"	
from Student
for xml path ('Student')

select st_id "@StudentID",
	   St_Fname "StudentName/@FirstName",
	   St_Lname "StudentName/@LastName",
	   St_Address "Address"	
from Student
for xml path('Student'),root('Students')

select Topic.Top_Id "@TopicID",
	  Topic.Top_Name "Name",
	   course.Crs_Id "Course/CourseID",
	   course.Crs_Name "Course/CourseName" 
from Course,Topic 
where topic.Top_Id=Course.Top_Id
for xml path
--The FOR XML clause has four modes and some options:
--1)ELEMENTS

--2)BINARY BASE64 option 
--Returns binary data fields, such as images, as base-64-encoded binary.
use Northwind 
go
select * from Categories
for xml raw('Catigory'),ELEMENTS,BINARY BASE64


-------------------------------------------------------------------------------------
--XML Shredding
--The process of transforming XML data to a rowset is known as “shredding” the XML data.

--Processing XML data as a rowset involves the following five steps:
--1)create proc processtree
declare @docs xml =
				'<Students>
				 <Student StudentID="1">
					<StudentName>
						<First>AHMED</First>
						<Second>ALI</Second>
					</StudentName>
					<Address>CAIRO</Address>
				</Student>
				<Student StudentID="2">
					<StudentName>
						<First>OMAR</First>
						<Second>SAAD</Second>
					</StudentName>
					<Address>ALEX</Address>
				</Student>
				</Students>'

--2)declare document handle
declare @hdocs int

--3)create memory tree
Exec sp_xml_preparedocument @hdocs output, @docs

--4)process document 'read tree from memory'
--OPENXML Creates Result set from XML Document
--create table NewStd as
--(
select * into NewTable
FROM OPENXML (@hdocs, '//Student')  --levels  XPATH Code
WITH (StudentID int '@StudentID',
	  [Address] varchar(10) 'Address', 
	  StudentFirst varchar(10) 'StudentName/First',
	  StudentSECOND varchar(10) 'StudentName/Second'
	  )
--)

	  

--5)remove memory tree
Exec sp_xml_removedocument @hdocs


select * from NewTable