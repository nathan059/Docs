# System Services

### systemctl ###

systemd

https://en.wikipedia.org/wiki/Systemd

init

https://en.wikipedia.org/wiki/Init


CD /etc/xinetd.d
cat ftp
service ftp
{
    disable = no
    .......
}

netstat -ltnp


## TCPD TCP Wrapper
libwrap.so
The files describes the names of the hosts which are allowed to use the local INET services as decided by the /usr/sbin/tcpd server.
/etc/hosts.allow
/etc/hosts.deny

- When conflicting deny, allow wins
- proftpd: ALL  # Config file example
- `tcpdchk -v`  Show loaded rules


When the SUID or GUID bit are set on an executable additional rights may be granted
- Find executables that run with the permission of the **file owner** not the logged in user 
- find /usr/bin -perm -u=s
- Find executables that run with the permission of the **group owner** not the logged in user 
- find /usr/bin -perm -g=s
- find /usr/bin -perm -u=s,g=s
```
$ ls -l /usr/bin/wall
-r-xr-**s**r-x. 1 root tty 15344 Jun  9  2014 /usr/bin/wall
```
```
chage -l bob
passwd -S bob
chage -W 10 bob
passwd -w 10 bob
less /etc/logins.defs
```

```
pam_limits.so
/etc/security/limits
/etc/pam.d/
```

```
netstat -tl
nmap localhost
lsof -i
fuser ssh/tcp
who
w
wlast
lastlog
fuser ssh/tcp
ps -fp 232
cd /etc/pam.d
/etc/security/limits
```


