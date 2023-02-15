-- Using the customer table from sakila database,
-- find the number of active and inactive users
USE sakila;
SHOW tables;
DESCRIBE customer;

SELECT active, COUNT(customer_id) as user_total
FROM customer
GROUP BY active;

-- Active = 584
-- Inactive = 15