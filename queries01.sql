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

/* Filtering Data - Where */
