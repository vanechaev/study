## Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера" - Нечаев Владимир

<details>
<summary>Задача 1</summary>

> Сценарий выполения задачи:
> 
> - создайте свой репозиторий на https://hub.docker.com;
> - выберете любой образ, который содержит веб-сервер Nginx;
> - создайте свой fork образа;
> - реализуйте функциональность:
> запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
> ```
> <html>
> <head>
> Hey, Netology
> </head>
> <body>
> <h1>I’m DevOps Engineer!</h1>
> </body>
> </html>
> ```
> Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

</details>

#### Ответ:

https://hub.docker.com/r/vanechaev/netology

<details>
<summary>Задача 2</summary>
  
> Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"
>
> Детально опишите и обоснуйте свой выбор.
>
> Сценарий:
>
> - Высоконагруженное монолитное java веб-приложение;
> - Nodejs веб-приложение;
> - Мобильное приложение c версиями для Android и iOS;
> - Шина данных на базе Apache Kafka;
> - Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
> - Мониторинг-стек на базе Prometheus и Grafana;
> - MongoDB, как основное хранилище данных для java-приложения;
> - Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
>
</details>

#### Ответ:

> - Высоконагруженное монолитное java веб-приложение

Т.к. структура монолитная, предположу, что здесь больше всего подойдет физическая машина. (из-за потребляемых ресурсов)

> - Nodejs веб-приложение

Здесь Docker будет актуален, по моему мнению. Т.к. платформа не особо требовательна к ресурсам, а с помощью докера легко развертывать.

> - Мобильное приложение c версиями для Android и iOS

Здесь, я думаю, подойдет виртуальная машина. Т.к. разные архитектуры.

> - Шина данных на базе Apache Kafka

Вполне подойдет докер. Возможность быстро сделать "откат", быстрая разворачиемость, маштабирование.

> - Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana

Так же подойдет докер. Экономия ресурсов, маштабируемость, высокая скорость работы.

> - Мониторинг-стек на базе Prometheus и Grafana

Также докер будет актуален. Кросплатформенность, маштабируемость, быстрота разворачивания.

> - MongoDB, как основное хранилище данных для java-приложения

Вполне подходит докер. Отслеживание контейнеров, повышенная отказоустойчивость, но важно использовать надежное решение для мониторинга и резервного копирования, такое как MongoDB Cloud Manager.

> - Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry

Здесь особого приемущества докера я не вижу. На мой взгляд возможно использование и докера и ВМ и физического сервера, в зависимости от поставленых задач.

<details>
<summary>Задача 3</summary>
  
> - Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
> - Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
> - Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
> - Добавьте еще один файл в папку ```/data``` на хостовой машине;
> - Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
  
</details>

#### Ответ:

```
root@Lenovo-G50-80:/data# docker run -it -d --name centos -v $(pwd)/data:/data centos
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
76762edcdb5c095555fd4156833744c7e894479f830047ad1683ded5cab20a67

root@Lenovo-G50-80:/data# docker run -it -d --name debian -v $(pwd)/data:/data debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
bbeef03cda1f: Pull complete 
Digest: sha256:534da5794e770279c889daa891f46f5a530b0c5de8bfbc5e40394a0164d9fa87
Status: Downloaded newer image for debian:latest
cde29531a9ddce92b85e7be5f150c660266364c3457e18eea109c36c49213a0c

root@Lenovo-G50-80:/data# docker exec -it centos bash
[root@76762edcdb5c /]# echo "from centos" > /data/centos.txt
[root@76762edcdb5c /]# exit 
exit

root@Lenovo-G50-80:/data# echo "from host" > data/host.txt

root@Lenovo-G50-80:/data/data# docker exec -it debian bash
root@cde29531a9dd:/# ls -l /data/
total 8
-rw-r--r-- 1 root root 12 Jan 18 11:28 centos.txt
-rw-r--r-- 1 root root 10 Jan 18 11:32 host.txt

```

<details>
<summary>Задача 4 (*)</summary>

> Воспроизвести практическую часть лекции самостоятельно.
>
> Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

</details>

#### Ответ:

https://hub.docker.com/repository/docker/vanechaev/alpin-ansible/general
