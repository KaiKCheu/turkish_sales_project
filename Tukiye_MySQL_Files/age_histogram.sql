WITH CTE
AS(

SELECT *, 
CASE
	WHEN age <= 20 THEN "Youth"
    WHEN age > 20 AND age <= 30 THEN "Young Adult"
    WHEN age > 30 and age <= 45 THEN "Adult"
    WHEN age > 45 AND age <= 60 THEN "Old Adult"
    WHEN age > 60 THEN "Elder"
END AS age_grouping
FROM retail.customer_shopping_data
WHERE shopping_mall LIKE "Mall of Istanbul"

)

SELECT shopping_mall AS mall_name, COUNT(customer_id) AS total_count, 
(SELECT COUNT(age_grouping) FROM CTE WHERE age_grouping LIKE "Youth" ) AS Youth,  
(SELECT COUNT(age_grouping) FROM CTE WHERE age_grouping LIKE "Young Adult" ) AS 'Young Adult', 
(SELECT COUNT(age_grouping) FROM CTE WHERE age_grouping LIKE "Young Adult" ) AS Adult, 
(SELECT COUNT(age_grouping) FROM CTE WHERE age_grouping LIKE "Old Adult" ) AS 'Old Adult', 
(SELECT COUNT(age_grouping) FROM CTE WHERE age_grouping LIKE "Elder" )  AS Elder
FROM CTE;

SELECT MIN(age)
FROM retail.customer_shopping_data;

/*
SELECT r.shopping_mall, s.age_grouping
FROM retail.customer_shopping_data r
LEFT JOIN 
(SELECT shopping_mall,
CASE
	WHEN age <= 20 THEN "Youth"
    WHEN age > 20 AND age <= 30 THEN "Young Adult"
    WHEN age > 30 and age <= 45 THEN "Adult"
    WHEN age > 45 AND age <= 60 THEN "Old Adult"
    WHEN age > 60 THEN "Elder"
END AS age_grouping
FROM retail.customer_shopping_data
WHERE shopping_mall LIKE "Mall of Istanbul") s
ON r.shopping_mall = s.shopping_mall
GROUP BY s.age_grouping, r.shopping_mall;
*/

SELECT * FROM retail.customer_shopping_data;

INSERT INTO retail.age_histogram (shopping_mall, age_grouping, age_counts) 
SELECT s.shopping_mall, s.age_grouping, COUNT(s.age_grouping) AS age_counts
FROM (
	SELECT shopping_mall,
	CASE
		WHEN age <= 20 THEN " (1) Youth "
		WHEN age > 20 AND age <= 30 THEN " (2) Young Adult "
		WHEN age > 30 and age <= 45 THEN " (3) Adult "
		WHEN age > 45 AND age <= 60 THEN " (4) Old Adult "
		WHEN age > 60 THEN " (5) Elder "
	END AS age_grouping
	FROM retail.customer_shopping_data
	#WHERE shopping_mall LIKE "Mall of Istanbul"
	) s
GROUP BY s.shopping_mall, s.age_grouping
ORDER BY s.shopping_mall, s.age_grouping DESC;

CREATE TABLE retail.age_histogram (
	shopping_mall VARCHAR(50),
    age_grouping VARCHAR(50),
    age_counts INT
);

DROP TABLE retail.age_histogram;


SELECT * FROM retail.age_histogram;
