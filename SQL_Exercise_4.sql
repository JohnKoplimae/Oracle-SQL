-- EXERCISE QUESTIONS 4

CREATE TABLE Movies (
  Code INTEGER PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  Rating VARCHAR(255) 
);

CREATE TABLE MovieTheaters (
  Code INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Movie INTEGER,  
    FOREIGN KEY (Movie) REFERENCES Movies(Code)
);

BEGIN

INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
 INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
 INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
 INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
 INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
 INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);
 
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);

 END;
 /

 SELECT * FROM movies;
 SELECT * FROM movietheaters;

 SELECT title FROM movies; --4.1

 SELECT DISTINCT rating FROM movies; --4.2

 SELECT * FROM movies
 WHERE rating IS NULL; --4.3

SELECT * FROM movietheaters
WHERE movie IS NULL; --4.4

SELECT * FROM movietheaters T
LEFT JOIN movies M ON
T.movie = M.code; --4.5

SELECT * FROM movies M
LEFT JOIN movietheaters T ON
M.code = T.movie; --4.6

SELECT M.title FROM movies M
LEFT JOIN movietheaters T ON
T.movie = M.code
WHERE T.movie IS NULL; --4.7

INSERT INTO movies VALUES (9, 'One, Two, Three', NULL); --4.8
INSERT INTO movies(Title, Rating) VALUES ('One, Two, Three', NULL);

UPDATE movies
SET rating = 'G'
WHERE rating IS NULL; --4.9

DELETE FROM moviestheaters
WHERE movie IN (
    SELECT code FROM movie WHERE rating = 'NC-17' 
); --4.10
