DROP DATABASE IF EXISTS HW2;
CREATE DATABASE IF NOT EXISTS HW2;

USE HW2;

DROP TABLE IF EXISTS sales;
CREATE TABLE IF NOT EXISTS sales
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_date DATE NOT NULL,
	count_product INT);

INSERT INTO sales (order_date, count_product)
VALUES 
	('2022-01-01', 156),
    ('2022-01-02', 180),
    ('2022-01-03', 21),
    ('2022-01-04', 124),
    ('2022-01-05', 341);
ALTER TABLE sales

ADD COLUMN order_type VARCHAR(50) GENERATED ALWAYS AS (
    CASE
        WHEN count_product < 100 THEN 'Маленький заказ'
        WHEN count_product >= 100 AND count_product <= 300 THEN 'Средний заказ'
        WHEN count_product > 300 THEN 'Большой заказ'
        ELSE 'Не определено'
    END
) VIRTUAL;

SELECT * FROM sales;
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id VARCHAR(3),
	amount DOUBLE,
	order_status VARCHAR(9));
INSERT INTO orders (employee_id, amount, order_status)
VALUES 
	('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70, 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');
SELECT *,
IF(order_status = 'OPEN', 'Order is in open state',
	IF(order_status = 'CLOSED', 'Order is closed',
		IF(order_status = 'CANCELLED', 'Order is cancelled', 'Undefined'))) AS full_order_status
FROM orders;