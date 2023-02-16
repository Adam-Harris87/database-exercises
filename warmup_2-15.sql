-- Using the customer table from sakila database,
-- find the number of active and inactive users
USE sakila;
SHOW tables;
DESCRIBE customer;

SELECT 
	CASE active
		WHEN 1 THEN 'Active'
        WHEN 0 THEN 'Inactive'
	END AS user_activity,
    COUNT(customer_id) as user_total
FROM customer
GROUP BY active;

-- Active = 584
-- Inactive = 15