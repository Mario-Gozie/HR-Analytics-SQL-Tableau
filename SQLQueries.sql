--viewing April data

select * from Apr_2022;

-- Removing the first Row which contains the the days and. the are not necessary as I can easily create them. 
-- This will definitely remove two important column names 
--The 'Employee code' column name and the 'Name' for the name column but I will rename those columns to make everything perfect.


-- Deleting The first Row
delete from Apr_2022
where AtliQ = 'Employee Code';

select * from Apr_2022;

--dropping the the 1-May column its may day and shouldn't even be in the table
Alter Table Apr_2022
Drop Column [1 - May];

select * from Apr_2022;

-- Time to rename the first two columns to Employee code and Name.
Exec sp_rename 'Apr_2022.AtliQ','Employee_Code', 'COLUMN';
--Renaming the F2 column
Exec sp_rename 'Apr_2022.F2','Name', 'COLUMN';
--viewing corrections after renamings.
select * from Apr_2022;

--- for the May column
--viewing
select * from May_2022;

--deleting the first row
delete from May_2022
where AtliQ = 'Employee Code';

select * from May_2022;


--dropping the the 1- column its may day and shouldn't even be in the table
Alter Table May_2022
Drop Column [1 - Jun];

select * from May_2022;

-- Time to rename the first two columns to Employee code and Name.
Exec sp_rename 'May_2022.AtliQ','Employee_Code', 'COLUMN';
--Renaming the F2 column
Exec sp_rename 'May_2022.F2','Name', 'COLUMN';
--viewing corrections after renamings.
select * from May_2022;

-- For June

--viewing table

select * from June_2022;

--deleting the first row
delete from June_2022
where AtliQ = 'Employee Code';

select * from June_2022;


--dropping the the 1- Jun1 column its may day and shouldn't even be in the table
Alter Table June_2022
Drop Column [1 - Jun1];

select * from June_2022;

-- Time to rename the first two columns to Employee code and Name.
Exec sp_rename 'june_2022.AtliQ','Employee_Code', 'COLUMN';

--Renaming the F2 column
Exec sp_rename 'June_2022.F2','Name', 'COLUMN';
--viewing corrections after renamings.
select * from June_2022;

-- cleaning the Attendance key Table
select * from Attendance_Key

-- Everything appear nice except for the second column name so I need to rename it.

Exec sp_rename 'Attendance_key.F2','Attendance_detail', 'COLUMN';

--viewing Table to check for changes.

select * from Attendance_Key;



-- looking at the date in rows, its not in the the right format. it is supposed to be in a column so as to aid our Analysis.
-- To unpivot this easily, I will use dynamic SQL inside a procedure
go
 Drop Procedure if exists dbo.UnpivotdataforMonths
 go
Create Procedure dbo.UnpivotdataforMonths
    @tableName Nvarchar(128)
as 
Begin 
    Declare @columns AS Nvarchar(Max); -- this variable will contain all columns
	Declare @query as Nvarchar(Max); -- this varible is the main varible that contains the unpivot query

	SELECT @columns = STRING_AGG(QUOTENAME(Column_name),',') -- The variable here will collect a list of all columns and concatenate it with ','
    from INFORMATION_SCHEMA.COLUMNS
    where TABLE_NAME = @tableName and COLUMN_NAME like '%-%';

	SET @query = '
	select 
	    Employee_Code,
		Name,
		Dates,
		Attendance_Status
	From( Select Employee_Code, 
	    Name,
		'+@columns+'
	From '+@tableName+')
	As SourceTable
	UNPIVOT(Attendance_Status FOR Dates IN ('+@columns+'))
	Unpivoted_Table';
	Exec Sp_executesql @query;
END;

go

-- Applying the created Procedures on the three table to see outcome

exec dbo.UnpivotdataforMonths @tableName = 'Apr_2022';

exec dbo.UnpivotdataforMonths @tableName = 'May_2022';

exec dbo.UnpivotdataforMonths @tableName = 'June_2022';

-- Checking the data type of columns in June table

select COLUMN_NAME, DATA_TYPE  
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'june_2022';

-- it's Obvious that column with name '29-Jun' and '30-June' are the reason why this data has refused to pivot. 
-- while others are in nvarchar, they are in datetime since the values to tackle this, I need to convert the two columns to nvarchar.

-- converting 29 and 30 jun data types.
-- jun 29
Alter Table June_2022
Alter column [29 - Jun] nvarchar(255);


-- June 30
Alter Table June_2022
Alter column [30 - Jun] nvarchar(255);

-- let me now run the execution command (procedure to unpivot)

exec dbo.UnpivotdataforMonths @tableName = 'June_2022';

-- Bringing the tables into one Table into one Temporary table.
-- Because I dont want to store a table each time I want to get the HR data for AtliQ Technologies, I will store the clean data  in a temporary table with the if exit comand on top
-- The if exist command will drop the table if it exist and creates it each time I need it.

 Drop Table if exists #Temp_Attendance
 Create Table #Temp_Attendance (
 Employee_Code Nvarchar (225), Name Nvarchar (225), 
 Dates Nvarchar (225), Attendance_Status Nvarchar (225))


 insert into #Temp_Attendance
 exec dbo.UnpivotdataforMonths @tableName = 'Apr_2022';

 insert into #Temp_Attendance
 exec dbo.UnpivotdataforMonths @tableName = 'May_2022';

 insert into #Temp_Attendance
 exec dbo.UnpivotdataforMonths @tableName = 'June_2022';

 select * from #Temp_Attendance;

 -- To have a clear understanding of what Attendance status is all about, I had to join the temporary table to the atttebdabce key table on attendace status and attendance key

 Drop Table if exists #Temp_Attendance
 Create Table #Temp_Attendance (
 Employee_Code Nvarchar (225), Name Nvarchar (225), 
 Dates Nvarchar (225), Attendance_Status Nvarchar (225))


 insert into #Temp_Attendance
 exec dbo.UnpivotdataforMonths @tableName = 'Apr_2022';

 insert into #Temp_Attendance
 exec dbo.UnpivotdataforMonths @tableName = 'May_2022';

 insert into #Temp_Attendance
 exec dbo.UnpivotdataforMonths @tableName = 'June_2022';

 select Employee_Code, Name, DAtes, Attendance_Status, Attendance_detail 
 from #Temp_Attendance join Attendance_Key on
 [ATTENDANCE KEY] = Attendance_Status;



