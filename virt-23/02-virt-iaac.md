# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами" - Нечаев Владимир

<details>
<summary>Задача 1</summary>

> Опишите своими словами основные преимущества применения на практике IaaC паттернов.
>
> Какой из принципов IaaC является основополагающим?

</details>

#### Ответ:

Основные приемущества IaaC:
- Ускорение производства и вывода продукта на рынок
- Стабильность среды, устранение дрейфа конфигураций
- Более быстрая и эффективная разработка

Основопологающий принцип - Идемпотентность.

<details>
<summary>Задача 2</summary>
  
> Чем Ansible выгодно отличается от других систем управление конфигурациями?
>
> Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
</details>

#### Ответ:

Преимущества Ansible:
- Скорость
- Расширяемость
- Простота

У каждого подхода есть свои плюсы и минусы. Некоторые задачи легче осуществить с одним и сложнее — с другим. Следует использовать то, что больше подходит к конкретному случаю или комбинировать.

<details>
<summary>Задача 3</summary>
  
> Установить на личный компьютер:
> 
> - VirtualBox
> - Vagrant
> - Ansible
>
> *Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

</details>

#### Ответ:
Virtualbox:
```
$ vboxmanage --version
7.0.4r154605
```
Vagrant:
```
$ vagrant --version
Vagrant 2.2.19
```
Ansible:
```
$ ansible --version
ansible [core 2.13.7]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/nva/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/nva/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov 14 2022, 16:10:14) [GCC 11.3.0]
  jinja version = 3.0.3
  libyaml = True
```

</details>
<summary>Задача 4 (*)</summary>
  
> Воспроизвести практическую часть лекции самостоятельно.
> 
> Создать виртуальную машину.
> Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
> 
> ```
> docker ps
> ```

</details>

#### Ответ:
```
vagrant@server1:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete 
Digest: sha256:aa0cc8055b82dc2509bed2e19b275c8f463506616377219d9642221ab53cf9fe
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

vagrant@server1:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ sudo docker version
Client: Docker Engine - Community
 Version:           20.10.22
 API version:       1.41
 Go version:        go1.18.9
 Git commit:        3a2c30b
 Built:             Thu Dec 15 22:28:08 2022
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.22
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.18.9
  Git commit:       42c8b31
  Built:            Thu Dec 15 22:25:58 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.15
  GitCommit:        5b842e528e99d4d4c1686467debf2bd4b88ecd86
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
vagrant@server1:~$ 
```

