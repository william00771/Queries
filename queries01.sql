/* Select and From */
-- Select everything
SELECT	*
FROM	[dbo].[Melbourne Housing Master]

-- Select top 100
SELECT TOP (100) *
FROM	[dbo].[Melbourne Housing Master]

-- Select Specific
SELECT	[Suburb]
		,[Address]
		,[Rooms]
FROM	[dbo].[Melbourne Housing Master]

-- Renaming Columns (DisplayName)
SELECT	[Suburb] AS [F�rort]
		,[Type] AS [Bostadstyp]
FROM	[dbo].[Melbourne Housing Master]

-- Math Operations - Create DisplayTable
SELECT	[Suburb]
		,[Rooms]
		,([Final Price] / 1000) AS [Price_In_Thousands]
		,(([Final Price] + 5000)/1000) AS [Modified_Price]
FROM	[dbo].[Melbourne Housing Master]

-- String Operations - Create DisplayTable from two other tables
SELECT	[Suburb]
		,[Address]
		,[Suburb] + ' - ' + [Address] AS [Suburb - Address]
		,CONCAT([Suburb],' - ',[Address]) AS [Suburb - Address 2] 
FROM	[dbo].[Melbourne Housing Master]

-- Selecting a certaint count of rows (pagination)
SELECT TOP(100) Suburb, Address
FROM [dbo].[Melbourne Housing Master]


-------------------------------------------------------------------------------------------------------------------

/* Filtering Data - Where */
-- Filter by String
SELECT	[Suburb]
		,[Address]
		,[Rooms]
FROM	[dbo].[Melbourne Housing Master]
where [Suburb] = 'Werribee'

-- Filter by Number
SELECT	[Suburb]
		,[Rooms]
		,[Address]
		,[Type]
FROM [dbo].[Melbourne Housing Master]
WHERE [Rooms] >= 4

-- Filter by Date
SELECT	[Suburb]
		,[Rooms]
		,[Address]
		,[Type]
		,[Date]
FROM [dbo].[Melbourne Housing Master]
WHERE [Date] = '2017-06-24'

-- Filter by Multible Conditions AND
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Suburb] = 'Werribee'
  AND [Rooms] = 3
  AND [Date] = '2017-06-24'

-- Filter by Multible Conditions OR
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Suburb] = 'Werribee'
  OR [Suburb] = 'Preston'

-- Filter by Multible Conditions Combining AND & OR
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Rooms] = 4
  AND ([Suburb] = 'Werribee' OR [Suburb] = 'Preston')

-- Filter by IN Statement (Date) (Multiple values applied to WHERE)
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Date] IN ('2017-10-14','2018-01-06','2017-10-27')

-- Filter by IN Statement (Number) (Multiple values applied to WHERE)
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Rooms] IN (3,4)

-- Filter by IN Statement (String) (Multiple values applied to WHERE)
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Suburb] IN ('Werribee','Preston')

-- Filter by LIKE Statement - Contains based on expression
-- % represents any value. 
-- Filter by ends with 'St' (Street) 'Rd'
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] LIKE ('%St')

-- Filter by contains 'Ash' anywhere
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] LIKE ('%Ash%')

-- Filter by beginning '17' anywhere
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] LIKE ('17%')

-- Filter by all that begin with 0-9
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] LIKE ('[0-9]%')

-- Filter by all that end with a-z
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] LIKE ('%[a-z]')

-- NOT LIKE The !valid operator
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] NOT LIKE ('%St')

-- NOT IN The !valid operator
SELECT	[Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Rooms] NOT IN (3,4)


-------------------------------------------------------------------------------------------------------------------

/*More Complex Filtering*/

-- Filter by first character 'A' followed by 'B' or 'L' 	(also makes displayname uppercase)
SELECT	UPPER([Suburb]) AS [Suburb]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE UPPER([Suburb]) LIKE '[A][BL]%'

-- Filter by second character should not be a number between 0-9 [^0-9] -> [0-9] would mean should be 0-9
SELECT	[Suburb]
		,[Address]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE SUBSTRING([Address],2,1) LIKE '[^0-9]'

-- Filter by full address starting from 2nd character should not start with '0-9' nor contain '/'

SELECT	[Suburb]
		,[Address]
		,LEN([Address]) AS [Address_Length]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE SUBSTRING([Address], 2, LEN([Address])) LIKE '[^0-9]%'
	AND [Address] NOT LIKE '%/%'

/*
	LTRIM - Removes any leading spaces
	RTRIM - Removes any trailing spaces
	SUBSTRING - Selects whole string starting at index 2
*/
-- From the second string, that does not contain a-z and 0-9
SELECT	[Suburb]
		,[Address]
		,LEN([Address]) AS [Address_Length]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM  [dbo].[Melbourne Housing Master]
WHERE LTRIM(RTRIM(SUBSTRING([Address],2,LEN([ADDRESS])))) LIKE '[^a-zA-Z0-9]%'

-- Find position of Set Of Characters in String
SELECT	[Suburb]
		,[Address]
FROM  [dbo].[Melbourne Housing Master]
WHERE CHARINDEX('a', [Suburb]) = 2

-- Find position of Pattern in string Returns 1 if true (First Character 'W' and second either 'AEOUI')
SELECT	[Suburb]
		,[Address]
FROM  [dbo].[Melbourne Housing Master]
WHERE PATINDEX('[W][AEOUI]%', UPPER([Suburb])) = 1

-- Filter by underscore defining character position (quick filtering)
SELECT	[Suburb]
		,[Address]
FROM  [dbo].[Melbourne Housing Master]
WHERE [Address] LIKE '______a%'



-------------------------------------------------------------------------------------------------------------------

/*Putting Data Into Tables*/
SELECT	[Suburb]
		,[Address]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
INTO	[Results 0001]
FROM	[dbo].[Melbourne Housing Master]
WHERE [Distance] < 3


-------------------------------------------------------------------------------------------------------------------

/*Order By*/
-- Order by ascending
SELECT	[Suburb]
		,[Address]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM	[dbo].[Melbourne Housing Master]
ORDER BY [Suburb] ASC

-- Order by descending
SELECT	[Suburb]
		,[Address]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM	[dbo].[Melbourne Housing Master]
ORDER BY [Final Price] DESC

-- Order by multible
SELECT	[Suburb]
		,[Address]
		,[Rooms]
		,[Date]
		,[Car]
		,[Final Price]
FROM	[dbo].[Melbourne Housing Master]
ORDER BY [Suburb] ASC
		,[Rooms] DESC


-------------------------------------------------------------------------------------------------------------------

/*Aggregating Data (Finding Values & Summarizing Datasets) GROUP BY*/

-- Math Operations - Sum of ex movie lengths by genre, if we don't do group by then it gets first genre and adds ALL SUM of length all movies
SELECT 	[genre], 
    	SUM(length) AS [sum(length)]
FROM [Movies]
GROUP BY [genre]

-- Count how often specific occurrence happens
SELECT	[Name]
		,COUNT([Name]) AS [Count]
FROM [dbo].[Pay - Female]
GROUP BY [Name]

-- Sum
SELECT	[Name]
		,SUM([Pay]) AS [Pay (Sum)]
FROM [dbo].[Pay - Female]
GROUP BY [Name]

-- Average
SELECT	[Name]
		,AVG([Pay]) AS [Pay (Average)]
FROM [dbo].[Pay - Female]
GROUP BY [Name]

-- Max, Min and range
SELECT	[Name]
		,MAX([Pay]) AS [Max Pay]
		,MIN([Pay]) AS [Min Pay]
		,(MAX([Pay]) - MIN([Pay])) AS [Pay Range]
FROM [dbo].[Pay - Female]
GROUP BY [Name]

-- Final Report
SELECT	[Name]
		,SUM([Pay]) AS [Pay (Sum)]
		,COUNT([Name]) AS [Count]
		,AVG([Pay]) AS [Pay (Average)]
		,MAX([Pay]) AS [Max Pay]
		,MIN([Pay]) AS [Min Pay]
		,(MAX([Pay]) - MIN([Pay])) AS [Pay Range]
FROM [dbo].[Pay - Female]
GROUP BY [Name]

-------------------------------------------------------------------------------------------------------------------

/*Filtering Aggregated Data - (like where but for aggregate functions)*/ 

-- Filter where sum is greater than
SELECT	[Name]
		,SUM([Pay]) AS [Pay (Sum)]
FROM [dbo].[Pay - Female]
GROUP BY [Name]
HAVING SUM([Pay]) > 6000

-- Filter where count is not equal to 3
SELECT	[Name]
		,COUNT([Name]) AS [Count]
FROM [dbo].[Pay - Female]
GROUP BY [Name]
HAVING COUNT([Name]) <> 3

-- Having and where together for combined filtering
SELECT	[Name]
		,SUM([Pay]) AS [Pay]
FROM [dbo].[Pay - Female]
WHERE [Name] IN ('Rachel','Monica')
GROUP BY [Name]
HAVING SUM([Pay]) > 3


-------------------------------------------------------------------------------------------------------------------

/*Case flags/indicators aka Switch that highlight condition met*/

-- Create 'flag sa' with boolean string values based on country cases and [category population] based on population
SELECT [Country]
      ,[Population]
      ,[Year]
      ,CASE WHEN [Country] = 'Brazil' THEN 'TRUE'
     	    WHEN [Country] = 'Ecuador' THEN 'TRUE'
     	    ELSE 'FALSE'
		END AS [Flag - SA]
      ,CASE WHEN [Population] > 100000000 THEN 'High'
     	    WHEN [Population] BETWEEN  10000000 
				AND 100000000 THEN 'Medium'
     	    WHEN [Population] < 10000000 THEN 'Low'
       	    ELSE 'N/A'
        END AS [Category Population] 
FROM [dbo].[Country Population]

--Housing CASE statement
SELECT [Suburb]
      ,[Address]
      ,[Rooms]
      ,[Final Price]
      ,[Car]
  ,CASE WHEN [Rooms] > 4 THEN 'High'
     WHEN [Rooms] < 3 THEN 'Low'
     ELSE 'Medium'
     END AS [Category - Rooms]
  ,CASE WHEN [Car] = 0 THEN 'No'
     ELSE 'Yes'
     END AS [Flag - Car]
FROM [Melbourne Housing Master]


--Putting results into a table
SELECT [Suburb]
      ,[Address]
      ,[Rooms]
      ,[Final Price]
      ,[Car]
  ,CASE WHEN [Rooms] > 4 THEN 'High'
     WHEN [Rooms] < 3 THEN 'Low'
     ELSE 'Medium'
     END AS [Category - Rooms]
  ,CASE WHEN [Car] = 0 THEN 'No'
     ELSE 'Yes'
     END AS [Flag - Car]
INTO [Case - results]
FROM [Melbourne Housing Master]


--Filtering on the table
SELECT [Suburb]
      ,[Address]
      ,[Rooms]
      ,[Final Price]
      ,[Car]
      ,[Category - Rooms]
      ,[Flag - Car]
  FROM [Case - results]
  WHERE [Category - Rooms] = 'Medium'
    AND [Flag - Car] = 'Yes'

-------------------------------------------------------------------------------------------------------------------

/*Appending Data (Tables)*/
/*Ensure data column names and data types are the same (obviously)*/

-- Keeping duplicates Union All
SELECT	[Name]
		,[Pay]
FROM [dbo].[Pay - Female]

UNION ALL

SELECT	[Name]
		,[Pay]
FROM [dbo].[Pay - Male]

-- Removing duplicates Union All
SELECT	[Name]
		,[Pay]
FROM [dbo].[Pay - Female]

UNION

SELECT	[Name]
		,[Pay]
FROM [dbo].[Pay - Male]



-------------------------------------------------------------------------------------------------------------------

/*Joining Tables*/
/*Primary table with child table becomes the joined table*/

--INNER Join -> If key value is present in both tables, then that table is returned
SELECT A.[Shop ID]
      ,A.[Shop Name]
      ,A.[Shop Region]
      ,A.[Revenue]
      ,A.[Profit]
      ,B.[No  of Employees]
      ,B.[Shop Size (Square Ft)]
FROM [Joins - 1 Key - Table 1] AS A
INNER JOIN [Joins - 1 Key - Table 2 - Inner] AS B
  ON A.[Shop ID] = B.[Shop ID]

--LEFT Join -> Left table + Matching Key values from right table is returned
SELECT A.[Shop ID]
      ,A.[Shop Name]
      ,A.[Shop Region]
      ,A.[Revenue]
      ,A.[Profit]
      ,B.[No  of Employees]
      ,B.[Shop Size (Square Ft)]
FROM [Joins - 1 Key - Table 1] AS A
LEFT JOIN [Joins - 1 Key - Table 2 - Left] AS B
  ON A.[Shop ID] = B.[Shop ID]

--RIGHT Join - Opposite of Left join
SELECT A.[Shop ID]
      ,A.[Shop Name]
      ,A.[Shop Region]
      ,A.[Revenue]
      ,A.[Profit]
      ,B.[No  of Employees]
      ,B.[Shop Size (Square Ft)]
FROM [Joins - 1 Key - Table 1] AS A
RIGHT JOIN [Joins - 1 Key - Table 2 - Right] AS B
  ON A.[Shop ID] = B.[Shop ID]

--FULL OUTER Join -> Returns everything, all values from both basically, like one big merge
SELECT A.[Shop ID]
      ,A.[Shop Name]
      ,A.[Shop Region]
      ,A.[Revenue]
      ,A.[Profit]
  ,B.[No  of Employees]
  ,B.[Shop Size (Square Ft)]
FROM [Joins - 1 Key - Table 1] AS A
FULL OUTER JOIN [Joins - 1 Key - Table 2 - Outer] AS B
  ON A.[Shop ID] = B.[Shop ID]

--UNMATCHING Join -> Returns Everything EXCEPT the matching ones. So the ones that do not match between both
SELECT A.[Shop ID]
      ,A.[Shop Name]
      ,A.[Shop Region]
      ,A.[Revenue]
      ,A.[Profit]
  ,B.[No  of Employees]
  ,B.[Shop Size (Square Ft)]
FROM [Joins - 1 Key - Table 1] AS A
FULL OUTER JOIN [Joins - 1 Key - Table 2 - Outer] AS B
  ON A.[Shop ID] = B.[Shop ID]
WHERE A.[Shop ID] IS NULL
   OR B.[Shop ID] IS NULL

--Joining using multiple fields
SELECT A.[Shop ID]
      ,A.[Shop Name]
      ,A.[Shop Region]
      ,A.[Revenue]
      ,A.[Profit]
      ,B.[No  of Employees]
      ,B.[Shop Size (Square Ft)]
FROM [Joins - 2 Keys - Table 1] AS A
LEFT JOIN [Joins - 2 Keys - Table 2] AS B
  ON A.[Shop ID] = B.[Shop ID]
  AND A.[Department] = B.[Department]

--Considering additional join keys
SELECT A.[User ID]      
      ,A.[Corporate ID]
      ,A.[Department]
      ,B.[User ID]        AS User_ID_table_B
      ,B.[Expense Claim]
FROM [dbo].[Joins - Left Table - OR Statement] AS A
LEFT JOIN [dbo].[Joins - Right Table - OR Statement] AS B
  ON (A.[User ID] = B.[User ID]) OR (A.[Corporate ID] = B.[User ID]) 

-------------------------------------------------------------------------------------------------------------------

/*FINAL - Joining Male and Female Pay table together*/
SELECT	[Name]
		,[Pay]
INTO [Pay - Appended]
FROM [dbo].[Pay - Female]

UNION ALL

SELECT	[Name]
		,[Pay]
FROM [dbo].[Pay - Male]