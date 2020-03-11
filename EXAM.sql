--SQL self-sufficiency exam


--The scenario
--You are a data analyst for your state’s department of education. 
--You're given a database containing 2 tables: naep and finance. 
--NAEP is the National Assessment of Educational Progress for states. 
--The naep table contains each state’s average NAEP scores in math and reading for students in grades 4 and 8 for various years between 1992 and 2017. 
--The finance table contains each state’s total K-12 education revenue and expenditures for the years 1992 through 2016.

--You are tasked with assessing the quality of this data. You must also find useful ways to analyze it.

-- Query prompts
--Below, you'll find 9 numbered prompts. Each prompt will require you to write a SQL query. 
--These prompts are split up into 2 distinct sections focusing on data exploration and data analysis.

--Data exploration
--You'll begin your analysis with the naep table. It's always a good idea to get a better understanding of your data BEFORE doing any analysis. 
--This allows you to gather key insights before you jump into any complex operations. 
--You'll want to know what columns are reported in your data, what the data types are for each column, and what the first few observations look like.

--1- Write a query that allows you to inspect the schema of the naep table.

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep';

--2- Write a query that returns the first 50 records of the naep table.

SELECT *
FROM naep
LIMIT 50;

--3- Write a query that returns summary statistics for avg_math_4_score by state. 
--   Make sure to sort the results alphabetically by state name.

SELECT state, COUNT(avg_math_4_score), MAX(avg_math_4_score), MIN(avg_math_4_score), ROUND(AVG(avg_math_4_score),2)
FROM naep
GROUP BY state
ORDER BY state;

--4- Write a query that alters the previous query so that it returns only the summary statistics for avg_math_4_score by state with differences in max and min values that are greater than 30.

SELECT state, COUNT(avg_math_4_score), MAX(avg_math_4_score), MIN(avg_math_4_score), ROUND(AVG(avg_math_4_score),2)
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY state;



--Analyzing your data
--Now that you've gathered key insights about your data, you're ready to do some analysis! 
--You want to report the bottom 10 performing states for avg_math_4_score in the year 2000. 
--You also want to report the states that scored below the average avg_math_4_score over all states in the year 2000.

--5-Write a query that returns a field called bottom_10_states that lists the states in the bottom 10 for avg_math_4_score in the year 2000.

SELECT state AS bottom_10_states, avg_math_4_score
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score
LIMIT 10;

--6- Write a query that calculates the average avg_math_4_score rounded to the nearest 2 decimal places over all states in the year 2000.

SELECT ROUND(AVG(avg_math_4_score),2) AS avg_score
FROM naep
WHERE year = 2000;

--7- Write a query that returns a field called below_average_states_y2000 that lists all states with an avg_math_4_score less than the average over all states in the year 2000.

SELECT state AS below_average_states_y2000, avg_math_4_score
FROM naep
WHERE avg_math_4_score <



--8- Write a query that returns a field called scores_missing_y2000 that lists any states with missing values in the avg_math_4_score column of the naep data table for the year 2000.


SELECT state AS scores_missing_y2000, avg_math_4_score 
FROM naep
WHERE year = 2000 AND avg_math_4_score IS NULL
GROUP BY state,avg_math_4_score; 


--9- Write a query that returns for the year 2000 the state, avg_math_4_score, and total_expenditure from the naep table left outer joined with the finance table, using id as the key and ordered by total_expenditure greatest to least. 
--Be sure to round avg_math_4_score to the nearest 2 decimal places, and then filter out NULL avg_math_4_scores in order to see any correlation more clearly.

SELECT naep.state, ROUND(avg_math_4_score,2), total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND ROUND(avg_math_4_score,2) IS NOT NULL
ORDER BY total_expenditure DESC;



