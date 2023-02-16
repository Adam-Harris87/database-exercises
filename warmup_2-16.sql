-- Using the customer and payyment table from sakila database,
-- find the first and last names of the top five
-- customers that spend the most money
USE sakila;
DESCRIBE customer;
DESCRIBE payment;

SELECT first_name, last_name, SUM(amount) as total_spent
FROM customer
	JOIN payment
    USING (customer_id)
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;