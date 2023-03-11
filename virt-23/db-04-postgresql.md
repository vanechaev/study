## Домашнее задание к занятию 4. «PostgreSQL» - Нечаев Владимир

<details>
<summary>Задача 1</summary>
  
> Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
>
> Подключитесь к БД PostgreSQL, используя `psql`.
>
> Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.
>
> **Найдите и приведите** управляющие команды для:
>
> - вывода списка БД,
> - подключения к БД,
> - вывода списка таблиц,
> - вывода описания содержимого таблиц,
> - выхода из psql.
  
  </details>

#### Ответ:

- Вывод списка БД - ` \l[+]   [PATTERN]      list databases`
- Подключение к БД - `\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}`
- Вывод списка таблиц - `\dt[S+] [PATTERN]      list tables`
- Вывод описания содержимого таблиц - ` \d[S+]  NAME           describe table, view, sequence, or index`
- Выход из psql - ` \q                     quit psql`

<details>
<summary>Задача 2</summary>

> Используя `psql`, создайте БД `test_database`.
>
> Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).
>
> Восстановите бэкап БД в `test_database`.
>
> Перейдите в управляющую консоль `psql` внутри контейнера.
>
> Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
>
> Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
> с наибольшим средним значением размера элементов в байтах.
>
> **Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.
  
  </details>

#### Ответ:

```sql
test_database=# select attname, avg_width from pg_stats where tablename='orders';
attname | avg_width
---------+-----------
id      |         4
title   |        16
price   |         4
(3 rows)
```

<details>
  
```bash
nva@Lenovo-G50-80:~/Docker/postgres/pg13$ docker exec -it b0b2ac75d473 bash
root@b0b2ac75d473:/# ls
backup  bin  boot  dev  docker-entrypoint-initdb.d  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@b0b2ac75d473:/# ls backup/
test  test_dump.sql
root@b0b2ac75d473:/# psql -U postgres -d test_database < /backup/test_dump.sql 
SET
SET
SET
SET
SET
set_config 
------------

(1 row)

SET
SET
SET
SET
SET
SET
ERROR:  relation "orders" already exists
ALTER TABLE
ERROR:  relation "orders_id_seq" already exists
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ERROR:  duplicate key value violates unique constraint "orders_pkey"
DETAIL:  Key (id)=(1) already exists.
CONTEXT:  COPY orders, line 1
setval 
--------
8
(1 row)

ERROR:  multiple primary keys for table "orders" are not allowed
root@b0b2ac75d473:/# su postgres
postgres@b0b2ac75d473:/$ psql
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
test_database=# select attname, avg_width from pg_stats where tablename='orders';
attname | avg_width 
---------+-----------
(0 rows)

test_database=# \dt
List of relations
Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
public | orders | table | postgres
(1 row)

test_database=# ANALYZE verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 8 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# select attname, avg_width from pg_stats where tablename='orders';
attname | avg_width
---------+-----------
id      |         4
title   |        16
price   |         4
(3 rows)
```
  
</details>

<details>
<summary>Задача 3</summary>
   
> Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
> поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
> провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.
>
> Предложите SQL-транзакцию для проведения этой операции.
>
> Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

</details>
 
#### Ответ:
  
```sql
BEGIN;
CREATE TABLE orders_1 (LIKE orders);
INSERT INTO orders_1 SELECT * FROM orders WHERE price >499;
DELETE FROM orders WHERE price >499;
CREATE TABLE orders_2 (LIKE orders);
INSERT INTO orders_2 SELECT * FROM orders WHERE price <=499;
DELETE FROM orders WHERE price <=499;
COMMIT;
```
  
<details>
  
```bash
test_database=# BEGIN;
CREATE TABLE orders_1 (LIKE orders);
INSERT INTO orders_1 SELECT * FROM orders WHERE price >499;
DELETE FROM orders WHERE price >499;
CREATE TABLE orders_2 (LIKE orders);
INSERT INTO orders_2 SELECT * FROM orders WHERE price <=499;
DELETE FROM orders WHERE price <=499;
COMMIT;
BEGIN
CREATE TABLE
INSERT 0 3
DELETE 3
CREATE TABLE
INSERT 0 5
DELETE 5
COMMIT
test_database=# SELECT * FROM public.orders;
id | title | price
----+-------+-------
(0 rows)

test_database=# SELECT * FROM public.orders_1;
id |       title        | price
----+--------------------+-------
2 | My little database |   500
6 | WAL never lies     |   900
8 | Dbiezdmin          |   501
(3 rows)

test_database=# SELECT * FROM public.orders_2;
id |        title         | price
----+----------------------+-------
1 | War and peace        |   100
3 | Adventure psql time  |   300
4 | Server gravity falls |   300
5 | Log gossips          |   123
7 | Me and my bash-pet   |   499
(5 rows)
```
  
</details>
  
Для исключения ручного разбиения при проектировании таблицы orders необходимо использовать декларативное секционирование с предложением PARTITION BY. 
[ссылка](https://postgrespro.ru/docs/postgrespro/14/ddl-partitioning#DDL-PARTITIONING-DECLARATIVE)
  
<details>
<summary>Задача 4</summary>

> Используя утилиту `pg_dump`, создайте бекап БД `test_database`.
>
> Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
  
</details>
 
#### Ответ:
  
