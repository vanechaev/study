## Домашнее задание к занятию 5. «Elasticsearch» - Нечаев Владимир

<details>
<summary>Задача 1</summary>

> Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
> [документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):
>
> - составьте Dockerfile-манифест для Elasticsearch,
> - соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
> - запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.
>
> Требования к `elasticsearch.yml`:
>
> - данные `path` должны сохраняться в `/var/lib`,
> - имя ноды должно быть `netology_test`.
>
> В ответе приведите:
>
> - текст Dockerfile-манифеста,
> - ссылку на образ в репозитории dockerhub,
> - ответ `Elasticsearch` на запрос пути `/` в json-виде.
>
> Подсказки:
>
> - возможно, вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum,
> - при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml,
> - при некоторых проблемах вам поможет Docker-директива ulimit,
> - Elasticsearch в логах обычно описывает проблему и пути её решения.
>
> Далее мы будем работать с этим экземпляром Elasticsearch.

</details>

#### Ответ:
