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
SELECT * from category WHERE (category_id > 4) AND (name LIKE 'c%' OR name LIKE 's%' OR name LIKE 't%');

