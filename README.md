# HR-Analytics-SQL-Tableau

Hemanand Vadivel data analytics manager experienced in the use of power BI. Pinali Mandalia a HR Generalist from Atliq Technologies.
The tutor is a co-founder of Atliq Technologies. Data to be worked with is a data of 3 months and on the columns is attendance for each day.
There is also Attendance key codes in another Table which gives details of attendance key codes. The end aim is to build a HR Dashboard.


## THE MEETTING 
During the meeting, Pinali Mandalia (HR Generalist) said she has dataset for three months, and she wants to combine them to have insights.
For example, 
* The working Preference of people whether they prefer working from home or in the office. if they are taking work from home on mondays and what could be reasons behind that.
The Attendance key code table has Work From Home denoted as WFH, it also has HWFH which means Half Work From Home.
* she also said she wants to understand percentage of people present for a given week and a given month. because if people prefer to work from home on mondays and fridays, may be at the begining or end of the month.
This will help in planning team building activity or team lunch, it would be done when majority of people are present in the company.
knowing this will help understand pattern for hybrid workers, thereby aiding capacity planning. this will help is space utilization and save cost on infastructure.
* know percentage of people taking sick leave especially incase of high percentage in one day. This could be an indication of COVID, flu or epidemics and in such situation, precausion is needed like sanitization and better spacing in work place.

## DATA CLEANING AND PREPARATION WITH SQL

### PARTIAL CLEANING OF APRIL 2022 DATA

* VIEWING OF APRIL TABLE

`select * from Apr_2022;`

![Alt Text]()

* DELETING FIRST ROW

  I deleted this row becauese it contains weekday value which i can easily create with the datename function if I wish to. deleting it also made cleaning easy.


`delete from Apr_2022`
`where AtliQ = 'Employee Code';`

![Alt Text]()

* VIEWING THE CHANGE

`select * from Apr_2022;`

![Alt Text]()

* DROPING MAY 1ST COLUMN 

   I dropped the May 1st column because it is not supposed to be in April Table. However, it had no value because it's workers day and no one works on that day.

`Alter Table Apr_2022`
`Drop Column [1 - May];`


![Alt Text]()

* RENAMINING OF COLUMNS (ATLIQ AND F2)

   I renamed this column so it could be easy to identify what they represent.

`Exec sp_rename 'Apr_2022.AtliQ','Employee_Code', 'COLUMN';`

`Exec sp_rename 'Apr_2022.F2','Name', 'COLUMN';`

![Alt Text]()       ![Alt Text]()

* VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text]()

### PARTIAL CLEANING OF MAY 2022 DATA

* VIEWING DATA

`select * from May_2022;`

* DELETING THE FIRST ROW

   The first row is unneccessary and I can create it using the DATENAME function but to ease cleaning, let me remove for now.

delete from May_2022
where AtliQ = 'Employee Code';

![Alt Text]()

* VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text]()

* DELETING FIRST OF JUNE COLUMN

   Just like in the April table, 1st of June is not supposed to be a column in May table so I had to delete.

`Alter Table May_2022`
`Drop Column [1 - Jun];`

* VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text]()

* RENAMING COLUMNS (ATLIQ AND F2)

    Just like in the May Table, there is need to rename the first two column to Employee_Code, Name so one can easily understand what they represent.

`Exec sp_rename 'May_2022.AtliQ','Employee_Code', 'COLUMN';`

`Exec sp_rename 'May_2022.F2','Name', 'COLUMN';`

![Alt Text]()       ![Alt Text]()

* VIEWING FOR CHANGES

`select * from May_2022;

![Alt Text]()

### PARTIAL CLEANING OF JUNE DATA 

* VIEWING JUNE TABLE

`select * from June_2022;`

![Alt Text]()

* DELETING THE FIRST COLUMN

     The first row contains weekday, which I can easily create with the date column. To aid the data cleaning process, I need to delete it.

`delete from June_2022`
`where AtliQ = 'Employee Code';`

![Alt Text]()

* VIEWING TO SEE CHANGES

`select * from June_2022;`

![Alt Text]()

* DROPPING 1- JUN1 COLUMN FROM THE TABLE

`Alter Table June_2022`
`Drop Column [1 - Jun1];`

![Alt Text]()

* VIEWING TO SEE CHANGES

`select * from June_2022;`

![Alt Text]()


* RENAMING COLUMNS (ATLIQ AND F2)

  These columns need to take the right name for easy identification. That's why I had to rename.

`Exec sp_rename 'june_2022.AtliQ','Employee_Code', 'COLUMN';`


`Exec sp_rename 'June_2022.F2','Name', 'COLUMN';`


![Alt Text]()           ![Alt Text]()

* VIEWING TO SEE CHANGES

`select * from June_2022;`

![Alt Text]()


### CREATING PROCEDURE TO UNPIVOT THE DATA

 * Looking at the three data sets I have for different months, its obvious that the date row is supposed to be a colum and not a row in orther to aid our analysis. 
 Another way to say this which is better is to say that the data is pivoted. I need to unpivot it. but there is need to create a procedure that will do this with one line of code instead of having to do this seperately for each table. 

#### EXPLANATION OF THE PROCEDURE

I called the procedure unpivotdataforMonths, which should take a table name and store it in a varible @tableName. then I declared a variable called @columns within the column name. This variable will concat all column with names that has that has '-' with ',' to create a list.
the reason why I used hyphen ('-') is because dates for all table has hyphen eg 1-Apr. The third variable within the procedure known as @query does the main work of unpivoting.


I will run this procedure to see if its working. if it gives no error, then its ok.

`Create Procedure dbo.UnpivotdataforMonths`
    `@tableName Nvarchar(128)`
`as` 
`Begin`
    `Declare @columns AS Nvarchar(Max);` 
	`Declare @query as Nvarchar(Max);`

	`SELECT @columns = STRING_AGG(QUOTENAME(Column_name),',')`
    `from INFORMATION_SCHEMA.COLUMNS`
    `where TABLE_NAME = @tableName and COLUMN_NAME like '%-%';`

	`SET @query = '`
	`select` 
	    `Employee_Code,`
		`Name,`
		`Dates,`
		`Attendance_Status`
	`From( Select Employee_Code,`
	    `Name,`
		`'+@columns+'`
	`From '+@tableName+')`
	`As SourceTable`
	`UNPIVOT(Attendance_Status FOR Dates IN ('+@columns+'))`
	`Unpivoted_Table';`
	`Exec Sp_executesql @query;`
`END;`

![Alt Text]()

its obvious it's working.

* CHEKING IF THE PROCEDURE CAN UNPIVOT THE THREE TABLES

Here I am checking if the procedure could do the task it was created for. This is done using 'Exec'



exec dbo.UnpivotdataforMonths @tableName = 'Apr_2022';

exec dbo.UnpivotdataforMonths @tableName = 'May_2022';

exec dbo.UnpivotdataforMonths @tableName = 'June_2022';



![Alt Text]()                   ![Alt Text]()                      ![Alt Text]()


* CHECKING THE JUNE TABLE TO SEE DATA TYPES OF EACH COLUMN SO AS TO FIX THE ERROR

As seen above there was an error due to data type incompactability in the june table, so I need to find out the columns giving the challenge


`select COLUMN_NAME, DATA_TYPE` 
`from INFORMATION_SCHEMA.COLUMNS`
`where TABLE_NAME = 'june_2022';`

![Alt Text]()

* CHANGING DATA TYPE FOR COLUMN [29 - Jun] and [30 - Jun]

since I have foud out its [29 - Jun] and [30 - Jun], let me change the data type of both to Nvarchar(255) so it could be same with others

`Alter Table June_2022`
`Alter column [29 - Jun] nvarchar(255);`

`Alter Table June_2022`
`Alter column [30 - Jun] nvarchar(255);`

![Alt Text]()                        ![Alt Text]()


* CREATING  A TEMPORARY TABLE

 There is need to now bring these three unpivoted tables together. Because I do not want to store unneccessary tables within my database, I wish to store the data in a temporary table.
 however, I used a drop table if exist code to drop the table and recreate it so that it could aid easy use when I get data for July and also to prevent storing multiple temporary tables. 

 `Drop Table if exists #Temp_Attendance`
 `Create Table #Temp_Attendance (`
 `Employee_Code Nvarchar (225), Name Nvarchar (225),` 
 `Dates Nvarchar (225), Attendance_Status Nvarchar (225))`


 `insert into #Temp_Attendance`
 `exec dbo.UnpivotdataforMonths @tableName = 'Apr_2022';`

 `insert into #Temp_Attendance`
 `exec dbo.UnpivotdataforMonths @tableName = 'May_2022';`

 `insert into #Temp_Attendance`
 `exec dbo.UnpivotdataforMonths @tableName = 'June_2022';`

 `select * from #Temp_Attendance`

![Alt Text]()                                         ![Alt Text]()





## DATA CLEANING WITH POWER QUERY
To perform accurate analysis, the dataset for the analysis needs to be cleaned. steps in data cleaning

* Loading of the Data into Power Query
* Removing the Day Row (Unnecessary and can be easily created)
* Unpivoting this normalizes the data by converting rows to column and putting values next to the new column
* The steps applied in the first month, was created as a function so that in subsequent months, the function can be applied to new sheets since they come in the same pattern.