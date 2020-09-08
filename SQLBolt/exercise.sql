
/*
In the exercise below, you will be working with a different table. 
This table instead contains information about a few of the most populous cities of North America[1] including their population and geo-spatial location in the world.
[1] -> http://en.wikipedia.org/wiki/List_of_North_American_cities_by_population

Did you know?
Positive latitudes correspond to the northern hemisphere, and positive longitudes correspond to the eastern hemisphere. 
Since North America is north of the equator and west of the prime meridian, all of the cities in the list have positive latitudes and negative longitudes.
*/

-- List all the cities west of Chicago, ordered from west to east.
SELECT * FROM north_american_cities where longitude<(select longitude from north_american_cities where city='Chicago') order by longitude asc;

--List the two largest cities in Mexico (by population)
SELECT City FROM north_american_cities where country = 'Mexico' order by population desc limit 2;

--List the third and fourth largest cities (by population) in the United States and their population
SELECT * FROM north_american_cities where country='United States' order by population desc limit 2 offset 2;

/*
We've added a new table to the Pixar database so that you can try practicing some joins. 
The BoxOffice table stores information about the ratings and sales of each particular Pixar movie, 
and the Movie_id column in that table corresponds with the Id column in the Movies table 1-to-1. 
Try and solve the tasks below using the INNER JOIN introduced above.

Table: Movies (Read-Only) ->
Id	Title	Director	Year	Length_minutes

Table: Boxoffice (Read-Only)
Movie_id	Rating	Domestic_sales	International_sales
*/
--Find the domestic and international sales for each movie
SELECT title, domestic_sales, international_sales FROM movies m inner join boxoffice b on m.id = b.movie_id;

--Show the sales numbers for each movie that did better internationally rather than domestically
SELECT title, domestic_sales, international_sales FROM movies m inner join boxoffice b on m.id = b.movie_id where international_sales>domestic_sales;

--List all the movies by their ratings in descending order
SELECT * FROM movies m inner join boxoffice b on m.id = b.movie_id order by rating desc;

/*
In this exercise, you are going to be working with a new table which stores fictional data about Employees in the film studio and their assigned office Buildings. 
Some of the buildings are new, so they don't have any employees in them yet, but we need to find some information about them regardless.

Since our browser SQL database is somewhat limited, only the LEFT JOIN is supported in the exercise below.

Table: Buildings (Read-Only)
Building_name	Capacity

Table: Employees (Read-Only)
Role	Name	Building	Years_employed
*/

--Find the list of all buildings that have employees
SELECT distinct building FROM employees e left join buildings b on e.building = b.building_name;
SELECT distinct building FROM employees;

--Find the list of all buildings and their capacity
SELECT distinct building_name, capacity FROM buildings b left join employees e on e.building = b.building_name;
SELECT building_name, capacity FROM buildings;

--List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT distinct building_name, role FROM buildings b left join employees e on e.building = b.building_name;

/*
This exercise will be a sort of review of the last few lessons. 
We're using the same Employees and Buildings table from the last lesson, but we've hired a few more people, who haven't yet been assigned a building.
*/

--Find the name and role of all employees who have not been assigned to a building
SELECT name, role FROM employees where building is null;

--Find the names of the buildings that hold no employees
SELECT building_name FROM buildings b left join employees e on building_name = e.building where name is null;
