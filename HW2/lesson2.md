```sql
mysql> DROP DATABASE IF EXISTS HW2;
Query OK, 2 rows affected (0,01 sec)

mysql> CREATE DATABASE IF NOT EXISTS HW2;
Query OK, 1 row affected (0,00 sec)

mysql> 
mysql> USE HW2;
Database changed
mysql> 
mysql> DROP TABLE IF EXISTS sales;
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> CREATE TABLE IF NOT EXISTS sales
    -> (
    -> id INT PRIMARY KEY AUTO_INCREMENT,
    -> order_date DATE NOT NULL,
    -> count_product INT);
Query OK, 0 rows affected (0,01 sec)

mysql> 
mysql> INSERT INTO sales (order_date, count_product)
    -> VALUES 
    -> ('2022-01-01', 156),
    ->     ('2022-01-02', 180),
    ->     ('2022-01-03', 21),
    ->     ('2022-01-04', 124),
    ->     ('2022-01-05', 341);
Query OK, 5 rows affected (0,00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE sales
    -> 
    -> ADD COLUMN order_type VARCHAR(50) GENERATED ALWAYS AS (
    ->     CASE
    ->         WHEN count_product < 100 THEN 'Маленький заказ'
    ->         WHEN count_product >= 100 AND count_product <= 300 THEN 'Средний заказ'
    ->         WHEN count_product > 300 THEN 'Большой заказ'
    ->         ELSE 'Не определено'
    ->     END
    -> ) VIRTUAL;
Query OK, 0 rows affected (0,01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> 
mysql> SELECT * FROM sales;
+----+------------+---------------+-------------------------------+
| id | order_date | count_product | order_type                    |
+----+------------+---------------+-------------------------------+
|  1 | 2022-01-01 |           156 | Средний заказ                 |
|  2 | 2022-01-02 |           180 | Средний заказ                 |
|  3 | 2022-01-03 |            21 | Маленький заказ               |
|  4 | 2022-01-04 |           124 | Средний заказ                 |
|  5 | 2022-01-05 |           341 | Большой заказ                 |
+----+------------+---------------+-------------------------------+
5 rows in set (0,00 sec)

mysql> DROP TABLE IF EXISTS orders;
Query OK, 0 rows affected, 1 warning (0,00 sec)

mysql> CREATE TABLE IF NOT EXISTS orders
    -> (
    -> id INT PRIMARY KEY AUTO_INCREMENT,
    -> employee_id VARCHAR(3),
    -> amount DOUBLE,
    -> order_status VARCHAR(9));
Query OK, 0 rows affected (0,01 sec)

mysql> INSERT INTO orders (employee_id, amount, order_status)
    -> VALUES 
    -> ('e03', 15.00, 'OPEN'),
    ->     ('e01', 25.50, 'OPEN'),
    ->     ('e05', 100.70, 'CLOSED'),
    ->     ('e02', 22.18, 'OPEN'),
    ->     ('e04', 9.50, 'CANCELLED');
Query OK, 5 rows affected (0,00 sec)
Records: 5  Duplicates: 0  Warnings: 0
mysql> SELECT *, IF(order_status = 'OPEN', 'Order is in open state', IF(order_status = 'CLOSED', 'Order is closed', IF(order_status = 'CANCELLED', 'Order is cancelled', 'Undefined'))) AS full_order_status FROM orders;
+----+-------------+--------+--------------+------------------------+
| id | employee_id | amount | order_status | full_order_status      |
+----+-------------+--------+--------------+------------------------+
|  1 | e03         |     15 | OPEN         | Order is in open state |
|  2 | e01         |   25.5 | OPEN         | Order is in open state |
|  3 | e05         |  100.7 | CLOSED       | Order is closed        |
|  4 | e02         |  22.18 | OPEN         | Order is in open state |
|  5 | e04         |    9.5 | CANCELLED    | Order is cancelled     |
+----+-------------+--------+--------------+------------------------+
5 rows in set (0,00 sec)
```