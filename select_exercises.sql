USE albums_db;

DESCRIBE albums;
-- 3 id, artist, name, release_date, sales, genre

SELECT COUNT(id) FROM albums;
-- 3a There are 31 rows in albums

SELECT COUNT(DISTINCT(artist)) FROM albums;
-- 3b There are 23 unique artist in albums

-- 3c The id column is the primary key of albums

SELECT * FROM albums ORDER BY release_date ASC LIMIT 1;
-- 3d The oldest release date is 1967
SELECT * FROM albums ORDER BY release_date DESC LIMIT 1;
-- 3d The newest release date is 2011

SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- 4a 'The Dark Side of the Moon' and 'The Wall'

SELECT release_date FROM albums WHERE name LIKE 'Sgt. Pepper%';
-- 4b 'Sgt. Pepper's Lonely Hearts Club Band' was released in 1967

SELECT genre FROM albums WHERE name = 'Nevermind';
-- 4c The genre for 'Nevermind' is Grunge, Alternative rock

SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
/* 4d There were 11 albums released in the 1990s
Come On Over
Dangerous
Falling into You
Jagged Little Pill
Let's Talk About Love
Metallica
Nevermind
Supernatural
The Bodyguard
The Immaculate Collection
Titanic: Music from the Motion Picture */

SELECT name FROM albums WHERE sales < 20;
/* 4e There were 13 albums with less than 20 million sales
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall */

SELECT name FROM albums WHERE genre = 'Rock';
/* 4f There are 5 albums with the genre 'Rock'
Sgt. Pepper's Lonely Hearts Club Band
1
Abbey Road
Born in the U.S.A.
Supernatural
	The query does not include "Hard rock" or "Progressive rock"
	because they are not an exact match to "Rock" */