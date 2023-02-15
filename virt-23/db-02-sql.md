## Домашнее задание к занятию "2. SQL" - Нечаев Владимир

<details>
<summary>Задача 1</summary>

> Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.
>  
> Приведите получившуюся команду или docker-compose манифест.
  
 </details>

#### Ответ:

```yml
# Use postgres/example user/password credentials
version: '3.1'

services:

  db:
    image: postgres:12
    restart: always
    ports:
      - "0.0.0.0:5432:5432"
    volumes:
      - data:/home/nva/Docker/postgresql/data
      - backup:/home/nva/Docker/postgresql/backup
    environment:
      POSTGRES_PASSWORD: 123

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

volumes:
  data: {}
  backup: {}
```
 <details>
  
```bash
sudo docker pull postgres
  
sudo docker-compose -f postgres.yml up -d

sudo docker ps
  
sudo docker exec -it afcd02ddb289 bash
  
psql -U postgres
```
  
</details>
  
<details>
<summary>Задача 2</summary>

> В БД из задачи 1: 
> - создайте пользователя test-admin-user и БД test_db
> - в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
> - предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
> - создайте пользователя test-simple-user  
> - предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
>
> Таблица orders:
> - id (serial primary key)
> - наименование (string)
> - цена (integer)
>
> Таблица clients:
> - id (serial primary key)
> - фамилия (string)
> - страна проживания (string, index)
> - заказ (foreign key orders)
>
> Приведите:
> - итоговый список БД после выполнения пунктов выше,
> - описание таблиц (describe)
> - SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
> - список пользователей с правами над таблицами test_db
  
 </details>

#### Ответ:

`List of databases`
```bash
Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |                Description
-----------+----------+----------+------------+------------+-----------------------+---------+------------+--------------------------------------------
postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 8097 kB | pg_default | default administrative connection database
template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | unmodifiable empty database
|          |          |            |            | postgres=CTc/postgres |         |            |
template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | default template for new databases
|          |          |            |            | postgres=CTc/postgres |         |            |
test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7825 kB | pg_default |
(4 rows)
```
<details>
  
```bash
\l+
```
   </details>
 
`clients`
```sql
Table "public.clients"
Column       |          Type          | Collation | Nullable |               Default
-------------------+------------------------+-----------+----------+-------------------------------------
id                | integer                |           | not null | nextval('clients_id_seq'::regclass)
фамилия           | character varying(200) |           |          |
страна проживания | character varying(200) |           |          |
заказ             | integer                |           |          |
Indexes:
"clients_pkey" PRIMARY KEY, btree (id)
"country_index_id" btree ("страна проживания")
Foreign-key constraints:
"clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```

<details>
  
```bash
\d clients
```
   </details>
 
`orders`
```bash
Table "public.orders"
Column    |          Type          | Collation | Nullable |              Default
--------------+------------------------+-----------+----------+------------------------------------
id           | integer                |           | not null | nextval('orders_id_seq'::regclass)
наименование | character varying(200) |           | not null |
цена         | integer                |           | not null |
Indexes:
"orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```

<details>
  
```bash
\d orders
```
   </details>
 
`SQL-запрос для выдачи списка пользователей с правами над таблицами test_db`
```sql
SELECT grantee, table_catalog, table_name, privilege_type FROM information_schema.table_privileges WHERE table_name IN ('orders','clients') AND grantee IN ('test_admin_user','test_simple_user');
```

`список пользователей с правами над таблицами test_db`
```bash
grantee      | table_catalog | table_name | privilege_type
------------------+---------------+------------+----------------
test_admin_user  | postgres      | orders     | INSERT
test_admin_user  | postgres      | orders     | SELECT
test_admin_user  | postgres      | orders     | UPDATE
test_admin_user  | postgres      | orders     | DELETE
test_admin_user  | postgres      | orders     | TRUNCATE
test_admin_user  | postgres      | orders     | REFERENCES
test_admin_user  | postgres      | orders     | TRIGGER
test_simple_user | postgres      | orders     | INSERT
test_simple_user | postgres      | orders     | SELECT
test_simple_user | postgres      | orders     | UPDATE
test_simple_user | postgres      | orders     | DELETE
test_admin_user  | postgres      | clients    | INSERT
test_admin_user  | postgres      | clients    | SELECT
test_admin_user  | postgres      | clients    | UPDATE
test_admin_user  | postgres      | clients    | DELETE
test_admin_user  | postgres      | clients    | TRUNCATE
test_admin_user  | postgres      | clients    | REFERENCES
test_admin_user  | postgres      | clients    | TRIGGER
test_simple_user | postgres      | clients    | INSERT
test_simple_user | postgres      | clients    | SELECT
test_simple_user | postgres      | clients    | UPDATE
test_simple_user | postgres      | clients    | DELETE
(22 rows)

```

<details>
<summary>Задача 3</summary>
  
> Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:
>
> Таблица orders
>
> |Наименование|цена|
> |------------|----|
> |Шоколад| 10 |
> |Принтер| 3000 |
> |Книга| 500 |
> |Монитор| 7000|
> |Гитара| 4000|
>
> Таблица clients
>
> |ФИО|Страна проживания|
> |------------|----|
> |Иванов Иван Иванович| USA |
> |Петров Петр Петрович| Canada |
> |Иоганн Себастьян Бах| Japan |
> |Ронни Джеймс Дио| Russia|
> |Ritchie Blackmore| Russia|
>
> Используя SQL синтаксис:
> - вычислите количество записей для каждой таблицы 
> - приведите в ответе:
>    - запросы 
>    - результаты их выполнения.
  

</details>
 
#### Ответ:
 
`Запросы`
```sql
INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
```
```sql
INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
```

`Результаты`
```bash
postgres=# SELECT COUNT (*) FROM orders;
count
-------
5
(1 row)
```
```bash
postgres=# SELECT COUNT (*) FROM clients;
count
-------
5
(1 row)
```


<details>
<summary>Задача 4</summary>
  
> Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
>
> Используя foreign keys свяжите записи из таблиц, согласно таблице:
>
> |ФИО|Заказ|
> |------------|----|
> |Иванов Иван Иванович| Книга |
> |Петров Петр Петрович| Монитор |
> |Иоганн Себастьян Бах| Гитара |
>
> Приведите SQL-запросы для выполнения данных операций.
>
> Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
> 
> Подсказк - используйте директиву `UPDATE`.
   

</details>
 
#### Ответ:
 
`SQL-запросы`
```sql
UPDATE clients SET заказ = (select id from orders where наименование = 'Книга') WHERE фамилия = 'Иванов Иван Иванович';
```
```sql
UPDATE clients SET заказ = (select id from orders where наименование = 'Монитор') WHERE фамилия = 'Петров Петр Петрович';
```
```sql
UPDATE clients SET заказ = (select id from orders where наименование = 'Гитара') WHERE фамилия = 'Иоганн Себастьян Бах';
```

`SQL-запрос для выдачи всех пользователей, которые совершили заказ`
```sql
SELECT* FROM clients WHERE заказ IS NOT NULL;
```
`вывод запроса`
```bash
id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
1 | Иванов Иван Иванович | USA               |     3
2 | Петров Петр Петрович | Canada            |     4
3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)
```

<details>
<summary>Задача 5</summary>
  
> Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).
>
> Приведите получившийся результат и объясните что значат полученные значения.
  
</details>
 
#### Ответ:
 
`Результат`
```bash
postgres=# EXPLAIN SELECT* FROM clients WHERE заказ IS NOT NULL;
QUERY PLAN
-----------------------------------------------------------
Seq Scan on clients  (cost=0.00..10.90 rows=90 width=844)
Filter: ("заказ" IS NOT NULL)
(2 rows)
```

- `Seq Scan on clients` - означает, что  используется Seq Scan — последовательное, блок за блоком, чтение данных таблицы clients
- `cost` - некое сферическое в вакууме понятие, призванное оценить затратность операции. 
- Первое значение 0.00 — затраты на получение первой строки. 
- Второе — 10.90 — затраты на получение всех строк.
- `rows` — приблизительное количество возвращаемых строк при выполнении операции Seq Scan. Это значение возвращает планировщик.
- `width` — средний размер одной строки в байтах.
- `Filter` - Это означает, что узел плана проверяет это условие для каждого просканированного им узла и выводит только те строки, которые удовлетворяют ему. 

<details>
<summary>Задача 6</summary>
  
> Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
> 
> Остановите контейнер с PostgreSQL (но не удаляйте volumes).
>
> Поднимите новый пустой контейнер с PostgreSQL.
>
> Восстановите БД test_db в новом контейнере.
>
> Приведите список операций, который вы применяли для бэкапа данных и восстановления. 
  
  
</details>
 
#### Ответ:

`Создайте бэкап БД test_db`
``` bash
nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker exec -t 3eff1e05c02e pg_dumpall -c -U postgres > ./backup/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
```

`Остановите контейнер с PostgreSQL`
```bash
nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker stop 3eff1e05c02e
```

`Поднимите новый пустой контейнер с PostgreSQL`
```bash
sudo docker run --name test_db_2 -e POSTGRES_PASSWORD=123 -d postgres:12
```

`Восстановите БД test_db в новом контейнере`
```bash
cat dump_13-02-2023_16_52_59.sql | docker exec -i 61546e4945a9 psql -U postgres
```
<details>
  
```bash
  nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker ps
[sudo] пароль для nva: 
CONTAINER ID   IMAGE         COMMAND                  CREATED       STATUS       PORTS                                       NAMES
3eff1e05c02e   postgres:12   "docker-entrypoint.s…"   4 hours ago   Up 4 hours   0.0.0.0:5432->5432/tcp                      test_db_1
fcc6dccc3fcb   adminer       "entrypoint.sh php -…"   4 hours ago   Up 4 hours   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   test_adminer_1
  nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker exec -t 3eff1e05c02e pg_dumpall -c -U postgres > ./backup/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
  nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker stop 3eff1e05c02e
[sudo] пароль для nva: 
3eff1e05c02e
nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED       STATUS       PORTS                                       NAMES
fcc6dccc3fcb   adminer   "entrypoint.sh php -…"   4 hours ago   Up 4 hours   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   test_adminer_1
nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker ps -a
CONTAINER ID   IMAGE                      COMMAND                  CREATED       STATUS                     PORTS                                       NAMES
3eff1e05c02e   postgres:12                "docker-entrypoint.s…"   4 hours ago   Exited (0) 9 seconds ago                                               test_db_1
fcc6dccc3fcb   adminer                    "entrypoint.sh php -…"   4 hours ago   Up 4 hours                 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   test_adminer_1
  nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker run --name test_db_2 -e POSTGRES_PASSWORD=123 -d postgres:12
61546e4945a96bf0a523e3a69667d7998aca2a03ee06c34ef7264836400ee4c4
nva@Lenovo-G50-80:~/Docker/postgres$ docker ps
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied
nva@Lenovo-G50-80:~/Docker/postgres$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
61546e4945a9   postgres:12   "docker-entrypoint.s…"   13 seconds ago   Up 12 seconds   5432/tcp                                    test_db_2
fcc6dccc3fcb   adminer       "entrypoint.sh php -…"   5 hours ago      Up 5 hours      0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   test_adminer_1
nva@Lenovo-G50-80:~/Docker/postgres$ sudo cat dump_13-02-2023_16_50_43.sql | docker exec -i 61546e4945a9 psql -U postgres
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/61546e4945a9/json": dial unix /var/run/docker.sock: connect: permission denied
nva@Lenovo-G50-80:~/Docker/postgres$ cd backup/
nva@Lenovo-G50-80:~/Docker/postgres/backup$ sudo -i
root@Lenovo-G50-80:~# cd /home/nva/Docker/postgres/backup/
root@Lenovo-G50-80:/home/nva/Docker/postgres/backup# cat dump_13-02-2023_16_52_59.sql | docker exec -i 61546e4945a9 psql -U postgres
SET
SET
SET
ERROR:  database "test_db" does not exist
ERROR:  current user cannot be dropped
ERROR:  role "test_admin_user" does not exist
ERROR:  role "test_simple_user" does not exist
ERROR:  role "postgres" already exists
ALTER ROLE
CREATE ROLE
ALTER ROLE
CREATE ROLE
  ...
  
</details>
