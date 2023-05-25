### Домашнее задание к занятию 2 «Работа с Playbook» - Нечаев Владимир

#### Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

<details>
<summary>Основная часть</summary>


1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

</details>

1. Подготовил свой inventory-файл `prod.yml`.
```yaml
---
  clickhouse:
    hosts:
      clickhouse:
        ansible_connection: docker
  vector:
    hosts:
      vector:
        ansible_connection: docker
 ```
 2. Дописал playbook

```yaml
---
- name: Install Clickhouse
  hosts: clickhouse
  handlers:
    - name: Start clickhouse service
      become: true
      become_method: su
      ansible.builtin.service:
        name: clickhouse-server
        state: restarted
  tasks:
    - block:
        - name: Get clickhouse distrib
          ansible.builtin.get_url:
            url: "https://packages.clickhouse.com/rpm/stable/{{ item }}-{{ clickhouse_version }}.noarch.rpm"
            dest: "./{{ item }}-{{ clickhouse_version }}.rpm"
          with_items: "{{ clickhouse_packages }}"
      rescue:
        - name: Get clickhouse distrib
          ansible.builtin.get_url:
            url: "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-{{ clickhouse_version }}.x86_64.rpm"
            dest: "./clickhouse-common-static-{{ clickhouse_version }}.rpm"
    - name: Install clickhouse packages
      become: true
      become_method: su
      ansible.builtin.yum:
        name:
          - clickhouse-common-static-{{ clickhouse_version }}.rpm
          - clickhouse-client-{{ clickhouse_version }}.rpm
          - clickhouse-server-{{ clickhouse_version }}.rpm
      notify: Start clickhouse service
    - name: Flush handlers
      become: true
      become_method: su
      meta: flush_handlers
    - name: Create database
      ansible.builtin.command: "clickhouse-client -q 'create database logs;'"
      become: true
      become_method: su
      register: create_db
      failed_when: create_db.rc != 0 and create_db.rc !=82
      changed_when: create_db.rc == 0
- name: Install Vector
  hosts: vector
  handlers:
    - name: Start vector service
      become: true
      become_method: su
      ansible.builtin.service:
        name: vector
        state: started
      tags:
        - vector
  tasks:
    - name: Get vector dist
      ansible.builtin.get_url:
        url: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-1.x86_64.rpm"
        dest: "./vector-{{ vector_version }}-1.x86_64.rpm"
      tags:
        - vector
    - name: Install vector packages
      become: true
      become_method: su
      ansible.builtin.yum:
        disable_gpg_check: true
        name: vector-latest-1.x86_64.rpm
      notify: Start vector service
      tags:
        - vector
```
2-6. Запустил playbook на этом окружении `ansible-lint site.yml`  и с флагом `--check`
```bash
ubuntu@ubuntu-2204:~/ansible/02$ sudo ansible-lint site.yml 
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```

```bash
sudo ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: vector
[WARNING]: Found both group and host with same name: clickhouse

PLAY [Install Clickhouse] *******************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************
ok: [clickhouse]

TASK [Get clickhouse distrib] ***************************************************************************************************************************************
changed: [clickhouse] => (item=clickhouse-client)
changed: [clickhouse] => (item=clickhouse-server)
failed: [clickhouse] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ***************************************************************************************************************************************
changed: [clickhouse]

TASK [Install clickhouse packages] **********************************************************************************************************************************
fatal: [clickhouse]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP **********************************************************************************************************************************************************
clickhouse                 : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   

```
7-10. playbook идемпотентен.
```bash
sudo ansible-playbook -i inventory/prod.yml site.yml 
[WARNING]: Found both group and host with same name: vector
[WARNING]: Found both group and host with same name: clickhouse

PLAY [Install Clickhouse] *******************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************
ok: [clickhouse]

TASK [Get clickhouse distrib] ***************************************************************************************************************************************
ok: [clickhouse] => (item=clickhouse-client)
ok: [clickhouse] => (item=clickhouse-server)
failed: [clickhouse] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ***************************************************************************************************************************************
ok: [clickhouse]

TASK [Install clickhouse packages] **********************************************************************************************************************************
ok: [clickhouse]

TASK [Create database] **********************************************************************************************************************************************
ok: [clickhouse]

PLAY [Install Vector] ***********************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************
ok: [vector]

TASK [Get vector dist] **********************************************************************************************************************************************
ok: [vector]

TASK [Install vector packages] **************************************************************************************************************************************
ok: [vector]

PLAY RECAP **********************************************************************************************************************************************************
clickhouse                 : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
[README.md-файл
](https://github.com/vanechaev/netology-ansible-02/blob/2cdea8ce1b4e1e44f698834cae9e8d81aa49d367/README.md)

[Репозиторий с тегом `08-ansible-02-playbook`](https://github.com/vanechaev/netology-ansible-02.git)
