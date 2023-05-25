--Q1
SELECT *
FROM data_analyst_jobs;
--1793 rows

--Q2
SELECT company
FROM data_analyst_jobs
LIMIT 10;
--ExxonMobil

--Q3 How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY');
--27

SELECT 
	COUNT(CASE WHEN location='TN' THEN location END) AS jobs_in_TN,
	COUNT(CASE WHEN location='KY' THEN location END) AS jobs_in_KY,
--ROM data_analyst_jobs;
--TN 21 KY/TN = 27

--Q4 How many postings in Tennessee have a star rating above 4?  
--SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location IN ('TN') AND star_rating >4;
--3

--Q5 How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 and 1000;
--151

--Q6 Show the average star rating for companies in each state. The output should show 
--the state as `state` and the average rating for the state as `avg_rating`. 
--Which state shows the highest average rating?
SELECT company, location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT null AND star_rating IS NOT null
GROUP BY company, location
ORDER BY avg_rating DESC
LIMIT 10;

--
Q7 Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT DISTINCT(title)
FROM data_analyst_jobs;
--881

--8.	How many unique job titles are there for California companies?

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE location IN ('CA');
--230

--9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT Null
GROUP BY company
HAVING SUM(review_count)>5000;
--70

--10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT null
GROUP BY company
ORDER BY avg_rating DESC;
--Unilever 4.2

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT Null
GROUP BY company
HAVING SUM(review_count)>5000
ORDER BY avg_rating DESC;
--70 Google & Disney

--11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--774
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--1669 

--12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT DISTINCT(title) AS jobs_not_analyst_analytics
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%'
ORDER BY jobs_not_analyst_analytics;
--4 Tableau

**BONUS:**
You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
 - Disregard any postings where the domain is NULL. 
 - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
  - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?