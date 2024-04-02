SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

WITH CTE
AS(

SELECT *, SUM(price) AS total_price FROM 
retail.customer_shopping_data
GROUP BY category, shopping_mall

),
CTE2
AS(

SELECT *, DENSE_RANK() OVER(PARTITION BY shopping_mall ORDER BY total_price DESC) AS price_rankings FROM CTE

)

SELECT shopping_mall, category, total_price, price_rankings FROM CTE2
WHERE price_rankings <= 5;


INSERT INTO retail.price_rankings (shopping_mall, category, total_sales, sales_rankings) SELECT t.shopping_mall, t.category, t.total_sales, t.sales_rankings
FROM (
	SELECT s.shopping_mall, s.category, f.total_sales, DENSE_RANK() OVER(PARTITION BY s.shopping_mall ORDER BY f.total_sales DESC) AS sales_rankings
	FROM retail.customer_shopping_data s
	LEFT JOIN (
		SELECT category, shopping_mall, ROUND(SUM(price), 2) AS total_sales 
		FROM retail.customer_shopping_data
		GROUP BY category, shopping_mall
		) f
	ON s.category = f.category AND s.shopping_mall = f.shopping_mall
	GROUP BY s.category, s.shopping_mall
) t
WHERE t.sales_rankings <= 5;




CREATE TABLE retail.price_rankings (
	shopping_mall VARCHAR(50),
    category VARCHAR(50),
    total_sales DECIMAL(12, 2),
    sales_rankings INT
);


SELECT * FROM retail.price_rankings;

DROP TABLE retail.price_rankings;

