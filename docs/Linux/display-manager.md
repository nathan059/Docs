# Display Manager


## Unbuntu

```bash
dpkg-reconfigure gdm3
dpkg-reconfigure lightdm
```

Default display manager is set with symbolic link `/etc/systemd/system/display-manager.service`

```bash
~$ ls -l /etc/systemd/system/display-manager.service
lrwxrwxrwx 1 root root 35 Nov 27 18:02 /etc/systemd/system/display-manager.service -> /lib/systemd/system/lightdm.service
```

## Session configuration

Many display managers read available sessions from the `/usr/share/xsessions/` directory

Sample `.desktop` file

```text
[Desktop Entry]
Name=MATE
Exec=mate-session
TryExec=mate-session
Icon=
Type=Application
DesktopNames=MATE
Keywords=launch;MATE;desktop;session;
```