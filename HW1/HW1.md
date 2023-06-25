```sql
mysql> CREATE SCHEMA HW1;
Query OK, 1 row affected (0.01 sec)

mysql> USE HW1;
Database changed
mysql> CREATE TABLE Products
    (Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL);
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO Products 
    (ProductName, Manufacturer, ProductCount, Price)VALUES
    ('iPhone X', 'Apple', 3, 76000),
    ('iPhone 8', 'Apple', 2, 51000),
    ('Galaxy S9', 'Samsung', 2, 56000),
    ('Galaxy S8', 'Samsung', 1, 41000),
    ('P20 Pro', 'Huawei', 5, 36000);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT ProductName, Manufacturer, Price 
        FROM Products 
        WHERE ProductCount > 2;
+-------------+--------------+-------+
| ProductName | Manufacturer | Price |
+-------------+--------------+-------+
| iPhone X    | Apple        | 76000 |
| P20 Pro     | Huawei       | 36000 |
+-------------+--------------+-------+
2 rows in set (0.00 sec)

mysql> SELECT * 
        FROM Products 
        WHERE Manufacturer = 'Samsung';
+----+-------------+--------------+--------------+-------+
| Id | ProductName | Manufacturer | ProductCount | Price |
+----+-------------+--------------+--------------+-------+
|  3 | Galaxy S9   | Samsung      |            2 | 56000 |
|  4 | Galaxy S8   | Samsung      |            1 | 41000 |
+----+-------------+--------------+--------------+-------+
2 rows in set (0.00 sec)

mysql> SELECT * 
        FROM Products 
        WHERE ProductName LIKE '%Iphone%';
+----+-------------+--------------+--------------+-------+
| Id | ProductName | Manufacturer | ProductCount | Price |
+----+-------------+--------------+--------------+-------+
|  1 | iPhone X    | Apple        |            3 | 76000 |
|  2 | iPhone 8    | Apple        |            2 | 51000 |
+----+-------------+--------------+--------------+-------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Products WHERE ProductName LIKE '%Samsung%';
Empty set (0.00 sec)

mysql> SELECT * FROM Products WHERE ProductName OR Manufacturer LIKE '%Samsung%';
+----+-------------+--------------+--------------+-------+
| Id | ProductName | Manufacturer | ProductCount | Price |
+----+-------------+--------------+--------------+-------+
|  3 | Galaxy S9   | Samsung      |            2 | 56000 |
|  4 | Galaxy S8   | Samsung      |            1 | 41000 |
+----+-------------+--------------+--------------+-------+
2 rows in set, 5 warnings (0.00 sec)

mysql> SELECT * 
        FROM Products 
        WHERE ProductName LIKE '%8%';
+----+-------------+--------------+--------------+-------+
| Id | ProductName | Manufacturer | ProductCount | Price |
+----+-------------+--------------+--------------+-------+
|  2 | iPhone 8    | Apple        |            2 | 51000 |
|  4 | Galaxy S8   | Samsung      |            1 | 41000 |
+----+-------------+--------------+--------------+-------+
2 rows in set (0.00 sec)
```