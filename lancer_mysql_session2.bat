Microsoft Windows [version 10.0.19045.6466]
(c) Microsoft Corporation. Tous droits réservés.

C:\Users\HP>UPDATE compte SET solde = solde + 100.00 WHERE titulaire = 'Alice';
'UPDATE' n’est pas reconnu en tant que commande interne
ou externe, un programme exécutable ou un fichier de commandes.

C:\Users\HP>COMMIT;
'COMMIT' n’est pas reconnu en tant que commande interne
ou externe, un programme exécutable ou un fichier de commandes.

C:\Users\HP>UPDATE compte SET solde = solde + 100.00 WHERE titulaire = 'Alice';
'UPDATE' n’est pas reconnu en tant que commande interne
ou externe, un programme exécutable ou un fichier de commandes.

C:\Users\HP>COMMIT;
'COMMIT' n’est pas reconnu en tant que commande interne
ou externe, un programme exécutable ou un fichier de commandes.

C:\Users\HP>cd "C:\Program Files\MySQL\MySQL Server
Le chemin d’accès spécifié est introuvable.

C:\Users\HP>cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p
Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 26
Server version: 8.0.40 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE banque_demo;
Database changed
mysql> UPDATE compte SET solde = solde + 100.00 WHERE titulaire = 'Alice';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE compte SET solde = solde + 10.00 WHERE titulaire = 'Alice';
Query OK, 1 row affected (16.61 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>

