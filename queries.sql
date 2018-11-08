-- One to one relationship 
-- A person will have one social security number. A social security number is unique to each person and will never point to multiple people and each person will only have one social security number at a time

-- One to many relationship 
-- A customer may have many orders while each order will be specific to that person. 

-- Many to Many relationship
-- Students to classes is a great example of a many to many relationship. A student may take multiple classes and each class will have multiple students. You would use a seperate third table as a join table between classes and students because it doesn't make sense to keep the foreign key colums living in students. What happens if they add another class? Should you go back and alter the students table adding a column each time this happens? Same with classes. You dont want to be altering the classes table each time a new student joins. A third table that references both tables solves this problem

-- Creating a table that references (foreign key) another table. Each movie will reference the director table. Foreign keys are how we establish relationships between tables. A foreign key will point to a primary key in another table
create table director (
    id INTEGER PRIMARY KEY,
    name TEXT 
)

CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    title TEXT,
    imdbRating INTEGER,
    directorId INTEGER REFERENCES director(id)
)

-- Creating a table and altering it later to add a foreign key 
CREATE TABLE budget (
    id INTEGER PRIMARY KEY,
    amountBudgeted DECIMAL
)

ALTER TABLE budget 
ADD COLUMN movieId INTEGER REFERENCES movies(id)

-- Using a join statement to connect two tables using a foreign key
-- The on statement defines how the two tables are connecting to each other. One is the foreign key and the other is the primary key that the foreign key is pointing to. In this case album.ArtistId points to artist.ArtistId
SELECT * FROM Artist a
JOIN Album al
ON al.ArtistId = a.ArtistId

-- Using a sub select to run a query that will return a sub set of rows and then running another query on that smaller set of rows
SELECT * FROM Artist a
JOIN Album al
ON al.ArtistId = a.ArtistId
WHERE a.ArtistId IN (
	SELECT ArtistId FROM Artist 
  	WHERE Name LIKE 'A%'
)

-- Using group by along with an aggregate function to get a count of the total numbers of albums each artist has
SELECT a.Name, count(al.AlbumId) FROM Artist a
JOIN Album al
ON al.ArtistId = a.ArtistId
GROUP BY a.Name

-- Using having (which acts as a second where clause) to get only artists that have more than 2 albums 
SELECT a.Name, count(al.AlbumId) FROM Artist a
JOIN Album al
ON al.ArtistId = a.ArtistId
GROUP BY a.Name
HAVING count(al.AlbumId) > 2

-- Updating existing rows 
UPDATE Invoice 
SET Total = 1000000.99
WHERE CustomerId = 2