```sql
mysql> DROP DATABASE IF EXISTS `HW4`;
Query OK, 5 rows affected (0,02 sec)

mysql> CREATE DATABASE IF NOT EXISTS `HW4`;
Query OK, 1 row affected (0,00 sec)

mysql> USE HW4;
Database changed
mysql> DROP TABLE IF EXISTS `shops`;
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> CREATE TABLE `shops` (
    -> `id` INT,
    ->     `shopname` VARCHAR (100),
    ->     PRIMARY KEY (id)
    -> );
Query OK, 0 rows affected (0,00 sec)

mysql> 
mysql> DROP TABLE IF EXISTS `cats`;
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> CREATE TABLE `cats` (
    -> `name` VARCHAR (100),
    ->     `id` INT,
    ->     PRIMARY KEY (id),
    ->     shops_id INT,
    ->     CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
    ->         REFERENCES `shops` (id)
    -> );
Query OK, 0 rows affected (0,01 sec)

mysql> INSERT INTO `shops`
    -> VALUES
    -> (1, "Четыре лапы"),
    -> (2, "Мистер Зоо"),
    -> (3, "МурзиЛЛа"),
    -> (4, "Кошки и собаки");
Query OK, 4 rows affected (0,00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO `cats`
    -> VALUES 
    -> ("Murzik",1,1),
    -> ("Nemo",2,2),
    -> ("Vicont",3,1),
    -> ("Zuza",4,3);
Query OK, 4 rows affected (0,01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> DROP TABLE IF EXISTS analysis;
Query OK, 0 rows affected, 1 warning (0,00 sec)

mysql> 
mysql> CREATE TABLE analysis
2    -> (
    -> an_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -> an_name varchar(50),
    -> an_cost INT,
    -> an_price INT,
    -> an_group INT
    -> );
Query OK, 0 rows affected (0,01 sec)

mysql> 
mysql> INSERT INTO analysis (an_name, an_cost, an_price, an_group)
    -> VALUES 
    -> ('Общий анализ крови', 30, 50, 1),
    -> ('Биохимия крови', 150, 210, 1),
    -> ('Анализ крови на глюкозу', 110, 130, 1),
    -> ('Общий анализ мочи', 25, 40, 2),
    -> ('Общий анализ кала', 35, 50, 2),
    -> ('Общий анализ мочи', 25, 40, 2),
    -> ('Тест на COVID-19', 160, 210, 3);
Query OK, 7 rows affected (0,00 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> 
mysql> DROP TABLE IF EXISTS groupsan;
Query OK, 0 rows affected, 1 warning (0,00 sec)

mysql> 
mysql> CREATE TABLE groupsan
    -> (
    -> gr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -> gr_name varchar(50),
    -> gr_temp FLOAT(5,1),
    -> FOREIGN KEY (gr_id) REFERENCES analysis (an_id)
    -> ON DELETE CASCADE ON UPDATE CASCADE
    -> );
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> 
mysql> INSERT INTO groupsan (gr_name, gr_temp)
    -> VALUES 
    -> ('Анализы крови', -12.2),
    -> ('Общие анализы', -20.0),
    -> ('ПЦР-диагностика', -20.5);
Query OK, 3 rows affected (0,00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> 
mysql> SELECT * FROM groupsan;
+-------+-------------------------------+---------+
| gr_id | gr_name                       | gr_temp |
+-------+-------------------------------+---------+
|     1 | Анализы крови                 |   -12.2 |
|     2 | Общие анализы                 |   -20.0 |
|     3 | ПЦР-диагностика               |   -20.5 |
+-------+-------------------------------+---------+
3 rows in set (0,01 sec)

mysql> 
mysql> DROP TABLE IF EXISTS orders;
Query OK, 0 rows affected, 1 warning (0,00 sec)

mysql> CREATE TABLE orders
    -> (
    -> ord_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -> ord_datetime DATETIME,-- 'YYYY-MM-DD hh:mm:ss'
    -> ord_an INT,
    -> FOREIGN KEY (ord_an) REFERENCES analysis (an_id)
    -> ON DELETE CASCADE ON UPDATE CASCADE
    -> );
Query OK, 0 rows affected (0,01 sec)

mysql> 
mysql> INSERT INTO orders (ord_datetime, ord_an)
    -> VALUES 
    -> ('2020-02-04 07:15:25', 1),
    -> ('2020-02-04 07:20:50', 2),
    -> ('2020-02-04 07:30:04', 1),
    -> ('2020-02-04 07:40:57', 1),
    -> ('2020-02-05 07:05:14', 1),
    -> ('2020-02-05 07:15:15', 3),
    -> ('2020-02-05 07:30:49', 3),
    -> ('2020-02-06 07:10:10', 2),
    -> ('2020-02-06 07:20:38', 2),
    -> ('2020-02-07 07:05:09', 1),
    -> ('2020-02-07 07:10:54', 1),
    -> ('2020-02-07 07:15:25', 1),
    -> ('2020-02-08 07:05:44', 1),
    -> ('2020-02-08 07:10:39', 2),
    -> ('2020-02-08 07:20:36', 1),
    -> ('2020-02-08 07:25:26', 3),
    -> ('2020-02-09 07:05:06', 1),
    -> ('2020-02-09 07:10:34', 1),
    -> ('2020-02-09 07:20:19', 2),
    -> ('2020-02-10 07:05:55', 3),
    -> ('2020-02-10 07:15:08', 3),
    -> ('2020-02-10 07:25:07', 1),
    -> ('2020-02-11 07:05:33', 1),
    -> ('2020-02-11 07:10:32', 2),
    -> ('2020-02-11 07:20:17', 3),
    -> ('2020-02-12 07:05:36', 1),
    -> ('2020-02-12 07:10:54', 2),
    -> ('2020-02-12 07:20:19', 3),
    -> ('2020-02-12 07:35:38', 1);
Query OK, 29 rows affected (0,00 sec)
Records: 29  Duplicates: 0  Warnings: 0

mysql> /*
   /*> Условие:
   /*> Табличка: https://docs.google.com/document/d/1kEwTJhGJeyfNFdr8t7O4ioiqiFthoy4cQZ2CKaDuwY8/edit?usp=sharing
   /*> Используя JOIN-ы, выполните следующие операции:
   /*> 1.Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
   /*> 2.Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
   /*> 3.Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
   /*> Табличка (после слов “Последнее задание, таблица:”)
   /*> 4.Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.*/
mysql> -- 1 Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
mysql> SELECT cats.name, shops.shopname
    -> FROM cats
    -> JOIN shops
    -> ON shops.id = cats.shops_id;
+--------+-----------------------+
| name   | shopname              |
+--------+-----------------------+
| Murzik | Четыре лапы           |
| Nemo   | Мистер Зоо            |
| Vicont | Четыре лапы           |
| Zuza   | МурзиЛЛа              |
+--------+-----------------------+
4 rows in set (0,00 sec)

mysql> -- 2 Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
mysql> SELECT shops.shopname
    -> FROM (SELECT * FROM cats WHERE name = 'Murzik') AS murziks
    -> JOIN shops
    -> ON shops.id = murziks.shops_id;
+-----------------------+
| shopname              |
+-----------------------+
| Четыре лапы           |
+-----------------------+
1 row in set (0,00 sec)

mysql> 
mysql> SELECT shops.shopname
    -> FROM cats
    -> JOIN shops
    -> ON shops.id = cats.shops_id AND name = 'Murzik';
+-----------------------+
| shopname              |
+-----------------------+
| Четыре лапы           |
+-----------------------+
1 row in set (0,00 sec)

mysql> -- 3 Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
mysql> SELECT shops.shopname
    -> FROM cats
    -> JOIN shops
    -> ON shops.id = cats.shops_id AND name != 'Murzik' AND name != 'Zuza';
+-----------------------+
| shopname              |
+-----------------------+
| Мистер Зоо            |
| Четыре лапы           |
+-----------------------+
2 rows in set (0,00 sec)

mysql> -- 4 Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
mysql> SELECT a.an_name, a.an_price, o.ord_datetime
    -> FROM analysis a
    -> INNER JOIN orders o ON a.an_id = o.ord_an
    -> WHERE o.ord_datetime >= '2020-02-05' AND o.ord_datetime < '2020-02-13';
+---------------------------------------------+----------+---------------------+
| an_name                                     | an_price | ord_datetime        |
+---------------------------------------------+----------+---------------------+
| Общий анализ крови                          |       50 | 2020-02-05 07:05:14 |
| Общий анализ крови                          |       50 | 2020-02-07 07:05:09 |
| Общий анализ крови                          |       50 | 2020-02-07 07:10:54 |
| Общий анализ крови                          |       50 | 2020-02-07 07:15:25 |
| Общий анализ крови                          |       50 | 2020-02-08 07:05:44 |
| Общий анализ крови                          |       50 | 2020-02-08 07:20:36 |
| Общий анализ крови                          |       50 | 2020-02-09 07:05:06 |
| Общий анализ крови                          |       50 | 2020-02-09 07:10:34 |
| Общий анализ крови                          |       50 | 2020-02-10 07:25:07 |
| Общий анализ крови                          |       50 | 2020-02-11 07:05:33 |
| Общий анализ крови                          |       50 | 2020-02-12 07:05:36 |
| Общий анализ крови                          |       50 | 2020-02-12 07:35:38 |
| Биохимия крови                              |      210 | 2020-02-06 07:10:10 |
| Биохимия крови                              |      210 | 2020-02-06 07:20:38 |
| Биохимия крови                              |      210 | 2020-02-08 07:10:39 |
| Биохимия крови                              |      210 | 2020-02-09 07:20:19 |
| Биохимия крови                              |      210 | 2020-02-11 07:10:32 |
| Биохимия крови                              |      210 | 2020-02-12 07:10:54 |
| Анализ крови на глюкозу                     |      130 | 2020-02-05 07:15:15 |
| Анализ крови на глюкозу                     |      130 | 2020-02-05 07:30:49 |
| Анализ крови на глюкозу                     |      130 | 2020-02-08 07:25:26 |
| Анализ крови на глюкозу                     |      130 | 2020-02-10 07:05:55 |
| Анализ крови на глюкозу                     |      130 | 2020-02-10 07:15:08 |
| Анализ крови на глюкозу                     |      130 | 2020-02-11 07:20:17 |
| Анализ крови на глюкозу                     |      130 | 2020-02-12 07:20:19 |
+---------------------------------------------+----------+---------------------+
25 rows in set (0,00 sec)
```