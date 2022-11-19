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
#!/bin/bashdate
# Папка, куда будем складывать архивы — ее либо сразу создать либо несоздавать а положить в уже существующие
syst_dir=/backup/
# Имя сервера, который архивируем
srv_name=nodeOne #из тестовой конфигурации
# Адрес сервера, который архивируем
srv_ip=192.168.0.1
```
