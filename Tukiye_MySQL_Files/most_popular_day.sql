#### Find most popular days for each mall ####

CREATE TABLE retail.most_popular_day (
	total_sales DECIMAL(15, 2),
    shopping_mall VARCHAR(30),
    day VARCHAR(10)
);


#INSERT INTO retail.most_popular_day (total_sales, shopping_mall, day) 
SELECT ROUND(SUM(price), 2) AS total_sales, shopping_mall, day
FROM(
	SELECT *, CASE
		WHEN day_of_week = 1 THEN "Monday"
		WHEN day_of_week = 2 THEN "Tuesday"
		WHEN day_of_week = 3 THEN "Wednesday"
		WHEN day_of_week = 4 THEN "Thursday"
		WHEN day_of_week = 5 THEN "Friday"
		WHEN day_of_week = 6 THEN "Saturday"
		WHEN day_of_week = 7 THEN "Sunday"
	END AS day
	FROM (
		SELECT *, DAYOFWEEK(new_dates) AS day_of_week
		FROM retail.customer_shopping_data
	) f
)s
GROUP BY shopping_mall, day_of_week;

SELECT * FROM retail.customer_shopping_data;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));	# Fix MySQL error message

SELECT * FROM retail.most_popular_day;

#DROP TABLE retail.most_popular_day;