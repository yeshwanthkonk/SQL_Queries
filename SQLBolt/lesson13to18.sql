
/*
SQL Lesson 13: Inserting rows

Exercise
In this exercise, we are going to play studio executive and add a few movies to the Movies to our portfolio. 
In this table, the Id is an auto-incrementing integer, so you can try inserting a row with only the other columns defined.

Since the following lessons will modify the database, you'll have to manually run each query once they are ready to go.

Table: Movies (Read-Only)
Id	Title	Director	Year	Length_minutes

Table: Boxoffice (Read-Only)
Movie_id	Rating	Domestic_sales	International_sales
*/

--Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
insert into movies
(title, director)
values ("Toy Story 4", "John L")

--Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
insert into boxoffice
values (15, 8.7, 340, 270);

/*
SQL Lesson 14: Updating rows

Update statement with values
UPDATE mytable
SET column = value_or_expr, 
    other_column = another_value_or_expr, 
    …
WHERE condition;

Exercise
It looks like some of the information in our Movies database might be incorrect, so go ahead and fix them through the exercises below.
*/

--The director for A Bug's Life is incorrect, it was actually directed by John Lasseter 
update movies set director = 'John Lasseter' where title = "A Bug's Life";

--The year that Toy Story 2 was released is incorrect, it was actually released in 1999
update movies set year = 1999 where title = "Toy Story 2";

--Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
update movies set director = "Lee Unkrich", title='Toy Story 3' where title = "Toy Story 8";

/*
SQL Lesson 15: Deleting rows

Delete statement with condition
DELETE FROM mytable
WHERE condition;

Exercise
The database needs to be cleaned up a little bit, so try and delete a few rows in the tasks below.

*/

--This database is getting too big, lets remove all movies that were released before 2005.
DELETE from movies where year < 2005;

--Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE from movies where director = "Andrew Stanton";

/*
SQL Lesson 16: Creating tables

Create table statement w/ optional table constraint and default value
CREATE TABLE IF NOT EXISTS mytable (
    column DataType TableConstraint DEFAULT default_value,
    another_column DataType TableConstraint DEFAULT default_value,
    …
);

Exercise
In this exercise, you'll need to create a new table for us to insert some new rows into.
*/

--Create a new table named Database with the following columns:
-- – Name A string (text) describing the name of the database
-- – Version A number (floating point) of the latest version of this database
-- – Download_count An integer count of the number of times this database was downloaded

CREATE TABLE Database (Name text, Version FLOAT, Download_count INT);

/*
SQL Lesson 17: Altering tables

Altering table to add new column(s)
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint 
    DEFAULT default_value;
    
Altering table to remove column(s)
ALTER TABLE mytable
DROP column_to_be_deleted;

Altering table name
ALTER TABLE mytable
RENAME TO new_table_name;

Exercise
Our exercises use an implementation that only support adding new columns, so give that a try below.
*/

--Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in. 
alter table movies add Aspect_ratio FLOAT;

--Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
alter table movies add Language TEXT default 'English';

/*
SQL Lesson 18: Dropping tables

Drop table statement
DROP TABLE IF EXISTS mytable;

Exercise
We've reached the end of our exercises, so lets clean up by removing all the tables we've worked with.

*/

--We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE IF EXISTS Movies;

--And drop the BoxOffice table as well
DROP TABLE IF EXISTS BoxOffice;
