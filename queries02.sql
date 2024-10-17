/*
	Data Cleansing Best Practice:
	1. Ensure Data has correct values (ex nvarchar, INT, DECIMAL, DATE)
	2. Ensure Data has no NULL/empty values - Deal with them appropriately
	3. Replacing Characters

	You would typically put the new "cleansed" data in a new table ex  [Restaurant - Master (Cleansed)]

	Checking for duplicate values:
	OBS -> It's Incredibly dangerous for data analysis! 
*/

/*NULL VALUES - MAKE SURE THEY ARE NOT NULL*/
-- Convert Blanks to NULL
UPDATE [Restaurant - Master]
SET [Meal Sides] = NULL
WHERE [Meal Sides] = ''

UPDATE [Restaurant - Master]
SET [Additional Details 1] = NULL
WHERE [Additional Details 1] = ''

UPDATE [Restaurant - Master]
SET [Additional Details 2] = NULL
WHERE [Additional Details 2] = ''

UPDATE [Restaurant - Master]
SET [Additional Details 3] = NULL
WHERE [Additional Details 3] = ''

-- Display Table
SELECT *
FROM [Restaurant - Master]

-- (1) ISNULL CODE - Replaces null with --N/A--
SELECT [Restaurant Name]
      ,[Meal Release Date]
      ,[Meal]
      ,[Meal Description]
      ,ISNULL([Meal Sides],'--N/A--') AS 'Meal Sides'
      ,[Cost]
      ,[Quantity]
      ,[Additional Details 1]
      ,[Additional Details 2]
      ,[Additional Details 3]
  FROM [dbo].[Restaurant - Master]

-- Replaces a null value with values present in other columns. Column in this case "Meal Comment" with a value from another column goes to next, next untill default value if all columns are null which it's trying to set from
-- COALESCE (so null values are ultimately removed) - Use Default value to make sure this happens!
SELECT [Restaurant Name]
      ,[Meal Release Date]
      ,[Meal]
      ,[Meal Description]
      ,[Meal Sides]
      ,[Cost]
      ,[Quantity]
      ,[Additional Details 1]
      ,[Additional Details 2]
      ,[Additional Details 3]
	  ,COALESCE([Additional Details 1],[Additional Details 2],[Additional Details 3],'No Comment') AS [Meal Comment]
  FROM [dbo].[Restaurant - Master]


------------------------------------------------------------------------------------------------------------------------
/*Converting Data Types*/
-- Remember casting table AS same table replaces the table with itself after operation!

-- (3) CONVERSION -> STRING TO INT & DECIMAL - the 18,2 is a format specifier for decimal
  SELECT [Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,CAST([Cost] AS decimal(18,2)) AS [Cost]
        ,CAST([Quantity] AS int) AS [Quantity]
        ,[Additional Details 1]
        ,[Additional Details 2]
        ,[Additional Details 3]
  FROM [dbo].[Restaurant - Master]

-- (4) CONVERSION -> STRING TO DATE - the 103 is the FORMAT specifier for the date
  SELECT [Restaurant Name]
        ,CONVERT(date,[Meal Release Date],103) AS [Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
        ,[Additional Details 1]
        ,[Additional Details 2]
        ,[Additional Details 3]
  FROM [dbo].[Restaurant - Master]


------------------------------------------------------------------------------------------------------------------------
/*Data Cleansing - ONE OF THE MOST IMPORTANT THINGS TO DO WHEN ANALYSING DATA!*/
/*
	Data Cleansing Best Practice:
	1. Ensure Data has correct values (ex nvarchar, INT, DECIMAL, DATE)
	2. Ensure Data has no NULL/empty values - Deal with them appropriately
	3. Replacing Characters

	You would typically put the new "cleansed" data in a new table ex  [Restaurant - Master (Cleansed)]
*/

-- DATA CLEANSING (REPLACE FUNCTION) -> all and replaced with & sign
    SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,REPLACE([Meal Sides],'and','&') AS [Meal Sides]
          ,[Cost]
          ,[Quantity]
          ,[Additional Details 1]
          ,[Additional Details 2]
          ,[Additional Details 3]
  FROM [dbo].[Restaurant - Master]

-- (6) DATA CLEASING (Really good practical example! -> Putting it all together)
  SELECT [Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,REPLACE( ISNULL([Meal Sides],'--N/A--') ,'and','&') AS [Meal Sides]
        ,CAST([Cost] AS decimal(18,2)) AS [Cost]
        ,CAST([Quantity] AS int) AS [Quantity]
	    ,COALESCE([Additional Details 1],[Additional Details 2],[Additional Details 3],'No Comment') AS [Meal Comment]
  INTO [Restaurant - Master (Cleansed)]
  FROM [dbo].[Restaurant - Master]

SELECT * FROM [Restaurant - Master (Cleansed)]




------------------------------------------------------------------------------------------------------------------------
/*Window Functions - Increases functionality of a dataset*/

-- (7) WINDOW FUNCTION - INTRODUCE REVENUE COLUMN
    SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,[Meal Sides]
          ,[Cost]
          ,[Quantity]
		  ,([Quantity]*[Cost]) AS [Revenue]
		  ,[Meal Comment]
  INTO [dbo].[Restaurant - Master (Cleansed) - Revenue]
  FROM [dbo].[Restaurant - Master (Cleansed)]

  SELECT * FROM [Restaurant - Master (Cleansed)]

-- (8) WINDOW FUNCTION - ROW COUNT -> Each row ranked by the restaurant name 1-29 in this case b first since b is first in alpabet, can replace with cost or whatever you want
  SELECT ROW_NUMBER() 
			OVER (ORDER BY [Restaurant Name]) 
				 AS [Row Number]
	    ,[Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
		,[Revenue]
		,[Meal Comment]
  FROM [dbo].[Restaurant - Master (Cleansed) - Revenue]

-- Here we just replace with Cost and make it asc order
  SELECT ROW_NUMBER() 
			OVER (ORDER BY [Cost] ASC) 
				 AS [Row Number]
	    ,[Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
		,[Revenue]
		,[Meal Comment]
  FROM [dbo].[Restaurant - Master (Cleansed) - Revenue]
  
-- (9) WINDOW FUNCTION - RANK -> Each row ranked by the descending Revenue so rank 1 made the most revenue in this case, we can add WHERE here aswell to filter rank based on certain values
  SELECT [Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
		,[Revenue]
		,RANK() 
			OVER (ORDER BY [Revenue] DESC) 
				 AS [Rank]
		,[Meal Comment]
  FROM [dbo].[Restaurant - Master (Cleansed) - Revenue]

-- (10) WINDOW FUNCTION - RANK (Introducing PARTITION) - Seperate ranking system for specific field and subfield. So same [Restaurant Name] value will all be grouped into one ranking system that goes from 1-whatever based on ex [Revenue]. So you seperate them.
  SELECT [Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
		,[Revenue]
        ,RANK() 
			OVER (PARTITION BY [Restaurant Name] 
				  ORDER BY [Revenue] DESC)
				  AS [Meal Rank]
		,[Meal Comment]
  FROM [dbo].[Restaurant - Master (Cleansed) - Revenue]



------------------------------------------------------------------------------------------------------------------------
/*Running Total*/
-- See how a certain metric is progressing. 'cumulative frequency'
-- (11) RUNNING TOTAL - Summing everytime there is a new object. Basically just summarizing all values progressivly as they are added. You can obviously have other operations here aswell.
  SELECT [Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
		,[Revenue]
		,SUM([Revenue]) 
			OVER (ORDER BY [Revenue]) 
				 AS [Overall Running Total]
		,[Meal Comment]
  FROM [dbo].[Restaurant - Master (Cleansed) - Revenue]


-- (12) RUNNING TOTAL (PARTITION)
  SELECT [Restaurant Name]
        ,[Meal Release Date]
        ,[Meal]
        ,[Meal Description]
        ,[Meal Sides]
        ,[Cost]
        ,[Quantity]
		,[Revenue]
		,SUM([Revenue]) 
			OVER (PARTITION BY [Restaurant Name] 
			ORDER BY [Revenue]) 
			AS [Restaunt Running Total]
		,[Meal Comment]
  FROM [dbo].[Restaurant - Master (Cleansed) - Revenue]



------------------------------------------------------------------------------------------------------------------------
/*Conversion (Preperation step for next section)*/
SELECT [Restaurant]
      ,CAST([Customer %] AS INT) AS [Customer %]
into [UDEMY SQL Course - Intermediate].[dbo].[Restaurant - Customer Reach]
FROM [UDEMY SQL Course - Intermediate].[dbo].[Restaurant - Customer Reach_]



------------------------------------------------------------------------------------------------------------------------
/*Subqueries AKA Nested Queries*/
-- One query from the result of another query
USE [UDEMY SQL Course]
GO

-- (13) SUBQUERY (INTO)
SELECT A.* 
INTO [Pay - Appended]
FROM 
	(
	  SELECT [Name]
			,[Pay]
	  FROM [dbo].[Female Pay]
  
	  UNION ALL
  
	  SELECT [Name]
			,[Pay]
	  FROM [dbo].[Male Pay] 
	) AS A


-- (14) SUBQUERY (Filtering) - Tables that only have a customer reach % over 20% -> Includes a filter based on the entries from another table
-- Customer Reach is the only table that has the Customer % Reach parameter. The [Restaurant - Master (Cleansed) - Revenue] has all the other data
	SELECT A.[Restaurant Name]
          ,A.[Meal Release Date]
          ,A.[Meal]
          ,A.[Meal Description]
          ,A.[Meal Sides]
          ,A.[Cost]
          ,A.[Quantity]
          ,A.[Revenue]
          ,A.[Meal Comment]
    FROM [Restaurant - Master (Cleansed) - Revenue] as A
	WHERE [Restaurant Name] IN (SELECT B.[Restaurant]
							   FROM [Restaurant - Customer Reach] as B
							   WHERE [Customer %] > 20) 

------------------------------------------------------------------------------------------------------------------------
/*View - Virtual Table, that doesn't actually take up additional storage in the database*/
-- Gets created inside Views Folder - SQL Treats the view like a normal table. Fantastic to experiment on for example since it's a 1/1 mirror of the original table but not the actual original table
-- It does allow flexibility. Cause it does not actually use any storage. But it does draw from the orignal table dataset.

-- (15) VIEWS
    CREATE VIEW [Missing Meal Sides]
	AS 
	SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,[Meal Sides]
          ,[Cost]
          ,[Quantity]
          ,[Revenue]
          ,[Meal Comment]
	FROM [Restaurant - Master (Cleansed) - Revenue]
	WHERE [Meal Sides] = '--N/A--'
 
-- (16) SELECTING THE VIEW
  SELECT *
  FROM [Missing Meal Sides]

-- ALTER the VIEW
    ALTER VIEW [Missing Meal Sides]
	AS 
	SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,[Meal Sides]
          ,[Cost]
          ,[Quantity]
          ,[Revenue]
          ,[Meal Comment]
	FROM [Restaurant - Master (Cleansed) - Revenue]
	WHERE [Meal Sides] = '--N/A--'
 


------------------------------------------------------------------------------------------------------------------------
/*Checking for duplicate values & Cleaning.*/
-- OBS -> It's Incredibly dangerous for data analysis! 

-- (17) CHECKING FOR DUPLICATES
  SELECT [Restaurant]
        ,[Ranking]
        ,[Description]
	    ,COUNT(*) AS [Row Count]
  FROM [Restaurant Rankings (Duplicates)]
  GROUP BY [Restaurant]
          ,[Ranking]
          ,[Description]

-- We can see what the duplicates are and by how many
  SELECT [Restaurant]
        ,[Ranking]
        ,[Description]
	    ,COUNT(*) AS [Row Count]
  FROM [Restaurant Rankings (Duplicates)]
  GROUP BY [Restaurant]
          ,[Ranking]
          ,[Description]
  HAVING COUNT(*) > 1

-- We can remove duplicates by aggregating the table against itself
  SELECT [Restaurant]
        ,[Ranking]
        ,[Description]
  FROM [Restaurant Rankings (Duplicates)]
  GROUP BY [Restaurant]
          ,[Ranking]
          ,[Description]



------------------------------------------------------------------------------------------------------------------------
/*Using Variables in SQL*/
/*
	DECLARE @name datatype()
	SET @name = valueAssignedToVariable
*/
-- (18) VARIABLE (Filter)
  DECLARE @restaurant nvarchar(100)
  SET @restaurant = 'Data Pizza'

  	SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,[Meal Sides]
          ,[Cost]
          ,[Quantity]
          ,[Revenue]
          ,[Meal Comment]
	FROM [Restaurant - Master (Cleansed) - Revenue]
	WHERE [Restaurant Name] = @Restaurant

-- (19) VARIABLE (Table) - Cool we can recreate the query using variables
  DECLARE @table nvarchar(100) 
  DECLARE @filter nvarchar(100)
  DECLARE @SQL_query nvarchar(max)

  SET @table = '[Restaurant - Master (Cleansed) - Revenue]'
  SET @filter = 'Data Pizza'
  SET @SQL_query = '

  	SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,[Meal Sides]
          ,[Cost]
          ,[Quantity]
          ,[Revenue]
          ,[Meal Comment]
	FROM ' + @table + ' 
	WHERE [Restaurant Name] = ''' + @filter + ''' 
	ORDER BY [Revenue] 
	
	'

  PRINT @SQL_query 
  EXEC (@SQL_query)



------------------------------------------------------------------------------------------------------------------------
/*Stored Procedures - Way of saving queries INSIDE your database. Fantastic!*/
-- Variables can be used in here aswell! 
-- They get stored in the Programmability -> Stored Procedures folder
-- You can then run these stored procedures whenever you want!
-- EXEC Runs the stored procedure

--(20) STORED PROCEDURE (STORING CODE) - Just a simple duplicate query that we want to create as a stored procedure
  CREATE PROCEDURE [Duplicate Code]
  AS

  SELECT [Restaurant]
        ,[Ranking]
        ,[Description]
	    ,COUNT(*) AS [Row Count]
  FROM [Restaurant Rankings (Duplicates)]
  GROUP BY [Restaurant]
          ,[Ranking]
          ,[Description]
  HAVING COUNT(*) > 1

-- (21) STORED PROCEDURE (Variable) - If we run the stored procedure we can literally ADD the variable dynamically in the input field if we want! Just like the EXEC is defining it before runtime!
-- Really fucking cool this! TSQL is fun!
  CREATE PROCEDURE [Restaurant Select]
	@Restaurant nvarchar(100)
  AS
    
	SELECT [Restaurant Name]
          ,[Meal Release Date]
          ,[Meal]
          ,[Meal Description]
          ,[Meal Sides]
          ,[Cost]
          ,[Quantity]
          ,[Revenue]
          ,[Meal Comment]
	FROM [Restaurant - Master (Cleansed) - Revenue]
	WHERE [Restaurant Name] = @Restaurant

-- (22) RUNNING STORED PROCEDURE
    EXEC  [dbo].[Restaurant Select]
		  @Restaurant = 'Big Data Burger'



------------------------------------------------------------------------------------------------------------------------
/*Stored Procedures from the course - EXAMPLES*/
-- Example 1
USE [UDEMY SQL Course]
GO
/****** Object:  StoredProcedure [dbo].[Convert - Country Population]    Script Date: 08/10/2024 17:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Convert - Country Population]

AS

SELECT [Country]
      ,CAST([Population] AS INT) AS [Population]
      ,[Year]
INTO [dbo].[Country Population]
FROM [dbo].[Country Population_]



-- Example 2
USE [UDEMY SQL Course]
GO
/****** Object:  StoredProcedure [dbo].[Convert - Female]    Script Date: 08/10/2024 17:41:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Convert - Female] 
AS

IF OBJECT_ID(N'Female Pay','U') IS NOT NULL 
  DROP TABLE [dbo].[Pay - Female]

SELECT [Name]
	  ,CAST([Pay] AS INT) AS [Pay]
INTO [dbo].[Pay - Female]
FROM [dbo].[Pay - Female_]



-- Example 3
USE [UDEMY SQL Course]
GO
/****** Object:  StoredProcedure [dbo].[Convert - Male]    Script Date: 08/10/2024 17:41:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Convert - Male] 
AS

IF OBJECT_ID(N'Male Pay','U') IS NOT NULL 
  DROP TABLE [dbo].[Pay - Male]

SELECT [Name]
	  ,CAST([Pay] AS INT) AS [Pay]
INTO [dbo].[Pay - Male]
FROM [dbo].[Pay - Male_]



-- Example 4
USE [UDEMY SQL Course]
GO
/****** Object:  StoredProcedure [dbo].[Melbourne Housing - Convert Datatypes]    Script Date: 08/10/2024 17:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Melbourne Housing - Convert Datatypes]
AS 

IF OBJECT_ID(N'Melbourne Housing Master','U') IS NOT NULL
	DROP TABLE [Melbourne Housing Master]

SELECT [Suburb]
      ,[Address]
      ,[Rooms]
      ,[Type]
      ,CAST([Price] AS INT) AS [Price]
      ,CAST([Suburb Price Average] AS INT) AS [Suburb Price Average]
      ,CAST([Final Price] AS INT) AS [Final Price]
      ,[Method]
      ,[SellerG]
      ,CONVERT(date,[Date],103) AS [Date]
      ,CAST([Distance] AS decimal(18,2)) AS [Distance]
      ,[Postcode]
      ,[Bedroom2]
      ,[Bathroom]
      ,CAST([Car] AS INT) AS [Car]
      ,[Landsize]
      ,[BuildingArea]
      ,[YearBuilt]
      ,[CouncilArea]
      ,[Latitude]
      ,[Longitude]
      ,[Regionname]
      ,[Propertycount]
  INTO [dbo].[Melbourne Housing Master]
  FROM [dbo].[Melbourne Housing Master_]