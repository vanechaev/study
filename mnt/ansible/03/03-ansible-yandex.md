# Домашнее задание к занятию 3 «Использование Ansible» - Нечаев Владимир

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

<details>
<summary>Основная часть</summary>


1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
</details>


## Ответ:

1-3. Дописал плейбук:

```yaml
...
- name: Install lighthouse
  hosts: lighthouse
  handlers:
    - name: Nginx reload
      become: true
      ansible.builtin.service:
        name: nginx
        state: restarted
  pre_tasks:
    - name: Install git
      become: true
      ansible.builtin.yum:
        name: git
        state: present
    - name: Install epel-release
      become: true
      ansible.builtin.yum:
        name: epel-release
        state: present
    - name: Install nginx
      become: true
      ansible.builtin.yum:
        name: nginx
        state: present
    - name: Apply nginx config
      become: true
      ansible.builtin.template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
        mode: 0644
  tasks:
    - name: Clone repository
      become: true
      ansible.builtin.git:
        repo: "{{ lighthouse_url }}"
        dest: "{{ lighthouse_dir }}"
        version: master
    - name: Apply config
      become: true
      ansible.builtin.template:
        src: lighthouse-nginx.conf.j2
        dest: /etc/nginx/conf.d/lighthouse.conf
        mode: 0644
      notify: Nginx reload
```
4. Подготовил свой inventory-файл `prod.yml`
```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: ans@158.160.68.102
vector:
  hosts:
    vector-01:
      ansible_host: ans@158.160.67.130
lighthouse:
  hosts:
    lighthouse-01:
      ansible_host: ans@158.160.26.231
```

5. Запустил `ansible-lint site.yml` и исправил ошибки:
```bash
ubuntu@ubuntu-2204:~/ansible/03/netology-ansible-03$ sudo ansible-lint site.yml 
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```

6. playbook на этом окружении с флагом `--check`
```bash
ubuntu@ubuntu-2204:~/ansible/03/netology-ansible-03$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] ***************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***********************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ***********************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ******************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"msg": "Timeout (12s) waiting for privilege escalation prompt: "}

PLAY RECAP ******************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   
```

7-8. Убедился, что playbook идемпотентен.

```bash
ubuntu@ubuntu-2204:~/ansible/03/netology-ansible-03$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ***************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***********************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "ans", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "ans", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ***********************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ******************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ******************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *******************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
ok: [vector-01]

TASK [Get vector dist] ******************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] **********************************************************************************************************
ok: [vector-01]

TASK [Copy server configuration file] ***************************************************************************************************
ok: [vector-01]

PLAY [Install lighthouse] ***************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
ok: [lighthouse-01]

TASK [Install git] **********************************************************************************************************************
ok: [lighthouse-01]

TASK [Install epel-release] *************************************************************************************************************
ok: [lighthouse-01]

TASK [Install nginx] ********************************************************************************************************************
ok: [lighthouse-01]

TASK [Apply nginx config] ***************************************************************************************************************
ok: [lighthouse-01]

TASK [Clone repository] *****************************************************************************************************************
ok: [lighthouse-01]

TASK [Apply config] *********************************************************************************************************************
ok: [lighthouse-01]

PLAY RECAP ******************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse-01              : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
## [Готовый playbook](https://github.com/vanechaev/08-ansible-03-yandex.git)
