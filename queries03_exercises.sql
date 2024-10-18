--Show first name, last name, and gender of patients whose gender is 'M'
SELECT	[first_name]
		,[last_name]
        ,[gender]
FROM [patients]
WHERE [Gender] = 'M'

--Show first name and last name of patients who does not have allergies. (null)
SELECT 	[first_name]
		,[last_name]
FROM [patients]
WHERE [allergies] IS NULL

--Show first name of patients that start with the letter 'C'
SELECT [first_name]
FROM [patients]
WHERE [first_name] LIKE('C%')

--Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select 
	[first_name]
    ,[last_name]
FROM [patients]
WHERE [weight] >= 100 AND [weight] <= 120

--Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE [patients]
SET [allergies] = 'NKA'
WHERE [allergies] IS NULL

--Show first name and last name concatinated into one column to show their full name.
SELECT
	concat([first_name], ' ', [last_name]) AS [full_name]
FROM [patients]

--Show first name, last name, and the full province name of each patient.
--Example: 'Ontario' instead of 'ON'
SELECT
	A.[first_name]
    ,A.[last_name]
    ,B.[province_name]
FROM [patients] AS A
LEFT JOIN [province_names] AS B
	ON A.[province_id] = B.[province_id]

--Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT([patient_id])
FROM [patients]
WHERE YEAR([birth_date]) = 2010

--Show the first_name, last_name, and height of the patient with the greatest height.
    -- More understandable
    SELECT
        [first_name]
        ,[last_name]
        ,[height]
    FROM 
        [patients]
    WHERE
        [height] = (select MAX([height]) FROM [patients])
    -- Cleaner but i dont quite get it in my head
    SELECT
        [first_name],
        [last_name],
        MAX([height]) AS [height]
    FROM [patients]

--Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000
SELECT *
FROM [patients]
WHERE [patient_id] IN(1,45,534,879,1000)

--Show the total number of admissions
SELECT COUNT(*) AS [total_admissions]
FROM [admissions]

--Show all the columns from admissions where the patient was admitted and discharged on the same day.
select *
FROM [admissions]
WHERE [admission_date] = [discharge_date]

--Show the patient id and the total number of admissions for patient_id 579.
SELECT
	[patient_id],
    count(*)
FROM [admissions]
WHERE [patient_id] = 579

--Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT distinct [city]
FROM [patients]
where [province_id] = 'NS'

--Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
SELECT
	[first_name],
    [last_name],
    [allergies]
FROM [patients]
WHERE [allergies] IS NOT NULL 
	AND city = 'Hamilton'

