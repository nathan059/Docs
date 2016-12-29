# SELinux

Security-Enhanced Linux (SELinux) is a Linux kernel security module that provides a mechanism for supporting access control security policies, including United States Department of Defense–style mandatory access controls (MAC).

[http://selinuxproject.org/page/FAQ](http://selinuxproject.org/page/FAQ)

[http://selinuxproject.org/page/NewUsers](http://selinuxproject.org/page/NewUsers)

[Security-Enhanced_Linux-Introduction](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/SELinux_Users_and_Administrators_Guide/chap-Security-Enhanced_Linux-Introduction.html)

### Security Enhanced Linux
- dac discretionary access control
- mac mandatory access control

First **dac** is checked then **mac** is checked if enabled

#### Labels
- Labels are also refered to as Security Contexts
- SELinux stores file security labels in xattrs with the **security.selinux** attribute
- Most file system types support retrieving attribute information with getxattr(2)

### Components
- Modes
- Labels (Security Contexts)
- Policy Types
- Policty Rules and Packages

### Current Mode
```
getenforce
sestatus
```

#### Modes
- Disabled (Service Stoped?)
- Permissive - `setenforce 0`  **(runtime change not persisted)**
- Enforcing - `setenforce 1`

#### Config File
`/etc/selinux/config`

#### Objects
- Process
- Users
- Files
- Directories
- etc

[http://selinuxproject.org/page/ObjectClassesPerms](http://selinuxproject.org/page/ObjectClassesPerms)

### Install Tools
```
yum install policycoreutils-python
yum install policycoreutils-gui
yum install setools-console
yum install setools-guisetroubleshoot
yum install setroubleshoot-server
```

### Labels
#### Viewing Labels
Label information cam be viewed using the -Z option.

Attribute Layout: **( user : role : type : level )**
- Level is not commonly used

```
[root@7151 ~]$ id -Z
system_u:system_r:unconfined_service_t:s0

[root@7151 ~]$ ls /etc/passwd -Z
-rw-r--r--. root root system_u:object_r:passwd_file_t:s0 /etc/passwd

[root@7151 ~]$ ps -Z
LABEL                              PID TTY          TIME CMD
system_u:system_r:unconfined_service_t:s0 18730 pts/0 00:00:00 bash
system_u:system_r:unconfined_service_t:s0 19924 pts/0 00:00:00 ps
```

Policy Types

From: `/etc/selinux/config`
```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

#### Type Enforcement (TE)
Runtime security domain

#### Targeted Policy
Targets specific daemons
Network Facin
Start at boot

User processes often not targeted
unconfined_t - Default if not policy
- seinfo -aunconfined_domain_type -x

- seinfo -r
- semanage login -l
- sesearch --allow

---

### chcon - change security context
Allow Rules = Policy Rules

```
[root@unknown00155D037151 bob]# ps -xZ | grep httpd
system_u:system_r:httpd_t:s0     27206 ?        Ss     0:00 /usr/sbin/httpd -DFOREGROUND
```

```
[root@37151]# sesearch --allow | grep httpd_content
   allow httpd_t httpd_content_type : file { ioctl read getattr lock open } ;
   allow httpd_t httpd_content_type : dir { getattr search open } ;
   allow httpd_t httpd_content_type : file { ioctl read getattr lock open } ;
   allow httpd_t httpd_content_type : dir { ioctl read getattr lock search open } ;
   allow httpd_t httpd_content_type : lnk_file { read getattr } ;
   allow httpd_suexec_t httpd_content_type : dir { getattr search open } ;
```

```
[root@unknown00155D037151 bob]# ls -Z /var/www/
drwxr-xr-x. root root system_u:object_r:httpd_sys_script_exec_t:s0 cgi-bin
drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 html
```

Default file system attribute definitions
```
[root@unknown00155D037151 bob]# cat /etc/selinux/targeted/contexts/files/file_contexts | grep httpd_sys_content
/srv/([^/]*/)?www(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/var/www(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/etc/htdig(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/srv/gallery2(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/var/lib/trac(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/var/lib/htdig(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/var/www/icons(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/glpi(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/htdig(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/drupal.*	system_u:object_r:httpd_sys_content_t:s0
/usr/share/z-push(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/var/www/svn/conf(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/icecast(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/var/lib/cacti/rra(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/ntop/html(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/doc/ghc/html(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/openca/htdocs(/.*)?	system_u:object_r:httpd_sys_content_t:s0
/usr/share/selinux-policy[^/]*/html(/.*)?	system_u:object_r:httpd_sys_content_t:s0
```

#### semodule
semodule -l

Need to be explicitly loded
- *.pp policy package file

```
ls -l /etc/selinux/targeted/modules/active/modules/
semodule -d xen  # disable xen policy module
```

```
[root@unknown00155D037151 bob]# getsebool -a | grep samba_export
samba_export_all_ro --> off
samba_export_all_rw --> off

[root@unknown00155D037151 bob]# semanage boolean -l | grep samba_export
samba_export_all_ro            (off  ,  off)  Allow samba to share any file/directory read only.
samba_export_all_rw            (off  ,  off)  Allow samba to share any file/directory read/write.
```











Disable in grub

`enforcing=0`


# Troubleshoot xrdp
```
[root@037151]# ps -auxZ | grep 4117
system_u:unconfined_r:init_t:s0 root       4117  0.0  0.0 279696  3092 ?        Ss   00:30   0:00 /usr/sbin/xrdp-sesman --nodaemon
```

```
#Add rule to local file
semanage fcontext -a -t bin_t "/usr/sbin/xrdp(-sesman)?"
```