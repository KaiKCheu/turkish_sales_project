SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

WITH CTE
AS(

SELECT *, SUM(quantity) AS quant_sum 
FROM retail.customer_shopping_data
GROUP BY category, shopping_mall
),
CTE2
AS(

SELECT *, DENSE_RANK() OVER(PARTITION BY shopping_mall ORDER BY quant_sum DESC) AS quantity_rankings 
FROM CTE
)

SELECT category, quantity, shopping_mall, quant_sum, quantity_rankings FROM CTE2
WHERE quantity_rankings <= 5;

#INSERT INTO retail.quantity_ranking (shopping_mall, category, quant_sum, quantity_rankings) SELECT a.shopping_mall, a.category, a.quant_sum, a.quantity_rankings
#FROM( SELECT *, DENSE_RANK() OVER(PARTITION BY s.shopping_mall ORDER BY s.quant_sum DESC) AS quantity_rankings FROM (
#SELECT *
#FROM retail.customer_shopping_data r
#LEFT JOIN (SELECT shopping_mall AS temp_mall, category AS temp_category, SUM(quantity) AS quant_sum 
#FROM retail.customer_shopping_data
#GROUP BY category, shopping_mall) t
#ON r.shopping_mall = t.temp_mall AND r.category = t.temp_category) s
#GROUP BY s.category, s.shopping_mall
#) a
#WHERE a.quantity_rankings <= 5;


CREATE TABLE retail.quantity_ranking LIKE retail.customer_shopping_data;

ALTER TABLE retail.quantity_ranking
	DROP COLUMN invoice_no, DROP COLUMN customer_id;
    
ALTER TABLE retail.quantity_ranking
	DROP COLUMN price, DROP COLUMN gender, DROP COLUMN age, DROP COLUMN payment_method, DROP COLUMN invoice_date;

ALTER TABLE retail.quantity_ranking
	DROP COLUMN new_dates;

ALTER TABLE retail.quantity_ranking
	DROP COLUMN quantity;
    
ALTER TABLE retail.quantity_ranking
	ADD COLUMN quant_sum INT;
    
ALTER TABLE retail.quantity_ranking
	ADD COLUMN quantity_rankings INT;

SELECT * FROM retail.quantity_ranking;

#DROP TABLE retail.quantity_ranking;


