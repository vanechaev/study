## Домашнее задание к занятию "4. Оркестрация группой Docker контейнеров на примере Docker Compose" - Нечаев Владимир.

<details>
<summary>Задача 1</summary>
  
> Создать собственный образ  любой операционной системы (например, ubuntu-20.04) с помощью Packer ([инструкция](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart))
> 
> Для получения зачета вам необходимо предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud.
  
  </details>

#### Ответ:

```
nva@Lenovo-G50-80:~/packer$ yc compute image list
+----------------------+---------------------------------+-----------------+----------------------+--------+
|          ID          |              NAME               |     FAMILY      |     PRODUCT IDS      | STATUS |
+----------------------+---------------------------------+-----------------+----------------------+--------+
| fd8c16cmggr6ju13v4mp | ubuntu-22042023-02-03t06-07-21z | ubuntu-2204-lts | f2eokm18lqng83m1koki | READY  |
+----------------------+---------------------------------+-----------------+----------------------+--------+
```

![Screenshot](https://github.com/vanechaev/study/blob/7e3bc94c3d477698a951ccc1681a5c80792b971b/virt-23/img/task1.png)

<details>
<summary>Задача 2</summary>
  
> Создать вашу первую виртуальную машину в YandexCloud с помощью terraform. 
> Используйте terraform код в директории ([src/terraform](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/terraform))
> 
> Для получения зачета, вам необходимо предоставить вывод команды terraform apply и страницы свойств созданной ВМ из личного кабинета YandexCloud.
 
  </details>

#### Ответ:

```
nva@Lenovo-G50-80:~/terraform/virt-04$ yc compute instance list
+----------------------+---------+---------------+---------+----------------+-------------+
|          ID          |  NAME   |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
+----------------------+---------+---------------+---------+----------------+-------------+
| fhmsdtg5g2vilas5i4iv | node-01 | ru-central1-a | RUNNING | 158.160.42.151 | 10.1.2.5    |
+----------------------+---------+---------------+---------+----------------+-------------+
```
![Screenshot](https://github.com/vanechaev/study/blob/37a191a71444443a220695abc8ba7e99474fb1cf/virt-23/img/task2.png)

<details>
<summary>Задача 2</summary>

> С помощью ansible+docker-compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana .
> Используйте ansible код в директории ([src/ansible](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/ansible))
>
> Для получения зачета вам необходимо предоставить вывод команды "docker ps" , все контейнеры, описанные в ([docker-compose](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/docker-compose.yaml)),  должны быть в статусе "Up".
 
  </details>

#### Ответ:

