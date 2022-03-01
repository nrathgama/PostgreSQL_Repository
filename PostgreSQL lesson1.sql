###UDACITY BUSINESS ANALYTICS NANODEGREE 
###SQL Notes LESSON1###
/*
Try it yourself below by writing a query that limits the response to only the first
15 rows and includes the date, account_id, and channel fields in the web_events table.
*/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

###ORDER_BY
/* Write a query to return the 10 earliest orders (this needs to be datewise ordered)
in the orders table. Include the id, occurred_at, and total_amt_usd.*/
 SELECT id, occurred_at, total_amt_usd
 FROM orders
 ORDER BY occurred_at
 LIMIT 10;

 /*Write a query to return the top 5 orders in terms of largest total_amt_usd.
  Include the id, account_id, and total_amt_usd.*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/*Write a query to return the lowest 20 orders in terms of smallest total_amt_usd.
Include the id, account_id, and total_amt_usd.*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/*Questions
(1) Write a query that displays the order ID, account ID, and total dollar amount
for all the orders, sorted first by the account ID (in ascending order),
and then by the total dollar amount (in descending order).*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

/* (2) Now write a query that again displays order ID, account ID, and total dollar
 amount for each order, but this time sorted first by total dollar amount
 (in descending order), and then by account ID (in ascending order).*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id; /*comma after DESC and semicolon is a must!*/

###_WHERE
/*Pulls the first 5 rows and all columns from the orders table that have a
 dollar amount of gloss_amt_usd greater than or equal to 1000.*/
 SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/*Pulls the first 10 rows and all columns from the orders table that have a
total_amt_usd less than 500.*/
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

###WHERE_with non-numeric_data
/*Filter the accounts table to include the company name, website, and the
primary point of contact (primary_poc) just for the Exxon Mobil company
in the accounts table.*/
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

###Arithmetic Operator
/*Create a column that divides the standard_amt_usd by the standard_qty
to find the unit price for standard paper for each order. Limit the results
 to the first 10 orders, and include the id and account_id fields.*/
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

/*write a query that finds the percentage of revenue that comes from poster
paper for each order. You will need to use only the columns that end
with _usd. (Try to do this without using the total column.) Display the
id and account_id fields also. */
SELECT id, account_id,
   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

###LIKE_
/*
(1) All the companies whose names start with 'C'.
(2) All companies whose names contain the string 'one' somewhere in the name.
(3) All companies whose names end with 's'.*/
#1_
SELECT *
FROM accounts
WHERE name like 'C%';
#2_
SELECT *
FROM accounts
WHERE name like '%one%';
#3_
SELECT *
FROM accounts
WHERE name like '%s';

###IN_operator
/*
(1)Use the accounts table to find the account name, primary_poc, and
sales_rep_id for Walmart, Target, and Nordstrom.
(2) Use the web_events table to find all information regarding individuals
 who were contacted via the channel of organic or adwords.*/
#1_
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');
#2_
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

####AND_&_BETWEEN
/*Write a query that returns all the orders where the standard_qty is over 1000,
 the poster_qty is 0, and the gloss_qty is 0.*/
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/*Using the accounts table, find all the companies whose names do not start
 with 'C' and end with 's'.*/
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/*When you use the BETWEEN operator in SQL, do the results include the values
of your endpoints, or not? Figure out the answer to this important question
by writing a query that displays the order date and gloss_qty data for all
orders where gloss_qty is between 24 and 29. Then look at your output to see
if the BETWEEN operator included the begin and end values or not.*/
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

/*##NOTE_ You should notice that there are a number of rows in the output of this
 query where the gloss_qty values are 24 or 29. So the answer to the question is
  that yes, the BETWEEN operator in SQL is inclusive; that is, the endpoint
  values are included. So the BETWEEN statement in this query is equivalent to
   having written "WHERE gloss_qty >= 24 AND gloss_qty <= 29."*/

/*You will notice that using BETWEEN is tricky for dates! While BETWEEN is
generally inclusive of endpoints, it assumes the time is at 00:00:00
(i.e. midnight) for dates. This is the reason why we set the right-side
endpoint of the period at '2017-01-01'.*/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01'
 AND '2017-01-01'
ORDER BY occurred_at DESC;

###OR_operator
/*Find list of orders ids where either gloss_qty or poster_qty is greater
 than 4000. Only include the id field in the resulting table.*/
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/*Write a query that returns a list of orders where the standard_qty is zero
and either the gloss_qty or poster_qty is over 1000.*/
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

/*Find all the company names that start with a 'C' or 'W', and the primary 
contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.*/
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
	           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
	           AND primary_poc NOT LIKE '%eana%');
