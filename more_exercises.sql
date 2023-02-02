USE sakila;
SHOW TABLES;

-- 1.1a Select all columns from the actor table.
SELECT * FROM actor;

-- 1.1b Select only the last_name column from the actor table.
SELECT last_name FROM actor;

-- 1.1c Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year FROM film;

-- 1.2a Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name FROM actor;

DESCRIBE address;
-- 1.2b Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code FROM address;

DESCRIBE film;
-- 1.2c Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating FROM film;

SELECT length from film LIMIT 5;
-- 1.3a Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length FROM film WHERE length >= 180;

-- 1.3b Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
DESCRIBE payment;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27';

-- 1.3c Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date LIKE '2005-05-27%';

-- 1.3d Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
DESCRIBE customer;
SELECT * FROM customer WHERE (last_name LIKE 's%') AND (first_name LIKE '%n');

-- 1.3e Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT * FROM customer WHERE (active = 0) OR (last_name LIKE 'm%');

/* 1.3f Select all columns from the category table for rows where the primary key is greater than 4 and the name 
field begins with either C, S or T. */
DESCRIBE category;
SELECT * from category WHERE (category_id > 4) 
	AND (name LIKE 'c%' OR name LIKE 's%' OR name LIKE 't%');

-- 1.3g Select all columns minus the password column from the staff table for rows that contain a password.
DESCRIBE staff;
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
	FROM staff WHERE password IS NOT NULL;
	
-- 1.3h Select all columns minus the password column from the staff table for rows that do not contain a password.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
	FROM staff WHERE password IS NULL;

-- 1.4a Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
DESCRIBE address;
SELECT * FROM address LIMIT 5;
SELECT phone, district FROM address WHERE district 
	IN ('California', 'England', 'Taipei', 'West Java');

/* 1.4b Select the payment id, amount, and payment date columns from the payment table for payments made 
on 05/25/2005, 05/27/2005, and 05/29/2005. 
(Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.) */
SELECT payment_id, amount, payment_date FROM payment 
	WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

-- 1.4c Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 1.5a Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * FROM payment WHERE payment_date 
	BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

/* 1.5b Select the film_id, title, and descrition columns from the film table for films where the length of the 
description is between 100 and 120. */
SELECT film_id, title, description FROM film 
	WHERE LENGTH(description) BETWEEN 100 AND 120;

-- 1.6a Select the following columns from the film table for rows where the description begins with "A Thoughtful".
SELECT * FROM film WHERE description LIKE 'A Thoughtful%';

-- 1.6b Select the following columns from the film table for rows where the description ends with the word "Boat".
SELECT * FROM film WHERE description LIKE '%Boat';

/* 1.6c Select the following columns from the film table where the description contains the word "Database" 
and the length of the film is greater than 3 hours. */
SELECT * FROM film WHERE (description LIKE '%Database%') AND (length > 180);

-- 1.7a Select all columns from the payment table and only include the first 20 rows.
SELECT * FROM payment LIMIT 20;

/* 1.7b Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, 
and only select rows whose zero-based index in the result set is between 1000-2000. */
SELECT payment_date, amount FROM payment WHERE (amount > 5)
	LIMIT 1001 OFFSET 999;
	
-- 1.7c Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
SELECT * FROM customer LIMIT 100 OFFSET 100;

-- 1.8a Select all columns from the film table and order rows by the length field in ascending order.
SELECT * FROM film ORDER BY length;

-- 1.8b Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating FROM film ORDER BY rating DESC;

/* 1.8c Select the payment date and amount columns from the payment table for the first 20 payments 
ordered by payment amount in descending order. */
SELECT payment_date, amount FROM payment 
	ORDER BY amount DESC LIMIT 20;
	
/* 1.8d Select the title, description, special features, length, and rental duration columns from the film table 
for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, 
ordered by length in descending order. */
DESCRIBE film;
SELECT special_features FROM film LIMIT 5;
SELECT title, description, special_features, length, rental_duration FROM film 
	WHERE (special_features LIKE '%Behind the Scenes%') AND (length < 120)
	AND (rental_duration BETWEEN 5 AND 7)
	ORDER BY length DESC;
    
/* 1.9a Select customer first_name/last_name and actor first_name/last_name columns from performing a left join 
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
        
/* 1.9b Select the customer first_name/last_name and actor first_name/last_name columns from performing 
a /right join between the customer and actor column on the last_name column in each table. 
(i.e. customer.last_name = actor.last_name) */
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, a.last_name AS actor_last_name
	FROM customer c
		RIGHT JOIN actor a 
        ON c.last_name = a.last_name
	ORDER BY a.last_name;
        
/* 1.9c Select the customer first_name/last_name and actor first_name/last_name columns from performing 
an inner join between the customer and actor column on the last_name column in each table. 
(i.e. customer.last_name = actor.last_name) */
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, a.last_name AS actor_last_name
	FROM customer c
		JOIN actor a 
        ON c.last_name = a.last_name
	ORDER BY c.last_name;
        
/* 1.9d Select the city name and country name columns from the city table, performing 
a left join with the country table to get the country name column. */
DESCRIBE city;
DESCRIBE country;
SELECT ci.city, co.country 
	FROM city ci
		LEFT JOIN country co
        ON ci.country_id = co.country_id;
        
/* 1.9e Select the title, description, release year, and language name columns from the film table, performing 
a left join with the language table to get the "language" column. */
DESCRIBE film;
DESCRIBE language;
SELECT f.title, f.description, f.release_year, l.name
	FROM film f
		LEFT JOIN language l
		ON f.language_id = l.language_id;
        
/* 1.9f Select the first_name, last_name, address, address2, city name, district, and postal code columns 
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
DESCRIBE language;
SELECT f.title, l.name AS language
	FROM film f
		JOIN language l
        ON f.language_id = l.language_id
	WHERE ((f.title LIKE 'k%')
		OR (f.title LIKE 'q%'))
        AND (l.name = 'english')
	ORDER BY f.title;
    
-- 2.14 Use subqueries to display all actors who appear in the film Alone Trip.
DESCRIBE film;
DESCRIBE actor;
DESCRIBE film_actor;
SELECT CONCAT (a.first_name, '_', a.last_name) AS actor
	FROM actor a
		JOIN film_actor fa
        ON a.actor_id = fa.actor_id
        JOIN film f
        ON f.film_id = fa.film_id
	WHERE f.title = 'Alone Trip'
    ORDER BY actor;
    
/* 2.15 You want to run an email marketing campaign in Canada, 
for which you will need the names and email addresses of all Canadian customers. */
DESCRIBE customer;
DESCRIBE address;
DESCRIBE city;
DESCRIBE country;
SELECT c.first_name, c.last_name, c.email
	FROM customer c
		LEFT JOIN address a
        ON c.address_id = a.address_id
        LEFT JOIN city ci
        ON a.city_id = ci.city_id
		JOIN country co
        ON ci.country_id = co.country_id
	WHERE co.country = 'Canada';

/* 2.16 Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
Identify all movies categorized as famiy films. */
DESCRIBE film;
SHOW tables;
DESCRIBE film_category;
DESCRIBE category;

SELECT f.title
FROM film f
	JOIN film_category fc
	ON f.film_id = fc.film_id
	JOIN category c
	ON fc.category_id = c.category_id
WHERE c.name = 'family';
    
-- 2.17 Write a query to display how much business, in dollars, each store brought in.
DESCRIBE sales_by_store;

SELECT store, total_sales
FROM sales_by_store;
    
-- 2.18 Write a query to display for each store its store ID, city, and country.
DESCRIBE store;
DESCRIBE address;
DESCRIBE city;
DESCRIBE country;

SELECT s.store_id, ci.city, co.country
FROM store s
	JOIN address a
	ON s.address_id = a.address_id
	JOIN city ci
	ON a.city_id = ci.city_id
	JOIN country co
	ON ci.country_id = co.country_id;
        
/* 2.19 List the top five genres in gross revenue in descending order. 
Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental. */
DESCRIBE category;
DESCRIBE film_category;
DESCRIBE inventory;
DESCRIBE payment;
DESCRIBE rental;

SELECT c.name AS genre, SUM(p.amount) AS revenue
FROM category c
	JOIN film_category fc
    ON c.category_id = fc.category_id
    JOIN inventory i
    ON fc.film_id = i.film_id
    JOIN rental r
    ON i.inventory_id = r.inventory_id
    JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY genre
ORDER BY revenue DESC
LIMIT 5;

-- 3.1 What is the average replacement cost of a film? Does this change depending on the rating of the film?
SELECT AVG(replacement_cost)
FROM film;

SELECT rating, AVG(replacement_cost)
FROM film
GROUP BY rating
ORDER BY rating;

-- 3.2 How many different films of each genre are in the database?
SELECT c.name, COUNT(fc.film_id) AS count
FROM category c
	JOIN film_category fc
    ON c.category_id = fc.category_id
GROUP BY c.name;

-- 3.3 What are the 5 frequently rented films?
SELECT f.title, COUNT(r.rental_id) AS total
FROM film f
	JOIN inventory i
    ON f.film_id = i.film_id
    JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total desc
LIMIT 5;

-- 3.4 What are the most most profitable films (in terms of gross revenue)?
SELECT f.title, SUM(p.amount) AS total
FROM film f
	JOIN inventory i
	ON f.film_id = i.film_id
	JOIN rental r
	ON i.inventory_id = r.inventory_id
	JOIN payment p
	ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY total DESC
LIMIT 5;

-- 3.5 Who is the best customer?
SHOW TABLES;
DESCRIBE customer;
DESCRIBE rental;

SELECT CONCAT(c.last_name, ', ', c.first_name) AS name,
	SUM(p.amount) AS total
FROM customer c
	JOIN rental r
    ON c.customer_id = r.customer_id
    JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY total DESC
LIMIT 1;

-- 3.6 Who are the most popular actors (that have appeared in the most films)?
SELECT CONCAT(a.last_name, ', ', a.first_name) AS actor_name,
	COUNT(fa.film_id) AS total
FROM actor a
	JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY actor_name
ORDER BY total DESC
LIMIT 5;

-- 3.7 What are the sales for each store for each month in 2005?
SELECT DATE_FORMAT(p.payment_date, '%b') AS month,
	i.store_id, SUM(p.amount) AS sales
FROM payment p
	JOIN rental r
    ON p.rental_id = r.rental_id
    JOIN inventory i
    ON r.inventory_id = i.inventory_id
WHERE YEAR(p.payment_date) = '2005'
GROUP BY month, i.store_id
ORDER BY month DESC, i.store_id;

-- 3.8 Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
SELECT f.title,
	CONCAT(c.last_name, ', ', c.first_name) AS customer_name,
    a.phone, a.address
FROM rental r
	JOIN inventory i
    ON r.inventory_id = i.inventory_id
    JOIN film f
    ON i.film_id = f.film_id
    JOIN customer c
    ON r.customer_id = c.customer_id
    JOIN address a
    ON c.address_id = a.address_id
WHERE r.return_date IS NULL;

USE employees;
/* 4.1 How much do the current managers of each department get paid, relative to the average salary for the department? 
Is there any department where the department manager gets paid less than the average salary? Yes, customer service and production */
SELECT d.dept_name, manager_salary, average_salary,
	(manager_salary - average_salary) AS salary_diff
FROM departments d
	JOIN (
		SELECT dm.dept_no, s.salary AS manager_salary
		FROM dept_manager dm
		JOIN salaries s
			ON dm.emp_no = s.emp_no
		WHERE (dm.to_date = '9999-01-01')
			AND (s.to_date = '9999-01-01')
	) AS dm
    ON d.dept_no = dm.dept_no
	JOIN (
		SELECT de.dept_no, ROUND(AVG(s.salary), 0) AS average_salary
		FROM dept_emp de
        JOIN salaries s
			ON de.emp_no = s.emp_no
        WHERE (de.to_date = '9999-01-01')
			AND (s.to_date = '9999-01-01')
        GROUP BY de.dept_no
        ) AS de
    ON d.dept_no = de.dept_no
ORDER BY d.dept_name;
-- I love when a tricky bit of code finally works right!

USE world;
SHOW TABLES;
DESCRIBE city;
DESCRIBE country;
DESCRIBE countrylanguage;

-- 5.1 What languages are spoken in Santa Monica?
SELECT cl.language, cl.percentage
FROM city ci
    JOIN countrylanguage cl
    ON ci.countryCode = cl.countryCode
WHERE ci.name = 'Santa Monica'
ORDER BY cl.percentage DESC;

-- 5.2 How many different countries are in each region?
SELECT region, COUNT(code)
FROM country
GROUP BY region
ORDER BY region;

-- 5.3 What is the population for each region?
SELECT region, SUM(population) AS population
FROM country
GROUP BY region
ORDER BY population DESC;

-- 5.4 What is the population for each continent?
SELECT continent, SUM(population) AS population
FROM country
GROUP BY continent
ORDER BY population DESC;

-- 5.5 What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;

-- 5.6 What is the average life expectancy for each region, each continent? 
-- Sort the results from shortest to longest
SELECT region, AVG(lifeExpectancy) AS life_expectancy
FROM country
GROUP BY region
ORDER BY life_expectancy;

SELECT continent, AVG(lifeExpectancy) AS life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy;

-- 5.7 Find all the countries whose local name is different from the official name
SELECT name, localName
FROM country
WHERE name <> localName;

-- 5.8 How many countries have a life expectancy less than x?
SELECT COUNT(*)
FROM country
WHERE lifeExpectancy < 10;

-- 5.9 What state is city x located in?
SELECT name, district
FROM city 
WHERE name LIKE '%x%';

-- 5.10 What region of the world is city x located in?
SELECT ci.name, co.region 
FROM city ci
	JOIN country co
	ON ci.countryCode = co.code
WHERE ci.name LIKE '%x%';

-- 5.11 What country (use the human readable name) city x located in?
SELECT ci.name, co.name
FROM city ci
	JOIN country co
	ON ci.countryCode = co.code
WHERE ci.name LIKE '%x%';

-- 5.12 What is the life expectancy in city x?
SELECT ci.name, co.lifeExpectancy
FROM city ci
	JOIN country co
	ON ci.countryCode = co.code
WHERE ci.name LIKE '%x%';

USE pizza;
/* 6.1 What information is stored in the toppings table? 
topping_id, topping_name, topping_price
How does this table relate to the pizzas table? 
They are related through the table pizza_toppings, with 1 or multiple topping_ids per pizza_id */
SHOW tables;
DESCRIBE toppings;
DESCRIBE pizzas;
DESCRIBE pizza_toppings;
SELECT * FROM pizza_toppings;

/* 6.2 What information is stored in the modifiers table? 
modifier_id, modifier_name, modifier_price
How does this table relate to the pizzas table?
They are related through the table pizza_modifiers, with 0-2 modifiers per pizza_id */
DESCRIBE modifiers;
DESCRIBE pizza_modifiers;
SELECT * FROM modifiers;

/* 6.3 How are the pizzas and sizes tables related? 
They are related through the table pizzas, with 1 size_id per pizza_id */
DESCRIBE sizes;
SELECT * FROM pizzas;

/* 6.4 What other tables are in the database? 
crust_types which is related to the pizzas table with 1 crust_type per pizza_id */
SHOW TABLES;

-- 6.5 How many unique toppings are there? 9
SELECT COUNT(DISTINCT topping_id)
FROM toppings;

-- 6.6 How many unique orders are in this dataset? 10,000
SELECT COUNT(DISTINCT order_id)
FROM pizzas;

-- 6.7 Which size of pizza is sold the most? Large
SELECT s.size_name, COUNT(*) AS count
FROM pizzas p
	JOIN sizes s
    ON p.size_id = s.size_id
GROUP BY size_name
ORDER BY count DESC
LIMIT 1;

-- 6.8 How many pizzas have been sold in total? 20,001
SELECT COUNT(DISTINCT pizza_id)
FROM pizzas;

-- 6.9 What is the most common size of pizza ordered? repeat question? Large
SELECT s.size_name, COUNT(*) AS count
FROM pizzas p
	JOIN sizes s
    ON p.size_id = s.size_id
GROUP BY size_name
ORDER BY count DESC
LIMIT 1;

-- 6.10 What is the average number of pizzas per order? 2.0001
SELECT COUNT(DISTINCT pizza_id) / COUNT(DISTINCT order_id)
FROM pizzas;

/* 6.11 Find the total price for each order. The total price is the sum of:
The price based on pizza size
Any modifiers that need to be charged for
The sum of the topping prices
Topping price is affected by the amount of the topping specified. A light amount is half of the regular price. 
An extra amount is 1.5 times the regular price, and double of the topping is double the price. */
SHOW TABLES;
SELECT * FROM sizes;
SELECT * FROM modifiers;
SELECT * FROM toppings;
SELECT * FROM pizza_modifiers;
SELECT * FROM pizza_toppings;
SELECT * FROM pizzas;
DESCRIBE pizza_toppings;

SELECT * 
FROM pizzas
	LEFT JOIN pizza_modifiers
		USING (pizza_id)
	LEFT JOIN pizza_toppings
		USING (pizza_id)
	JOIN sizes
		USING (size_id)
	LEFT JOIN modifiers
		USING (modifier_id)
	LEFT JOIN toppings
		USING (topping_id)
;

-- get size cost per pizza_id
SELECT pizza_id, size_price
FROM pizzas
	JOIN sizes
		USING (size_id)
GROUP BY pizza_id
;

-- list of pizza_modifier cost by pizza_id
SELECT pizza_id,
	CASE modifier_id
		WHEN 1 THEN 1.99
		ELSE 0
    END AS ext_cost
FROM pizzas
	JOIN pizza_modifiers
		USING (pizza_id)
;

-- get the topping cost per pizza_id
SELECT pizza_id, ROUND(SUM(top_price), 2)
FROM (
	SELECT pizza_id,
		CASE topping_amount
			WHEN 'light' THEN ROUND(topping_price * 0.5, 2)
			WHEN 'extra' THEN ROUND(topping_price * 1.5, 2)
			WHEN 'double' THEN ROUND(topping_price * 2, 2)
			ELSE topping_price
		END AS top_price
	FROM pizzas
		LEFT JOIN pizza_toppings
			USING (pizza_id)
		LEFT JOIN toppings
			USING (topping_id)
	) AS top_list
GROUP BY pizza_id
;

-- Holy crap it works!
-- Get order totals
SELECT ROUND(SUM(pizza_cost), 2) AS order_total, order_id 
FROM
	-- get overall cost per pizza_id
	(SELECT pizza_id, (size_price + IFNULL(top_cost, 0) + ext_cost) AS pizza_cost, order_id
	FROM pizzas
	LEFT JOIN
	-- get size cost per pizza_id
		(SELECT pizza_id, size_price
		FROM pizzas
			JOIN sizes
				USING (size_id)
		GROUP BY pizza_id
		) as a
		USING (pizza_id)
	LEFT JOIN
		-- list of pizza_modifier cost by pizza_id
		(SELECT pizza_id,
			CASE modifier_id
				WHEN 1 THEN 1.99
				WHEN NULL THEN 0
				ELSE 0
			END AS ext_cost
		FROM pizzas
			LEFT JOIN pizza_modifiers
				USING (pizza_id)
		) as b
		USING (pizza_id)
	LEFT JOIN
		-- get the topping cost per pizza_id
		(SELECT pizza_id, ROUND(SUM(sub_price), 2) AS top_cost
		FROM (
			SELECT pizza_id,
				CASE topping_amount
					WHEN 'light' THEN ROUND(topping_price * 0.5, 2)
					WHEN 'extra' THEN ROUND(topping_price * 1.5, 2)
					WHEN 'double' THEN ROUND(topping_price * 2, 2)
					ELSE topping_price
				END AS sub_price
			FROM pizzas
				LEFT JOIN pizza_toppings
					USING (pizza_id)
				LEFT JOIN toppings
					USING (topping_id)
			) AS top_list
		GROUP BY pizza_id
		) as c
		USING (pizza_id)
	-- ORDER BY pizza_id
    ) AS totals
GROUP BY order_id
ORDER BY order_id
;