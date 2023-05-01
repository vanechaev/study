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
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-playbook site.yml -i inventory/test.yml 

PLAY [Print os facts] **********************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************
ok: [localhost]

TASK [Print OS] ****************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *********************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0     
```

2.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ cd group_vars/all/
ubuntu@ubuntu-2204:~/ansible/01/playbook/group_vars/all$ cat examp.yml 
---
  some_fact: 12
ubuntu@ubuntu-2204:~/ansible/01/playbook/group_vars/all$ nano examp.yml 
ubuntu@ubuntu-2204:~/ansible/01/playbook/group_vars/all$ cat examp.yml 
---
  some_fact: "all default fact"

```

3.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook/group_vars/all$ docker ps
CONTAINER ID   IMAGE      COMMAND       CREATED          STATUS          PORTS     NAMES
fa16fdfd6d97   ubuntu     "/bin/bash"   47 minutes ago   Up 21 minutes             ubuntu
70457003b54c   centos:7   "/bin/bash"   48 minutes ago   Up 47 minutes             centos7
```
4. 
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Print os facts] **********************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "deb"
}
ok: [centos7] => {
    "msg": "el"
}

PLAY RECAP *********************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

5.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ cat ./group_vars/deb/examp.yml 
---
  some_fact: "deb default fact"
ubuntu@ubuntu-2204:~/ansible/01/playbook$ cat ./group_vars/el/examp.yml 
---
  some_fact: "el default fact"
```

6.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Print os facts] **********************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}

TASK [Print fact] **************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
7.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
```

8.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-playbook -i inventory/prod.yml site.yml 

PLAY [Print os facts] **********************************************************************************************************************************************************************
ERROR! Attempting to decrypt but no vault secrets found
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] **********************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

9.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-doc -t connection local
> ANSIBLE.BUILTIN.LOCAL    (/usr/lib/python3/dist-packages/ansible/plugins/connection/local.py)

        This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of on a remote host.

NOTES:
      * The remote user is ignored, the user with which the ansible CLI was executed is used instead.


AUTHOR: ansible (@core)

VERSION_ADDED_COLLECTION: ansible.builtin
```

10.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ cat inventory/prod.yml 
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```

11.
```bash
ubuntu@ubuntu-2204:~/ansible/01/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] **********************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}

TASK [Print fact] **************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}

PLAY RECAP *********************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

12. [репозиторий с изменённым playbook](https://github.com/vanechaev/study/tree/main/mnt/ansible/playbook)
