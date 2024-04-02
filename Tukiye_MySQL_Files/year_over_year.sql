SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

/*
CREATE TABLE retail.yearly_sales (
	shopping_mall VARCHAR(50),
    total_sales DECIMAL(12, 2),
    year VARCHAR(7)
);
*/

#INSERT INTO retail.yearly_sales (shopping_mall, total_sales, year) 
SELECT shopping_mall, ROUND(SUM(price), 2) AS total_sales, YEAR(new_dates) AS 'year' FROM retail.customer_shopping_data
GROUP BY shopping_mall, YEAR(new_dates)
ORDER BY shopping_mall, YEAR(new_dates) DESC;

SELECT *, LAG(total_sales) OVER (PARTITION BY shopping_mall ORDER BY year) AS last_yr_sales, 
IFNULL(((total_sales - LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY year)) / LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY year)), 0) AS YOY_Difference FROM retail.yearly_sales
ORDER BY shopping_mall, year;