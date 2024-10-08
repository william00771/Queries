/*
	Data Cleansing Best Practice:
	1. Ensure Data has correct values (ex nvarchar, INT, DECIMAL, DATE)
	2. Ensure Data has no NULL/empty values - Deal with them appropriately
	3. Replacing Characters

	You would typically put the new "cleansed" data in a new table ex  [Restaurant - Master (Cleansed)]
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





------------------------------------------------------------------------------------------------------------------------
/*Data Cleansing*/