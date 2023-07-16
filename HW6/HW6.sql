DROP DATABASE IF EXISTS HW6;
CREATE DATABASE IF NOT EXISTS HW6;

USE HW6;

-- 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DELIMITER // 
CREATE FUNCTION format_seconds(seconds INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE result VARCHAR(255);

    SET days = seconds DIV 86400;
    SET seconds = seconds % 86400;
    SET hours = seconds DIV 3600;
    SET seconds = seconds % 3600;
    SET minutes = seconds DIV 60;
    SET seconds = seconds % 60;

    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');

    RETURN result;
END //

DELIMITER ;

SELECT format_seconds(123456);

-- 2. Создайте процедуру, которая выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS while_cycle;
DELIMITER //
CREATE PROCEDURE while_cycle (a INT) 
BEGIN
	DECLARE i INT DEFAULT 2;
    DECLARE b VARCHAR(200) DEFAULT "2";
	WHILE i < a DO
		SET i = i + 2;
        SET b = CONCAT(b,', ' , i);
	END WHILE;
    SELECT b;
END //
DELIMITER ;

CALL while_cycle (100);

