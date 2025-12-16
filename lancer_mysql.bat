Microsoft Windows [version 10.0.19045.6466]
(c) Microsoft Corporation. Tous droits réservés.

C:\Users\HP>mysql -u root -p
'mysql' n’est pas reconnu en tant que commande interne
ou externe, un programme exécutable ou un fichier de commandes.

C:\Users\HP>cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p
Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 8.0.40 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE banque_demo
    ->   CHARACTER SET utf8mb4
    ->   COLLATE utf8mb4_unicode_ci;
ERROR 1007 (HY000): Can't create database 'banque_demo'; database exists
mysql>
mysql> USE banque_demo;
Database changed
mysql> CREATE TABLE comptes (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     nom_client VARCHAR(50) NOT NULL,
    ->     solde DECIMAL(10,2) NOT NULL
    -> );
Query OK, 0 rows affected (0.24 sec)

mysql>
mysql> CREATE TABLE transactions (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     compte_id INT NOT NULL,
    ->     montant DECIMAL(10,2) NOT NULL,
    ->     date_trans DATETIME DEFAULT CURRENT_TIMESTAMP,
    ->     FOREIGN KEY (compte_id) REFERENCES comptes(id)
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> INSERT INTO comptes (nom_client, solde) VALUES
    -> ('Alice', 1000.00),
    -> ('Bob', 500.00);
Query OK, 2 rows affected (0.03 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO transactions (compte_id, montant) VALUES
    -> (1, 1000.00),
    -> (2, 500.00);
Query OK, 2 rows affected (0.03 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE compte SET solde = solde - 200.00 WHERE titulaire = 'Alice';
Query OK, 0 rows affected (0.01 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> UPDATE compte SET solde = solde + 200.00 WHERE titulaire = 'Bob';
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM compte;
Empty set (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE compte SET solde = solde - 2000.00 WHERE titulaire = 'Alice';
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> UPDATE compte SET solde = solde + 2000.00 WHERE titulaire = 'Bob';
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM compte;
Empty set (0.00 sec)

mysql> SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
Query OK, 0 rows affected (0.01 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT solde FROM compte WHERE titulaire = 'Alice';  -- Lecture initiale
Empty set (0.00 sec)

mysql>
mysql> CREATE TABLE compte (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     titulaire VARCHAR(50) NOT NULL,
    ->     solde DECIMAL(10,2) NOT NULL
    -> );
ERROR 1050 (42S01): Table 'compte' already exists
mysql>
mysql> INSERT INTO compte (titulaire, solde) VALUES
    -> ('Alice', 1000.00),
    -> ('Bob', 500.00);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Choisir le niveau d’isolation
mysql> SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> -- Démarrer la transaction
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> -- Lecture initiale
mysql> SELECT solde FROM compte WHERE titulaire = 'Alice';
+---------+
| solde   |
+---------+
| 1000.00 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT solde FROM compte WHERE titulaire = 'Alice';  -- Résultat différent selon isolation
+---------+
| solde   |
+---------+
| 1100.00 |
+---------+
1 row in set (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM compte
    -> WHERE titulaire = 'Alice'
    -> FOR UPDATE;
+----+-----------+---------+
| id | titulaire | solde   |
+----+-----------+---------+
|  1 | Alice     | 1100.00 |
+----+-----------+---------+
1 row in set (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'P@ssw0rd!';
Query OK, 0 rows affected (0.15 sec)

mysql> GRANT SELECT, INSERT, UPDATE ON banque_demo.compte TO 'app_user'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.02 sec)

mysql> mysql -u app_user -p banque_demo
    ->
    -> REVOKE UPDATE ON banque_demo.compte FROM 'app_user'@'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'mysql -u app_user -p banque_demo

REVOKE UPDATE ON banque_demo.compte FROM 'app_' at line 1
mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)

mysql>