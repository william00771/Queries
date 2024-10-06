
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

