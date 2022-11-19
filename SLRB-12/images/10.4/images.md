image
-
nano /etc/rsyncd.conf

```
pid file = /var/run/rsyncd.pid
log file = /var/log/rsyncd.log
transfer logging = true
munge symlinks = yes
# папка источник для бэкапа
[data]
path = /datauid = root
read only = yes
list = yes
comment = Data backup Dir
auth users = backup
secrets file = /etc/rsyncd.scrt
```
systemctl start rsync 

netstat -tulnp | grep rsync

nano /etc/rsyncd.scrt

```
backup:12345
chmod 0600 /etc/rsyncd.scrt
```
```
#!/bin/bash
date
# Папка, куда будем складывать архивы — ее либо сразу создать либо несоздавать а положить в уже существующие
syst_dir=/backup/
# Имя сервера, который архивируем
srv_name=rsync #из тестовой конфигурации
# Адрес сервера, который архивируем
srv_ip=10.129.0.41
# Пользователь rsync на сервере, который архивируем
srv_user=backup
# Ресурс на сервере для бэкапа
srv_dir=data
echo "Start backup ${srv_name}"
# Создаем папку для инкрементных бэкапов
mkdir -p ${syst_dir}${srv_name}/increment/
/usr/bin/rsync -avz --progress --delete
--password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir}
${syst_dir}${srv_name}/current/ --backup
--backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/
/usr/bin/find ${syst_dir}${srv_name}/increment/ -maxdepth 1 -type d
-mtime +30 -exec rm -rf {} \;
date
echo "Finish backup ${srv_name}"
```
