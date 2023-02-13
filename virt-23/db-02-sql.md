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
 
 
