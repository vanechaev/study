## Домашнее задание к занятию "5. Оркестрация кластером Docker контейнеров на примере Docker Swarm" - Нечаев Владимир

<details>
<summary>Задача 1</summary>
  
> Дайте письменые ответы на следующие вопросы:
>
> - В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?
> - Какой алгоритм выбора лидера используется в Docker Swarm кластере?
> - Что такое Overlay Network?
  
</details>

#### Ответ:

- Для реплицируемой службы указывается количество идентичных задач, которые хотят запустить.

Глобальная служба — запускает одну задачу на каждой ноде.
Заранее заданного количества задач нет. 
Каждый раз, когда добавляется узел в кластер, оркестратор создает задачу, а планировщик назначает задачу новой ноде.

- Лидер нода выбирается из управляючих нод путем Raft согласованного алгоритма. Сам Raft-алгоритм имеет ограничение на количество управляющих нод. Распределенные решения должны быть одобрены большинством управляющих узлов, называемых кворумом. Это означает, что рекомендуется нечетное количество управляющих узлов.

- Overlay-сеть создает подсеть, которую могут использовать контейнеры в разных хостах swarm-кластера. Контейнеры на разных физических хостах могут обмениваться данными по overlay-сети (если все они прикреплены к одной сети).
Overlay-сеть использует технологию vxlan, которая инкапсулирует layer 2 фреймы в layer 4 пакеты (UDP/IP). При помощи этого действия Docker создает виртуальные сети поверх существующих связей между хостами, которые могут оказаться внутри одной подсети. Любые точки, которые являются частью этой виртуальной сети, выглядят друг для друга так, будто они связаны поверх свича и не заботятся об устройстве основной физической сети. [(С)](https://habr.com/ru/post/334004/)

<details>
<summary>Задача 2</summary>

> Создать ваш первый Docker Swarm кластер в Яндекс.Облаке
>
> Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker node ls
```

</details>

#### Ответ:

```bash
[centos@node01 ~]$ sudo -i
[root@node01 ~]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
dd7qhv2c42xff37y95f7dcpeb *   node01.netology.yc   Ready     Active         Leader           23.0.0
83inq9rzes8snoyd4nb6hw5ry     node02.netology.yc   Ready     Active         Reachable        23.0.0
oenu4btqied6nuougosoyejiv     node03.netology.yc   Ready     Active         Reachable        23.0.0
z84n0tp9vt9cwww1iv6nomunj     node04.netology.yc   Ready     Active                          23.0.0
ilkv7i1x0j6qopuissqxo66nx     node05.netology.yc   Ready     Active                          23.0.0
w4lozae6pxzs1g6fql7mu2qfg     node06.netology.yc   Ready     Active                          23.0.0
[root@node01 ~]#
```

<details>
<summary>Задача 3</summary>

> Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.
>
> Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```

</details>

#### Ответ:

```bash
[root@node01 ~]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
s059myh9dsuv   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0    
lm04p30pupfv   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
ppd9vpg84p8r   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest                         
oeaikhl1vrd4   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest                      
6x0lwrnu1b6e   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4           
i9v6zxzjxzta   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0   
8y9mhgfou4h0   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0       
g2lxr072w4hm   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0                        
```

<details>
<summary>Задача 4 (*)</summary>
  
Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание её функционала, что она делает и зачем она нужна:
```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```

</details>

#### Ответ:


