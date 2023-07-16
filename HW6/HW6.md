```sql
mysql> DROP DATABASE IF EXISTS HW6;
Query OK, 0 rows affected (0,00 sec)

mysql> CREATE DATABASE IF NOT EXISTS HW6;
Query OK, 1 row affected (0,00 sec)

mysql> 
mysql> USE HW6;
Database changed
mysql> 
mysql> -- 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
mysql> 
mysql> DELIMITER // 
mysql> CREATE FUNCTION format_seconds(seconds INT)
    -> RETURNS VARCHAR(255)
    -> DETERMINISTIC
    -> BEGIN
    ->     DECLARE days INT;
    ->     DECLARE hours INT;
    ->     DECLARE minutes INT;
    ->     DECLARE result VARCHAR(255);
    -> 
    ->     SET days = seconds DIV 86400;
    ->     SET seconds = seconds % 86400;
    ->     SET hours = seconds DIV 3600;
    ->     SET seconds = seconds % 3600;
    ->     SET minutes = seconds DIV 60;
    ->     SET seconds = seconds % 60;
    -> 
    ->     SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
    -> 
    ->     RETURN result;
    -> END //
Query OK, 0 rows affected (0,00 sec)

mysql> 
mysql> DELIMITER ;
mysql> 
mysql> SELECT format_seconds(123456);
+---------------------------------------+
| format_seconds(123456)                |
+---------------------------------------+
| 1 days 10 hours 17 minutes 36 seconds |
+---------------------------------------+
1 row in set (0,00 sec)

mysql> 
mysql> -- 2. Создайте процедуру, которая выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10
mysql> DROP PROCEDURE IF EXISTS while_cycle;
Query OK, 0 rows affected, 1 warning (0,00 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE while_cycle (a INT) 
    -> BEGIN
    -> DECLARE i INT DEFAULT 2;
    ->     DECLARE b VARCHAR(200) DEFAULT "2";
    -> WHILE i < a DO
    -> 
Display all 767 possibilities? (y or n) 
    -> SET i = i + 2;
    ->         SET b = CONCAT(b,', ' , i);
    -> END WHILE;
    ->     SELECT b;
    -> END //
Query OK, 0 rows affected (0,00 sec)

mysql> DELIMITER ;
mysql> 
mysql> CALL while_cycle (100);
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| b                                                                                                                                                                                                   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100 |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```