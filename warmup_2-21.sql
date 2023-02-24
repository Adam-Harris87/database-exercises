-- Using the customer, address, city, and country table in the sakila db
-- find all customers that live in Poland.
-- Output two columns titled: full_name, email
USE sakila;

DESCRIBE customer;
DESCRIBE address;
DESCRIBE city;
DESCRIBE country;

SELECT CONCAT(first_name, ' ', last_name) as full_name,
	email
FROM customer
	JOIN address
		USING (address_id)
	JOIN city
		USING (city_id)
	JOIN country
		USING (country_id)
WHERE country = 'Poland';