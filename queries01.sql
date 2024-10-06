/* Select and From */
-- Select everything
SELECT	*
FROM	[dbo].[Melbourne Housing Master]

-- Select Specific
SELECT	[Suburb]
		,[Address]
		,[Rooms]
FROM	[dbo].[Melbourne Housing Master]

-- Renaming Columns (DisplayName)
SELECT	[Suburb] AS [Förort]
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



-------------------------------------------------------------------------------------------------------------------

/*Linking Tables*/