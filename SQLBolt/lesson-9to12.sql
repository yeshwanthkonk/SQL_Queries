/*
SQL Lesson 9: Queries with expressions

Example query with expressions
SELECT particle_speed / 2.0 AS half_particle_speed
FROM physics_data
WHERE ABS(particle_position) * 10.0 > 500;

Exercise
You are going to have to use expressions to transform the BoxOffice data into something easier to understand for the tasks below.

Table: Movies (Read-Only)
Id	Title	Director	Year	Length_minutes

Table: Boxoffice (Read-Only)
Movie_id	Rating	Domestic_sales	International_sales
*/

--List all movies and their combined sales in millions of dollars
SELECT title, (domestic_sales + international_sales) / 1000000 AS gross_sales_millions FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id;

--List all movies and their ratings in percent
SELECT title, rating*10 as percent FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id;

--List all movies that were released on even number years
SELECT * from movies where year%2 = 0

/*
SQL Lesson 10: Queries with aggregates (Pt. 1)

Select query with aggregate functions over groups
SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
FROM mytable
WHERE constraint_expression
GROUP BY column;

Exercise
For this exercise, we are going to work with our Employees table. 
Notice how the rows in this table have shared data, which will give us an opportunity to use aggregate functions to summarize some high-level metrics about the teams. 
Go ahead and give it a shot.
*/

--Find the longest time that an employee has been at the studio
SELECT *, max(years_employed) FROM employees;

--For each role, find the average number of years employed by employees in that role
SELECT role, avg(years_employed) FROM employees group by role;

--Find the total number of employee years worked in each building
SELECT *, sum(years_employed) FROM employees group by building;

/*
SQL Lesson 11: Queries with aggregates (Pt. 2)

Select query with HAVING constraint
SELECT group_by_column, AGG_FUNC(column_expression) AS aggregate_result_alias, …
FROM mytable
WHERE condition
GROUP BY column
HAVING group_condition;

Exercise
For this exercise, you are going to dive deeper into Employee data at the film studio. Think about the different clauses you want to apply for each task.
*/

--Find the number of Artists in the studio (without a HAVING clause)
SELECT count(role) FROM employees where role = 'Artist';

--Find the number of Employees of each role in the studio
SELECT role, count(role) FROM employees group by role;

--Find the total number of years employed by all Engineers
SELECT role, sum(years_employed) FROM employees group by role having role = 'Engineer';
SELECT role, sum(years_employed) FROM employees where role = 'Engineer';

/*
SQL Lesson 12: Order of execution of a Query

Exercise
Here ends our lessons on SELECT queries, congrats of making it this far! This exercise will try and test your understanding of queries, 
so don't be discouraged if you find them challenging. Just try your best.
*/

--Find the number of movies each director has directed
SELECT director, count(title) as count FROM movies group by director;

--Find the total domestic and international sales that can be attributed to each director
SELECT director, sum(domestic_sales+international_sales) as count FROM movies m join boxoffice b on m.id = b.movie_id group by director;
