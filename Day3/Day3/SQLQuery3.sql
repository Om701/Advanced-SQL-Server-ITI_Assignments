Use ITI DB

USE ITI

1.	 Create a scalar function that takes date and returns Month name of that date.

CREATE FUNCTION get_month_name
(
	@inputDate Date
)
RETURNS varchar(20)
AS
BEGIN
	DECLARE @month_name varchar(20)
	SET @month_name = FORMAT(@inputDate,'MMMM')
	RETURN @month_name
END

SELECT dbo.get_month_name ('2023-05-02') 

Create a multi-statements table-valued function that takes 2 integers and returns the values between them.

CREATE FUNCTION GetValuesBetween(
@start_number int,
@end_number int
)
RETURNS @result_table table(value int)
AS
BEGIN
	DECLARE @current_number int
	SET @current_number = @start_number
	WHILE @current_number <= @end_number
	BEGIN
		INSERT INTO @result_table (value)
		values (@current_number)
		SET @current_number = @current_number+1
	END
	RETURN
END

SELECT VALUE FROM dbo.GetValuesBetween(1,20) 

