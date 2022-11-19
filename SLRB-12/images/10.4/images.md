image
-
nano /etc/rsync.conf

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
systemstl start rsync 

netstat -tulnp | grep rsync

nano /etc/rsyncd.scrt

```
backup:12345
chmod 0600 /etc/rsyncd.scrt
```

