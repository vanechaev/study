# Домашнее задание к занятию "1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения." - Нечаев Владимир
---
### Задача 1
Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.
### Ответ:
Виртуализация на уровне операционной системы (контейнерная виртуализация) — метод виртуализации, при котором ядро операционной системы поддерживает несколько изолированных экземпляров пространства пользователя, вместо одного.

Паравиртуализация — техника виртуализации, при которой гостевые операционные системы подготавливаются для исполнения в виртуализированной среде, для чего их ядро незначительно модифицируется

Полная виртуализация — это технология, используемая для предоставления определенной виртуальной среды, которая обеспечивает полное симулирование базового оборудования.
### Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:

- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:

- Высоконагруженная база данных, чувствительная к отказу.
- Различные web-приложения.
- Windows системы для использования бухгалтерским отделом.
- Системы, выполняющие высокопроизводительные расчеты на GPU.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.
### Ответ:
- Высоконагруженная база данных, чувствительная к отказу - паравиртуализация (из-за чувствительности к отказу, для создания HA-кластера) Но если имеется ввиду, что возможно использовать несколько физических серверов, то я бы выбрал организацию физических серверов с созданием все того же HA-кластера (из-за требований к вычислителным ресурсам).
- Различные web-приложения - виртуализация уровня ОС (из-за быстроты разворачивания и экономии ресурсов).
- Windows системы для использования бухгалтерским отделом - паравиртуализация (не требовательные к ресурсам рабочие станции).
- Системы, выполняющие высокопроизводительные расчеты на GPU - физические сервера (из-за требований к вычислителным ресурсам).
### Задача 3.
Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1) 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2) Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3) Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
4) Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.
### Ответ:
1) Из-за Windows based инфраструктуры, я бы использовал Hyper-V. У него присутствуют: миграция накопителей данных, Live-миграция виртуальных машин, реплики Hyper-V.
2) Xen — это кросс-платформенный гипервизор с поддержкой паравиртуализации для процессоров архитектуры х86, распространяющийся с открытым исходным кодом. Достаточно зрелый и стабильный продукт.
3) XenPV - более совместим с Windows based инфраструктурой.
4) Либо KVM либо Xen HVM, но KVM - более совместим с Linux based инфраструктурой.

### Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.
### Ответ:
Недостатки:
- Администрирование (сложно админить несколько систем, распределять ресурсы)
- Затратность (как финансовая так и "человеческая", и временная)
- Содержание среды (высок риск сбоя среды, необходимо больше ресурсов)

Минимизация рисков:
- Разграничение ресурсов 
- Использовать подход IaaC
- минимизировать количество систем управления виртуализацией

Если бы у меня был выбор, то я не использовал гетерогенную среду. Т.к. при использовании разных сред ведут к большим затратам.
