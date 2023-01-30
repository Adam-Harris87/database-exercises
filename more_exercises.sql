USE sakila;
SHOW TABLES;

-- 1a Select all columns from the actor table.
SELECT * FROM actor;

-- 1b Select only the last_name column from the actor table.
SELECT last_name FROM actor;

-- 1c Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year FROM film;

-- 2a Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name FROM actor;

DESCRIBE address;
-- 2b Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code FROM address;

DESCRIBE film;
-- 2c Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating FROM film;

SELECT length from film LIMIT 5;
-- 3a Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length FROM film WHERE length >= 180;

-- 3b Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
DESCRIBE payment;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27';

-- 3c Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date LIKE '2005-05-27%';

-- 3d Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
DESCRIBE customer;
SELECT * FROM customer WHERE (last_name LIKE 's%') AND (first_name LIKE '%n');

-- 3e Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT * FROM customer WHERE (active = 0) OR (last_name LIKE 'm%');

-- 3f Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
DESCRIBE category;
SELECT * from category WHERE (category_id > 4) 
	AND (name LIKE 'c%' OR name LIKE 's%' OR name LIKE 't%');

-- 3g Select all columns minus the password column from the staff table for rows that contain a password.
DESCRIBE staff;
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
	FROM staff WHERE password IS NOT NULL;
	
-- 3h Select all columns minus the password column from the staff table for rows that do not contain a password.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
	FROM staff WHERE password IS NULL;

-- 4a Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
DESCRIBE address;
SELECT * FROM address LIMIT 5;
SELECT phone, district FROM address WHERE district 
	IN ('California', 'England', 'Taipei', 'West Java');

/* 4b Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.) */
SELECT payment_id, amount, payment_date FROM payment 
	WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

-- 4c Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5a Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * FROM payment WHERE payment_date 
	BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

-- 5b Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
SELECT film_id, title, description FROM film 
	WHERE LENGTH(description) BETWEEN 100 AND 120;

-- 6a Select the following columns from the film table for rows where the description begins with "A Thoughtful".
SELECT * FROM film WHERE description LIKE 'A Thoughtful%';

-- 6b Select the following columns from the film table for rows where the description ends with the word "Boat".
SELECT * FROM film WHERE description LIKE '%Boat';

-- 6c Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
SELECT * FROM film WHERE (description LIKE '%Database%') AND (length > 180);

-- 7a Select all columns from the payment table and only include the first 20 rows.
SELECT * FROM payment LIMIT 20;

-- 7b Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
SELECT payment_date, amount FROM payment WHERE (amount > 5)
	LIMIT 1001 OFFSET 999;
	
-- 7c Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
SELECT * FROM customer LIMIT 100 OFFSET 100;

-- 8a Select all columns from the film table and order rows by the length field in ascending order.
SELECT * FROM film ORDER BY length;

-- 8b Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating FROM film ORDER BY rating DESC;

-- 8c Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
SELECT payment_date, amount FROM payment 
	ORDER BY amount DESC LIMIT 20;
	
-- 8d Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
DESCRIBE film;
SELECT special_features FROM film LIMIT 5;
SELECT title, description, special_features, length, rental_duration FROM film 
	WHERE (special_features LIKE '%Behind the Scenes%') AND (length < 120)
	AND (rental_duration BETWEEN 5 AND 7)
	ORDER BY length DESC;
    
/* 9a Select customer first_name/last_name and actor first_name/last_name columns from performing a left join 
between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion. */
DESCRIBE customer;
DESCRIBE actor;
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, a.last_name AS actor_last_name
	FROM customer c
		LEFT JOIN actor a 
        ON c.last_name = a.last_name
	ORDER BY c.last_name;
        
/* 9b Select the customer first_name/last_name and actor first_name/last_name columns from performing 
a /right join between the customer and actor column on the last_name column in each table. 
(i.e. customer.last_name = actor.last_name) */
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, a.last_name AS actor_last_name
	FROM customer c
		RIGHT JOIN actor a 
        ON c.last_name = a.last_name
	ORDER BY a.last_name;
        
/* 9c Select the customer first_name/last_name and actor first_name/last_name columns from performing 
an inner join between the customer and actor column on the last_name column in each table. 
(i.e. customer.last_name = actor.last_name) */
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, a.last_name AS actor_last_name
	FROM customer c
		JOIN actor a 
        ON c.last_name = a.last_name
	ORDER BY c.last_name;
        
/* 9d Select the city name and country name columns from the city table, performing 
a left join with the country table to get the country name column. */
DESCRIBE city;
DESCRIBE country;
SELECT ci.city, co.country 
	FROM city ci
		LEFT JOIN country co
        ON ci.country_id = co.country_id;
        
/* 9e Select the title, description, release year, and language name columns from the film table, performing 
a left join with the language table to get the "language" column. */
DESCRIBE film;
DESCRIBE language;
SELECT f.title, f.description, f.release_year, l.name
	FROM film f
		LEFT JOIN language l
		ON f.language_id = l.language_id;
        
/* 9f Select the first_name, last_name, address, address2, city name, district, and postal code columns 
from the staff table, performing 2 left joins with the address table then the city table to 
get the address and city related columns. */
DESCRIBE staff;
DESCRIBE address;
DESCRIBE city;
SELECT s.first_name, s.last_name, a.address, a.address2, c.city, a.district, a.postal_code
	FROM staff s
		LEFT JOIN address a
        ON s.address_id = a.address_id
        LEFT JOIN city c
        ON a.city_id = c.city_id;
        
-- 2.1 Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER(last_name)
	FROM actor;
    
/* 2.2 You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
What is one query would you could use to obtain this information? */
DESCRIBE actor;
SELECT actor_id, first_name, last_name
	FROM actor
    WHERE first_name = 'Joe';
    
-- 2.3 Find all actors whose last name contain the letters "gen":
SELECT * FROM actor
	WHERE last_name LIKE '%gen%';

/* 2.4 Find all actors whose last names contain the letters "li". 
This time, order the rows by last name and first name, in that order. */
SELECT * FROM actor
	WHERE last_name LIKE '%li%'
    ORDER BY last_name, first_name;
    
/* 2.5 Using IN, display the country_id and country columns for the following 
countries: Afghanistan, Bangladesh, and China: */
SELECT country_id, country FROM country
	WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
-- 2.6 List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) 
	FROM actor
    GROUP BY last_name;
    
/* 2.7 List last names of actors and the number of actors who have that last name, 
but only for names that are shared by at least two actors */
SELECT last_name, COUNT(last_name) 
	FROM actor
    GROUP BY last_name
    HAVING COUNT(last_name) >= 2;
    
-- 2.8 You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 2.9 Use JOIN to display the first and last names, as well as the address, of each staff member.
DESCRIBE staff;
DESCRIBE address;
SELECT s.first_name, s.last_name, a.address
	FROM staff s
		JOIN address a
        ON s.address_id = a.address_id;
        
-- 2.10 Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT s.first_name, s.last_name, COUNT(p.amount) AS total_amount
	FROM staff s
		LEFT JOIN payment p
        ON s.staff_id = p.staff_id
	GROUP BY s.staff_id;
    
-- 2.11 List each film and the number of actors who are listed for that film.
DESCRIBE film;
DESCRIBE actor;
SHOW tables;
DESCRIBE film_actor;
SELECT f.title, COUNT(fa.actor_id) AS num_actors
	FROM film f
		JOIN film_actor fa
        ON f.film_id = fa.film_id
	GROUP BY f.title
    ORDER BY f.title;

-- 2.12 How many copies of the film Hunchback Impossible exist in the inventory system?
DESCRIBE inventory;
DESCRIBE film;
DESCRIBE store;
SELECT f.title, COUNT(i.film_id) AS num_copies
	FROM film f
		JOIN inventory i
		ON f.film_id = i.film_id
	WHERE f.title = 'Hunchback Impossible';
    
/* 2.13 The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. */
