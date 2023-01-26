USE sakila;
SHOW TABLES;

-- 1a
SELECT * FROM actor;

-- 1b
SELECT last_name FROM actor;

-- 1c
SELECT film_id, title, release_year FROM film;

-- 2a
SELECT DISTINCT last_name FROM actor;

DESCRIBE address;
-- 2b
SELECT DISTINCT postal_code FROM address;

DESCRIBE film;
-- 2c
SELECT DISTINCT rating FROM film;

SELECT length from film LIMIT 5;
-- 3a
SELECT title, description, rating, length FROM film WHERE length >= 180;

-- 3b payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
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
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');

/* 4b Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.) */
SELECT payment_id, amount, payment_date FROM payment 
	WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

-- 4c Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5a Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * FROM payment WHERE payment_date 
	BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

-- 5b Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
SELECT film_id, title, descrition FROM film WHERE LENGTH description BETWEEN 100 AND 120;