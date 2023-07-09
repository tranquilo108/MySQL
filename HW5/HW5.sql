DROP DATABASE IF EXISTS HW5;
CREATE DATABASE HW5;
USE HW5;

DROP TABLE IF EXISTS cars;
CREATE TABLE IF NOT EXISTS cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

/*
1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

Доп задания:
1* Получить ранжированный список автомобилей по цене в порядке возрастания
2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
3* Получить список автомобилей, у которых цена больше предыдущей цены
4* Получить список автомобилей, у которых цена меньше следующей цены
5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
*/

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE OR REPLACE VIEW under25000 AS
SELECT * FROM cars
WHERE cost >= 25000;
SELECT * FROM under25000;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW under25000 AS
SELECT * FROM cars
WHERE cost <= 30000;
SELECT * FROM under25000;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

CREATE OR REPLACE VIEW Skodaudi AS
SELECT * FROM cars
WHERE name = 'Skoda' OR name = 'Audi';
SELECT * FROM Skodaudi;

-- 1* Получить ранжированный список автомобилей по цене в порядке возрастания

SELECT name, cost,
RANK() OVER(ORDER BY cost)
AS `denserank` FROM cars;

-- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость

SELECT name, cost, 
SUM(cost) OVER() as 'sumcost'
FROM (SELECT name, cost,
RANK() OVER(ORDER BY cost DESC)
AS `denserank` FROM cars
LIMIT 3) AS tmp;

-- 3* Получить список автомобилей, у которых цена больше предыдущей цены

SELECT * FROM
(SELECT name,
cost - LAG(cost) OVER() `lagcost`
FROM cars) tmp
WHERE lagcost > 0;

-- 4* Получить список автомобилей, у которых цена меньше следующей цены

SELECT * FROM
(SELECT name,
cost - LEAD(cost) OVER() `leadcost`
FROM cars) tmp
WHERE leadcost < 0;

-- 5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля

SELECT name, cost, 
ABS(cost - LEAD(cost) OVER()) `leadcost` 
FROM cars 
ORDER BY cost;