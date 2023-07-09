```sql
mysql> DROP DATABASE IF EXISTS HW5;
Query OK, 4 rows affected (0,02 sec)

mysql> CREATE DATABASE HW5;
Query OK, 1 row affected (0,00 sec)

mysql> USE HW5;
Database changed
mysql> 
mysql> DROP TABLE IF EXISTS cars;
Query OK, 0 rows affected, 1 warning (0,00 sec)

mysql> CREATE TABLE IF NOT EXISTS cars
    -> (
    -> id INT NOT NULL PRIMARY KEY,
    ->     name VARCHAR(45),
    ->     cost INT
    -> );
Query OK, 0 rows affected (0,01 sec)

mysql> 
mysql> INSERT cars
    -> VALUES
    -> (1, "Audi", 52642),
    ->     (2, "Mercedes", 57127 ),
    ->     (3, "Skoda", 9000 ),
    ->     (4, "Volvo", 29000),
    -> (5, "Bentley", 350000),
    ->     (6, "Citroen ", 21000 ), 
    ->     (7, "Hummer", 41400), 
    ->     (8, "Volkswagen ", 21600);
Query OK, 8 rows affected (0,01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql>     
mysql> SELECT *
    -> FROM cars;
+----+-------------+--------+
| id | name        | cost   |
+----+-------------+--------+
|  1 | Audi        |  52642 |
|  2 | Mercedes    |  57127 |
|  3 | Skoda       |   9000 |
|  4 | Volvo       |  29000 |
|  5 | Bentley     | 350000 |
|  6 | Citroen     |  21000 |
|  7 | Hummer      |  41400 |
|  8 | Volkswagen  |  21600 |
+----+-------------+--------+
8 rows in set (0,00 sec)

mysql> 
mysql> /*
   /*> 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
   /*> 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
   /*> 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
   /*> 
   /*> Доп задания:
   /*> 1* Получить ранжированный список автомобилей по цене в порядке возрастания
   /*> 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
   /*> 3* Получить список автомобилей, у которых цена больше предыдущей цены
   /*> 4* Получить список автомобилей, у которых цена меньше следующей цены
   /*> 5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
   /*> */   
mysql> 
mysql> -- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
mysql> 
mysql> CREATE OR REPLACE VIEW under25000 AS
    -> SELECT * FROM cars
    -> WHERE cost >= 25000;
Query OK, 0 rows affected (0,00 sec)

mysql> SELECT * FROM under25000;
+----+----------+--------+
| id | name     | cost   |
+----+----------+--------+
|  1 | Audi     |  52642 |
|  2 | Mercedes |  57127 |
|  4 | Volvo    |  29000 |
|  5 | Bentley  | 350000 |
|  7 | Hummer   |  41400 |
+----+----------+--------+
5 rows in set (0,00 sec)

mysql> 
mysql> -- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
mysql> 
mysql> ALTER VIEW under25000 AS
    -> SELECT * FROM cars
    -> WHERE cost <= 30000;
Query OK, 0 rows affected (0,00 sec)

mysql> SELECT * FROM under25000;
+----+-------------+-------+
| id | name        | cost  |
+----+-------------+-------+
|  3 | Skoda       |  9000 |
|  4 | Volvo       | 29000 |
|  6 | Citroen     | 21000 |
|  8 | Volkswagen  | 21600 |
+----+-------------+-------+
4 rows in set (0,00 sec)

mysql> 
mysql> -- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
mysql> 
mysql> CREATE OR REPLACE VIEW Skodaudi AS
    -> SELECT * FROM cars
    -> WHERE name = 'Skoda' OR name = 'Audi';
Query OK, 0 rows affected (0,01 sec)

mysql> SELECT * FROM Skodaudi;
+----+-------+-------+
| id | name  | cost  |
+----+-------+-------+
|  1 | Audi  | 52642 |
|  3 | Skoda |  9000 |
+----+-------+-------+
2 rows in set (0,00 sec)

mysql> 
mysql> -- 1* Получить ранжированный список автомобилей по цене в порядке возрастания
mysql> 
mysql> SELECT name, cost,
    -> RANK() OVER(ORDER BY cost)
    -> AS `denserank` FROM cars;
+-------------+--------+-----------+
| name        | cost   | denserank |
+-------------+--------+-----------+
| Skoda       |   9000 |         1 |
| Citroen     |  21000 |         2 |
| Volkswagen  |  21600 |         3 |
| Volvo       |  29000 |         4 |
| Hummer      |  41400 |         5 |
| Audi        |  52642 |         6 |
| Mercedes    |  57127 |         7 |
| Bentley     | 350000 |         8 |
+-------------+--------+-----------+
8 rows in set (0,00 sec)

mysql> 
mysql> -- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
mysql> 
mysql> SELECT name, cost, 
    -> SUM(cost) OVER() as 'sumcost'
    -> FROM (SELECT name, cost,
    -> RANK() OVER(ORDER BY cost DESC)
    -> AS `denserank` FROM cars
    -> LIMIT 3) AS tmp;
+----------+--------+---------+
| name     | cost   | sumcost |
+----------+--------+---------+
| Bentley  | 350000 |  459769 |
| Mercedes |  57127 |  459769 |
| Audi     |  52642 |  459769 |
+----------+--------+---------+
3 rows in set (0,00 sec)

mysql> 
mysql> -- 3* Получить список автомобилей, у которых цена больше предыдущей цены
mysql> 
mysql> SELECT * FROM
    -> (SELECT name,
    -> cost - LAG(cost) OVER() `lagcost`
    -> FROM cars) tmp
    -> WHERE lagcost > 0;
+----------+---------+
| name     | lagcost |
+----------+---------+
| Mercedes |    4485 |
| Volvo    |   20000 |
| Bentley  |  321000 |
| Hummer   |   20400 |
+----------+---------+
4 rows in set (0,00 sec)

mysql> 
mysql> -- 4* Получить список автомобилей, у которых цена меньше следующей цены
mysql> 
mysql> SELECT * FROM
    -> (SELECT name,
    -> cost - LEAD(cost) OVER() `leadcost`
    -> FROM cars) tmp
    -> WHERE leadcost < 0;
+----------+----------+
| name     | leadcost |
+----------+----------+
| Audi     |    -4485 |
| Skoda    |   -20000 |
| Volvo    |  -321000 |
| Citroen  |   -20400 |
+----------+----------+
4 rows in set (0,00 sec)

mysql> 
mysql> -- 5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля
mysql> 
mysql> SELECT name, cost, 
    -> ABS(cost - LEAD(cost) OVER()) `leadcost` 
    -> FROM cars 
    -> ORDER BY cost;
+-------------+--------+----------+
| name        | cost   | leadcost |
+-------------+--------+----------+
| Skoda       |   9000 |    12000 |
| Citroen     |  21000 |      600 |
| Volkswagen  |  21600 |     7400 |
| Volvo       |  29000 |    12400 |
| Hummer      |  41400 |    11242 |
| Audi        |  52642 |     4485 |
| Mercedes    |  57127 |   292873 |
| Bentley     | 350000 |     NULL |
+-------------+--------+----------+
8 rows in set (0,00 sec)
```