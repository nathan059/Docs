# systemd

## *systemd* - Service Manager

[Managing Services With Systemd](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/chap-Managing_Services_with_systemd.html)

*systemctl* - may be used to introspect and control the state of the "systemd" system and service manager.

- Wily Werewolf (15.10) and newer - systemd
- Trusty (14.04) and older - upstart

MANAGING SYSTEM SERVICES

List services

```bash
systemctl list-units --type service
systemctl list-units --type service --all
systemctl list-unit-files --type service
```

Check service status

```bash
systemctl status name.service
systemctl is-active name.service
systemctl is-enabled name.service
systemctl list-dependencies --after gdm.service
systemctl list-dependencies --before gdm.service
```

Controlling Services

```bash
systemctl start name.service
systemctl stop name.service
systemctl restart name.service

# Restart only if service is already running
systemctl try-restart name.service

# Reload configuration
systemctl reload name.service

systemctl enable name.service
systemctl disable name.service

# Disables service unit then immediately enables it
systemctl reenable name.service

# Replaces /etc/systemd/system/name.service file with symbolic link to /dev/null
systemctl mask name.service
systemctl unmask name.service
```

WORKING WITH SYSTEMD TARGETS

```txt
systemctl get-default

# /etc/systemd/system/default.target is a symbolic link to the default run level
ls -l /etc/systemd/system/default.target
lrwxrwxrwx. 1 root root 37 Sep 10 01:37 /etc/systemd/system/default.target -> /lib/systemd/system/multi-user.target

systemctl set-default name.target

# Change the current target
systemctl isolate name.target

# Similar to systemctl isolate rescue.target - single user mode
systemctl rescue

# Readonly file system minimal services
systemctl emergency

# List all active targets
systemctl list-units --type target
```

---
| Runlevel | Target Units | Description
|-|-|-
|0|runlevel0.target, poweroff.target| Shut down and power off the system.
|1|runlevel1.target, rescue.target| Set up a rescue shell.
|2|runlevel2.target, multi-user.target| Set up a non-graphical multi-user system.
|3|runlevel3.target, multi-user.target| Set up a non-graphical multi-user system.
|4|runlevel4.target, multi-user.target| Set up a non-graphical multi-user system.
|5|runlevel5.target, graphical.target| Set up a graphical multi-user system.
|6|runlevel6.target, reboot.target| Shut down and reboot the system.


SHUTTING DOWN, SUSPENDING, AND HIBERNATING THE SYSTEM

---
|Old Command|New Command|Description|
|-|-|-
|halt|systemctl halt|Halts the system.|
|poweroff|systemctl poweroff|Powers off the system.
|reboot|systemctl reboot|Restarts the system.
|pm-suspend|systemctl suspend|Suspends the system.
|pm-hibernate|systemctl hibernate|Hibernates the system.
|pm-suspend-hybrid|systemctl hybrid-sleep|Hibernates and suspends the system.

CONTROLLING SYSTEMD ON A REMOTE MACHINE

```bash
# Interact with systemd on a remote machine over SSH
systemctl --host user_name@host_name status httpd.service
```

SHUTTING DOWN, SUSPENDING, AND HIBERNATING THE SYSTEM

```bash
systemctl poweroff
systemctl reboot
```

[CREATING AND MODIFYING SYSTEMD UNIT FILES](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/sect-Managing_Services_with_systemd-Unit_Files.html)

Systemd Unit Locations
|||
|-|-
|/usr/lib/systemd/system/|Systemd units distributed with installed RPM packages.
|/run/systemd/system/|Systemd units created at run time. This directory takes precedence over the directory with installed service units.
|/etc/systemd/system/|Systemd units created and managed by the system administrator. This directory takes precedence over the directory with runtime units.

