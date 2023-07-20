# INTRODUCTION

A company known as Atliq Technologies wishes to understand working preference of thier staff, so they have decided to get a data analysts on contract who would help them generate insights from their Human Resource data. They have already gotten a data analytics I am a member and have scheduled to have meeting to discuss this task.

_**Disclaimer**_ This is a dummy dataset for practice purpose and do not represent any organization.

## STAKEHOLDERS AND ATENDEES OF THE MEETING

* Dhaval Patel - Co-Founder of Atliq Techmologies
* Pinali Mandalia - A HR Generalist at Atliq Technologies
* Data Analytics Team

## STRUCTURE OF DATASET

The data is made of **3 Months** seperate datasets with an **Attendance Key** data that tell more about the acronyms in the main dataset.


## THE MEETTING 
During the meeting, Pinali Mandalia (HR Generalist) said she has dataset for three months, and she wants to combine them to have insights.
insights like: 

* The working Preference of people. Whether they prefer working from home or in the office. if they are taking work from home on mondays and what could be reasons behind that.

* She also said she wants to understand percentage of people present for a given week and a given month. This will help her know which time within a month people prefer to work from home on mondays and fridays. Whether it is at the begining of the month or at the end. This will help in planning team building activity or team lunch, which should be done when majority of people are present in the company. knowing this will also help understand pattern for hybrid workers, thereby aiding capacity planning to help space utilization and save cost on infastructure.

* She added that knowing percentage of people taking sick leave could be an indication for COVID, flu or epidemics and in such situation, precausion is needed such as sanitization and better spacing in work place.


## TOOLS USED

* SQL
* Power Query
* Tableau



## DATA CLEANING AND PREPARATION WITH SQL

### PARTIAL CLEANING OF APRIL 2022 DATA

##### VIEWING OF APRIL TABLE

`select * from Apr_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Viewing%20April%20Table%20first%20time%20.png)

##### DELETING FIRST ROW

  I deleted this row becauese it contains weekday value which i can easily create with the datename function if I wish to. deleting it also made cleaning easy.


`delete from Apr_2022`
`where AtliQ = 'Employee Code';`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Deleting%20April%20Table%20first%20row.png)


##### VIEWING THE CHANGE

`select * from Apr_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20April%20after%20first%20row%20delete.png)


##### DROPING MAY 1ST COLUMN 

   I dropped the May 1st column because it is not supposed to be in April Table. However, it had no value because it's workers day and no one works on that day.

`Alter Table Apr_2022`
`Drop Column [1 - May];`


![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/deleting%201%20may%20column.png)

##### VIEWING TABLE AFTER DELETING FIRST OF MAY COLUMN

`select * from Apr_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20after%20deleting%201%20May.png)


##### RENAMINING OF COLUMNS (ATLIQ AND F2)

I renamed this column so it could be easy to identify what they represent.

`Exec sp_rename 'Apr_2022.AtliQ','Employee_Code', 'COLUMN';`

`Exec sp_rename 'Apr_2022.F2','Name', 'COLUMN';`


|       ATLIQ RENAME TO EMPLOYEE CODE                              |     F2  RENAME TO NAME                                       |
| ---------------------------------------------------------------- | ------------------------------------------------------------ |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/April%20Employee%20code%20Rename.png)                                            |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/April%20Name%20Column%20Rename.png)                                         |


##### VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Viewing%20April%20after%20columns%20Rename.png)

### PARTIAL CLEANING OF MAY 2022 DATA

##### VIEWING DATA

`select * from May_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20May%20column%20first%20time.png)

##### DELETING THE FIRST ROW

   The first row is unneccessary and I can create it using the DATENAME function but to ease cleaning, let me remove for now.

`delete from May_2022`
`where AtliQ = 'Employee Code';`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Deleting%20first%20Row%20in%20May%20Table.png)

##### VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20May%20after%20deleting%20first%20Row.png)


##### DELETING FIRST OF JUNE COLUMN

Just like in the April table, 1st of June is not supposed to be a column in May table so I had to delete.

`Alter Table May_2022`
`Drop Column [1 - Jun];`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/deleting%201%20Jun%20from%20May%20Table.png)

##### VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20May%20Table%20after%20deleting%201%20Jun%20column.png)


##### RENAMING COLUMNS (ATLIQ AND F2)
Just like in the May Table, there is need to rename the first two column to Employee_Code, Name so one can easily understand what they represent.

`Exec sp_rename 'May_2022.AtliQ','Employee_Code', 'COLUMN';`

`Exec sp_rename 'May_2022.F2','Name', 'COLUMN';`


|       ATLIQ RENAME TO EMPLOYEE CODE                              |     F2  RENAME TO NAME                                       |
| ---------------------------------------------------------------- | ------------------------------------------------------------ |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Renaming%20Employee%20code%20for%20May.png)                                            |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Renaming%20Name%20column%20May.png)                                         |


##### VIEWING FOR CHANGES

`select * from May_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20to%20see%20rename%20changes%20May.png)

### PARTIAL CLEANING OF JUNE DATA 

##### VIEWING JUNE TABLE

`select * from June_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20June%20Table%20first%20time.png)


##### DELETING THE FIRST ROW IN JUNE

The first row contains weekday, which I can easily create with the date column. To aid the data cleaning process, I need to delete it.

`delete from June_2022`
`where AtliQ = 'Employee Code';`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/deleting%20first%20Row%20June%20Table.png)

##### VIEWING TO SEE CHANGES

`select * from June_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20June%20after%20Renaming.png)

##### DROPPING 1- JUN1 COLUMN FROM THE TABLE

`Alter Table June_2022`
`Drop Column [1 - Jun1];`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/deleting%201%20July%20column%20from%20June.png)

##### VIEWING TO SEE CHANGES

`select * from June_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20June%20after%20Renaming.png)


##### RENAMING COLUMNS (ATLIQ AND F2)

These columns need to take the right name for easy identification. That's why I had to rename.

`Exec sp_rename 'june_2022.AtliQ','Employee_Code', 'COLUMN';`


`Exec sp_rename 'June_2022.F2','Name', 'COLUMN';`


|       ATLIQ RENAME TO EMPLOYEE CODE                              |     F2  RENAME TO NAME                                       |
| ---------------------------------------------------------------- | ------------------------------------------------------------ |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Employee%20Code%20rename%20june.png)                                            |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Rename%20Name%20column%20June.png)                                         |


##### VIEWING TO SEE CHANGES

`select * from June_2022;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20June%20after%20Renaming.png)

### CLEANING ATTENDACE_STATUS TABLE

##### VIEWING THE TABLE

`select * from Attendance_Key`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20the%20attendance%20key%20table%20first%20time.png)

##### RENAMING THE SECOND COLUMN F2

There was need to rename this column as its the column that tells the actual meaning of each accronym in the Attendance status column

`Exec sp_rename 'Attendance_key.F2','Attendance_detail', 'COLUMN';`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Renaming%20in%20the%20Attendance%20key%20table.png)

##### VIEWING THE TABLE FOR CORRECTED COLUMN NAME

`select * from Attendance_Key;`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Viewing%20out%20come%20of%20column%20rename%20attendance%20key%20table.png)




### CREATING PROCEDURE TO UNPIVOT THE DATA

Looking at the three data sets I have for different months, its obvious that the date row is supposed to be a colum and not a row in orther to aid our analysis. 
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


|       FIRST PART                                                 |     SECOND PART                                              |
| ---------------------------------------------------------------- | ------------------------------------------------------------ |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Procedure%20First%20Part.png)                                            |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Procedure%20second%20Part.png)                                         |


Its obvious it's working.

##### CHEKING IF THE PROCEDURE CAN UNPIVOT THE THREE TABLES

Here I am checking if the procedure could do the task it was created for. This is done using 'Exec'



`exec dbo.UnpivotdataforMonths @tableName = 'Apr_2022';`

`exec dbo.UnpivotdataforMonths @tableName = 'May_2022';`

`exec dbo.UnpivotdataforMonths @tableName = 'June_2022';`



|       APRIL                              |     MAY                                     |     JUNE                               |
| ---------------------------------------- | ------------------------------------------- | -------------------------------------- |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Testing%20Procedure%20for%20April%20Data.png)                    |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Testing%20Procedure%20for%20May%20Data.png)                        |       ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Testing%20Procedure%20for%20June%20Data%20error.png)                    |


_**NB**_ There is a datatype error with June.

#### CHECKING THE JUNE TABLE TO SEE DATA TYPES OF EACH COLUMN SO AS TO FIX THE ERROR

As seen above there was an error due to data type incompactability in the june table, so I need to find out the columns giving the challenge


`select COLUMN_NAME, DATA_TYPE` 
`from INFORMATION_SCHEMA.COLUMNS`
`where TABLE_NAME = 'june_2022';`

|       FIRST PART WITH ALL OK                              |     SECOND PART WHERE THE CHALLENGE IS                       |
| --------------------------------------------------------- | ------------------------------------------------------------ |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/viewing%20to%20check%20data%20type%20error%20June.png)                                     |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Here%20is%20the%20data%20type%20datetime%20June.png)                                         |


Looking at this, I can see that among all the date column names I want to unpivot i.e columns that have '-', it's only [29 - Jun] and [30 - Jun] that has data type that is not nvarchar, so there is the Problem. 

_**NB**_ Nvarchar is the best data type when you want to do a dynamic SQL or Procedure because it accept differnt kinds of characters.

##### CHANGING DATA TYPE FOR COLUMN [29 - Jun] and [30 - Jun]

since I have foud out its [29 - Jun] and [30 - Jun], let me change the data type of both to Nvarchar(255) so it could be same with others

`Alter Table June_2022`
`Alter column [29 - Jun] nvarchar(255);`

`Alter Table June_2022`
`Alter column [30 - Jun] nvarchar(255);`


|   CHANGING DATA TYPE FOR [29 - Jun] |   CHANGING DATA TYPE FOR [30 - Jun]   |
|-------------------------------------|---------------------------------------|
|   ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/changing%2029%20june%20Data%20type.png)                     |     ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Changing%2030%20June%20Data%20Type.png)                     |



##### RUNNING THE PROCEDURE AGAIN FOR JUNE TO UNPIVOT

This is just to check if the data type change is effective and if I can use the procedure to unpivot.

`exec dbo.UnpivotdataforMonths @tableName = 'June_2022';`

![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Running%20Procedure%20again%20June%20successful.png)

##### CREATING  A TEMPORARY TABLE

There is need to now bring these three unpivoted tables together. Because I do not want to store unneccessary tables within my database, I wish to store the data in a temporary table. However, I used a drop table if exist code to drop the table and recreate it so that it could aid easy use when I get data for July and also to prevent storing multiple temporary tables. 

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


|       FIRST PART OF THE UNIONED TEMPORARY TABLE          |     SECOND PART OF THE UNIONED TEMPORARY TABLE               |
| -------------------------------------------------------- | ------------------------------------------------------------ |
|         ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/Unioning%20the%20three%20unpivoted%20tables%20within%20a%20Temporary%20table.png)                                    |        ![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/The%20union%20got%20to%20June.png)                                         |

Here, you can see that the three tables has been joined sucessfully together using the created and stored procedure as well into a temporary table i.e April, May and June.

### JOINING THE TABLE TO THE ATTENDANCE KEY TABLE

 This step make every thing about the table clear as it contains also meaning of every acronym in the main table.

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

 ` select Employee_Code, Name, DAtes, Attendance_Status, Attendance_detail`
 `from #Temp_Attendance join Attendance_Key on`
 `[ATTENDANCE KEY] = Attendance_Status;`


![Alt Text](https://github.com/Mario-Gozie/HR-Analytics-SQL-Tableau/blob/main/Images/joining%20the%20three%20attendace%20table%20with%20the%20attendance%20key%20table.png)

Now, Everything looks better after joining the there attendance table and the Attendance key table which explains every acronym in the attendace status column. In this format, anyone could understand what the data is all about.


## DATA CLEANING WITH POWER QUERY
To perform accurate analysis, the dataset for the analysis needs to be cleaned. steps in data cleaning

* Loading of the Data into Power Query
* Removing the Day Row (Unnecessary and can be easily created)
* Unpivoting this normalizes the data by converting rows to column and putting values next to the new column
* The steps applied in the first month, was created as a function so that in subsequent months, the function can be applied to new sheets since they come in the same pattern.