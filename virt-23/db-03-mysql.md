## Домашнее задание к занятию "3. MySQL" Нечаев Владимир

<details>
<summary>Задача 1</summary>
  
>
> Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
>
>Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.
>
> Перейдите в управляющую консоль `mysql` внутри контейнера.
>
> Используя команду `\h` получите список управляющих команд.
> 
> Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.
>
> Подключитесь к восстановленной БД и получите список таблиц из этой БД.
>
> **Приведите в ответе** количество записей с `price` > 300.
>
> В следующих заданиях мы будем продолжать работу с данным контейнером.

  </details>

#### Ответ:

`версия сервера БД`
```sql
mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          11
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.32 MySQL Community Server - GPL
Protocol version:       10
...
```

`список таблиц`
```sql
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```

`количество записей с `price` > 300`
```sql
mysql> SELECT count(*) FROM orders WHERE price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

<details>
  
  ```bash
  # Запуск mysql из каталога mysql
docker run --rm --name mysql -e MYSQL_DATABASE=test_db -e MYSQL_ROOT_PASSWORD=123 -v $PWD/backup:/media/mysql/backup -v $PWD/data:/var/lib/mysql -p 3306:3306 -d mysql:8
# Копирование дампа
docker cp test_dump.sql mysql:/var/tmp/test_dump.sql
# Connect
docker exec -it mysql bash
\r test_db # Connect to MYSQL_DATABASE
\s # status 
SELECT count(*) FROM orders WHERE price > 300; # количество записей с price > 300
  ```

  </details>

<details>
<summary>Задача 2</summary>
  
> Создайте пользователя test в БД c паролем test-pass, используя:
> - плагин авторизации mysql_native_password
> - срок истечения пароля - 180 дней 
> - количество попыток авторизации - 3 
> - максимальное количество запросов в час - 100
> - аттрибуты пользователя:
>    - Фамилия "Pretty"
>    - Имя "James"
>
> Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
>    
>Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.
  
</details>

#### Ответ:

```sql
mysql> SELECT * from INFORMATION_SCHEMA.USER_ATTRIBUTES where USER = 'test';
+------+-----------+-------------------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                                   |
+------+-----------+-------------------------------------------------------------+
| test | localhost | {"": "James", "last_name": "Pretty", "first_name": "James"} |
+------+-----------+-------------------------------------------------------------+
1 row in set (0.00 sec)
```

<details>
  
  ```sql
# Создание пользователя "test"
CREATE USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass'
 WITH MAX_QUERIES_PER_HOUR 100
 PASSWORD EXPIRE INTERVAL 180 DAY
 FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 1
 ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
# привелегии пользователю test на операции SELECT базы test_db
GRANT SELECT ON `test_db`.* TO 'test'@'localhost';
FLUSH PRIVILEGES;
# данные по пользователю test
SELECT * from INFORMATION_SCHEMA.USER_ATTRIBUTES where USER = 'test';
  ```

  </details>
  
 <details>
<summary>Задача 3</summary>
  
> Установите профилирование `SET profiling = 1`.
> Изучите вывод профилирования команд `SHOW PROFILES;`.
>
> Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
>
> Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
> - на `MyISAM`
> - на `InnoDB`

 </details>
    
#### Ответ:

`какой `engine` используется в таблице БД`
```sql
mysql> SHOW TABLE STATUS WHERE Name = 'orders'\G;
*************************** 1. row ***************************
Name: orders
Engine: InnoDB
Version: 10
Row_format: Dynamic
Rows: 5
Avg_row_length: 3276
Data_length: 16384
Max_data_length: 0
Index_length: 0
Data_free: 0
Auto_increment: 6
Create_time: 2023-02-14 08:52:23
Update_time: 2023-02-14 08:52:23
Check_time: NULL
Collation: utf8mb4_0900_ai_ci
Checksum: NULL
Create_options: 
Comment: 
1 row in set (0.03 sec)

mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.01 sec)
```

`время выполнения и запрос на изменения из профайлера`
```sql
mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                   |
+----------+------------+-----------------------------------------------------------------------------------------+
|        1 | 0.03660250 | SHOW TABLE STATUS WHERE Name = 'orders'                                                 |
|        2 | 0.00200975 | SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db' |
|        3 | 0.42235775 | ALTER TABLE orders ENGINE = MyISAM                                                      |
|        4 | 0.64364575 | ALTER TABLE orders ENGINE = InnoDB                                                      |
|        5 | 0.58269925 | ALTER TABLE orders ENGINE = MyISAM                                                      |
|        6 | 0.51075050 | ALTER TABLE orders ENGINE = InnoDB                                                      |
|        7 | 0.00011200 | ALTER TABLE orders ENGINE = MyISA                                                       |
|        8 | 0.60829775 | ALTER TABLE orders ENGINE = InnoDB                                                      |
|        9 | 0.00012200 | ALTER TABLE orders ENGINE = MyISA                                                       |
|       10 | 0.00010425 | ALTER TABLE orders ENGINE = MyISA                                                       |
|       11 | 0.00012400 | ALTER TABLE orders ENGINE = MyISA                                                       |
+----------+------------+-----------------------------------------------------------------------------------------+
11 rows in set, 1 warning (0.00 sec)
```

<details>
<summary>Задача 4</summary>

> Изучите файл `my.cnf` в директории /etc/mysql.
> 
> Измените его согласно ТЗ (движок InnoDB):
> - Скорость IO важнее сохранности данных
> - Нужна компрессия таблиц для экономии места на диске
> - Размер буффера с незакомиченными транзакциями 1 Мб
> - Буффер кеширования 30% от ОЗУ
> - Размер файла логов операций 100 Мб
>
> Приведите в ответе измененный файл `my.cnf`.

 </details>
    
#### Ответ:

`my.cnf`
```bash
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/
```

`добавим в вайл`
```bash
innodb_flush_method = O_DSYNC
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = ON
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 2400M
innodb_log_file_size = 100M
```
