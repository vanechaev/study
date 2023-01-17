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
<summary> Задача 4 (*)</summary>
  
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
