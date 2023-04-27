## Домашнее задание к занятию 1 «Введение в Ansible» - Нечаев Владимир

<details>
<summary>Основная часть</summary>

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

</details>

#### Ответ:

1. 
```ansible
[nva@localhost playbook]$ ansible-playbook site.yml -i inventory/test.yml 

PLAY [Print os facts] *****************************************************************

TASK [Gathering Facts] ****************************************************************
[WARNING]: Platform linux on host localhost is using the discovered Python interpreter
at /usr/bin/python3.8, but future installation of another Python interpreter could
change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.13/reference_appendices/interpreter_discovery.html for more information.
ok: [localhost]

TASK [Print OS] ***********************************************************************
ok: [localhost] => {
    "msg": "REDOS"
}

TASK [Print fact] *********************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ****************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

2.
```bash
[nva@localhost playbook]$ cd group_vars/all/
[nva@localhost all]$ cat examp.yml 
---
  some_fact: "all default fact"
```

3.
```bash
[nva@localhost all]$ sudo docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
ubuntu        latest    08d22c0ceb15   6 weeks ago     77.8MB
hello-world   latest    feb5d9fea6a5   19 months ago   13.3kB
centos        latest    5d0da3dc9764   19 months ago   231MB
```
4. Выдает такую ошибку все ещё в поиске её решения...
```bash
[nva@localhost playbook]$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Print os facts] **********************************************************

TASK [Gathering Facts] *********************************************************
fatal: [centos7]: FAILED! => {"msg": "the connection plugin 'docker' was not found"}
fatal: [ubuntu]: FAILED! => {"msg": "the connection plugin 'docker' was not found"}

PLAY RECAP *********************************************************************
centos7                    : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
```
