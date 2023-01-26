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