SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

/*
CREATE TABLE retail.quarterly_sales (
	shopping_mall VARCHAR(50),
    total_sales DECIMAL(12, 2),
    year VARCHAR(7),
    quarter VARCHAR(12)
);
*/

#INSERT INTO retail.quarterly_sales (shopping_mall, total_sales, year, quarter) 
SELECT cs.shopping_mall, ROUND(SUM(cs.price), 2) AS total_sales, YEAR(cs.new_dates),cs.quarter
FROM (
SELECT *,
CASE
	WHEN new_dates >= '2021-01-01' AND new_dates < '2021-04-01' THEN '(2021 Q1)'
    WHEN new_dates >= '2021-04-01' AND new_dates < '2021-07-01' THEN '(2021 Q2)'
    WHEN new_dates >= '2021-07-01' AND new_dates < '2021-10-01' THEN '(2021 Q3)'
    WHEN new_dates >= '2021-10-01' AND new_dates < '2022-01-01' THEN '(2021 Q4)'
	WHEN new_dates >= '2022-01-01' AND new_dates < '2022-04-01' THEN '(2022 Q1)'
    WHEN new_dates >= '2022-04-01' AND new_dates < '2022-07-01' THEN '(2022 Q2)'
    WHEN new_dates >= '2022-07-01' AND new_dates < '2022-10-01' THEN '(2022 Q3)'
    WHEN new_dates >= '2022-10-01' AND new_dates < '2023-01-01' THEN '(2022 Q4)'
	WHEN new_dates >= '2023-01-01' AND new_dates < '2023-04-01' THEN '(2023 Q1)'
END AS 'quarter'
FROM retail.customer_shopping_data) cs
GROUP BY cs.shopping_mall, cs.quarter ORDER BY cs.shopping_mall, cs.quarter DESC;

ALTER TABLE retail.quarterly_sales ADD COLUMN dollar_quarter_change DECIMAL(9, 2);

ALTER TABLE retail.quarterly_sales ADD COLUMN percent_sales_change DECIMAL(4, 2);

SELECT *, total_sales - IFNULL(LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY quarter), total_sales) AS dollar_quarter_change,
IFNULL(ROUND((((total_sales - LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY quarter)) / LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY quarter)) * 100) ,2), 0) AS percent_sales_change 
FROM retail.quarterly_sales
ORDER BY shopping_mall, year, quarter;

/*
CREATE TABLE retail.temp (
	shopping_mall VARCHAR(50),
    year INT,
    quarter VARCHAR(10),
    dollar_quarter_change DECIMAL(11, 2),
    percent_sales_change DECIMAL (4, 2)
);
*/

/*
INSERT INTO retail.temp (shopping_mall, year, quarter, dollar_quarter_change, percent_sales_change) SELECT shopping_mall, year, quarter, total_sales - IFNULL(LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY quarter), total_sales) AS dollar_quarter_change,
IFNULL(ROUND((((total_sales - LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY quarter)) / LAG(total_sales) OVER(PARTITION BY shopping_mall ORDER BY quarter)) * 100) ,2), 0) AS percent_sales_change FROM retail.quarterly_sales;

SELECT * FROM retail.temp;

SELECT * FROM retail.quarterly_sales;


UPDATE retail.quarterly_sales qs INNER JOIN retail.temp t
ON qs.shopping_mall = t.shopping_mall AND qs.year = t.year AND qs.quarter = t.quarter
SET qs.dollar_quarter_change = t.dollar_quarter_change;

UPDATE retail.quarterly_sales qs INNER JOIN retail.temp t
ON qs.shopping_mall = t.shopping_mall AND qs.year = t.year AND qs.quarter = t.quarter
SET qs.percent_sales_change = t.percent_sales_change;
*/

#DROP TABLE retail.temp;