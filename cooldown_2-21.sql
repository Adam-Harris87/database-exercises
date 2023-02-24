USE employees;

SELECT *
FROM titles;

-- Using the customer, address, city, and country table,
-- which country has the most customers living in it?
USE sakila;

SELECT
	country, 
	COUNT(country)
FROM customer
	JOIN address
		USING (address_id)
	JOIN city
		USING (city_id)
	JOIN country
		USING (country_id)
GROUP BY country
ORDER BY COUNT(country) DESC
LIMIT 1;