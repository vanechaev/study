
# Домашнее задание к занятию «Микросервисы: принципы» - Нечаев Владимир

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

<details>
<summary>Задача 1: API Gateway</summary>
  
Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

</details>

Ответ:

||Маршрутизация|Аутентификация|Терминация HTTPS|
|----------|----------|----------|----------|
|Nginx|+|+|+|
|Apache APISIX API Gateway|+|+|+|
|Kong Gateway|+|+| +|
|Tyk io|+|+|+|
|Yandex API Gateway|+|+|+|

Для выбора конкретного решения нужно выяснить дополнительные факторы (опыт работы с конкретными решениями, возможность интеграции с другими компонентами, место разворачивания, возможно уже использование API, и т.п.).По параметрам подходят все варианты. Для облачного проекта целесообразно использовать облачные API, например Yandex API Gateway. Если требуется развернуть API Gateway на своём оборудовании, то различных вариантов также хватает. Приведен далеко не полный список решений.
Я бы остановился на NGINX (популярное open source решение).

<details>
<summary>Задача 2: Брокер сообщений</summary>

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

</details>

Ответ:

||Поддержка|Хранение|Скорость|Поддержка|Разделение прав доступа|Простота|
| --------- | --------- | ----------- | -------- | --------- | ----------- | --------- |
|RabbitMQ|+|+|+|+|+|+|
|Apache Kafka|+|+|+|+|+|+/-|
|ActiveMQ|+|+|+|+|+|+|
|Redis|+|+|+|+|+|+|

Как и в первой задачи не достаточно вводных данных, но я бы делал выбор между Kafka и RabbitMQ.
- Kafka подходит для приложений, которым необходимо повторно анализировать полученные данные.
- Kafka передает сообщения с очень низкой задержкой и подходит для анализа потоковых данных в реальном времени.
- RabbitMQ обеспечивает гибкость для клиентов с приблизительными требованиями или сложными сценариями маршрутизации.
- RabbitMQ применяет модель push, этот вариант подходит для приложений, которые должны соблюдать определенные последовательности и предоставлять гарантии доставки при обмене данными и их анализе.
- Разработчики используют RabbitMQ для приложений клиентов, требующих обратной совместимости с устаревшими протоколами, такими как MQTT и STOMP. RabbitMQ также поддерживает более широкий спектр языков программирования по сравнению с Kafka.

Я предложил бы начать тестировать с RabbitMQ.