-- Original code:
SELECT *
FROM customer AS c
RIGHT JOIN customer_purchases AS cp
	ON c.customer_id = cp.customer_id;

-- To get the same output with a LEFT JOIN:
-- change the order of the tables in the join statement

SELECT *
FROM customer_purchases AS cp
LEFT JOIN customer AS c
	ON c.customer_id = cp.customer_id;