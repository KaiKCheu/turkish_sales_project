SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT * FROM retail.customer_shopping_data;


CREATE TABLE retail.payment_types (
	shopping_mall VARCHAR(50),
    payment_method VARCHAR(20),
    total_sales DECIMAL(12, 2)
);



INSERT INTO retail.payment_types (shopping_mall, payment_method, total_sales) SELECT shopping_mall, payment_method, ROUND(SUM(price), 2) AS total_sales FROM retail.customer_shopping_data
GROUP BY payment_method, shopping_mall
ORDER BY shopping_mall, total_sales DESC;

SELECT * FROM retail.payment_types;