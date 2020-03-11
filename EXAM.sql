--1

SELECT *
FROM naep;

--2

SELECT *
FROM naep
LIMIT 50;

--3

SELECT state, COUNT(avg_math_4_score), MAX(avg_math_4_score), MIN(avg_math_4_score), ROUND(AVG(avg_math_4_score),2)
FROM naep
GROUP BY state
ORDER BY state;

--4

SELECT state, COUNT(avg_math_4_score), MAX(avg_math_4_score), MIN(avg_math_4_score), ROUND(AVG(avg_math_4_score),2)
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY state;

--5

SELECT state AS bottom_10_states, avg_math_4_score 
FROM naep
WHERE year = 2000
GROUP BY state, avg_math_4_score 
ORDER BY avg_math_4_score 
LIMIT 10;

--6

SELECT ROUND(AVG(avg_math_4_score),2) AS avg_score
FROM naep
WHERE year = 2000;

--7

SELECT state AS below_average_states_y2000 , avg_math_4_score
FROM naep
WHERE year = 2000 AND avg_math_4_score < 224.8
GROUP BY state, avg_math_4_score
ORDER BY avg_math_4_score;



--8


SELECT state AS scores_missing_y2000, avg_math_4_score 
FROM naep
WHERE year = 2000 AND avg_math_4_score IS NULL
GROUP BY state,avg_math_4_score; 


--9

SELECT naep.state, ROUND(avg_math_4_score,2), total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND ROUND(avg_math_4_score,2) IS NOT NULL
ORDER BY total_expenditure DESC;



