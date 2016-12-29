# xrdp

## Install

### Unbuntu

[XRDP – How to install XRDP on Ubuntu 16.04 – Easy Way](http://c-nergy.be/blog/?p=8952)

```bash
sudo apt-get install xrdp
```

### Centos

```bash
yum list epel-release
yum install epel-release
yum install xrdp
```


On unbuntu 16.04 `sudo nano /etc/xrdp/startwm.sh`

```bash
#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

#xrdp multiple users configuration
mate-session

. /etc/X11/Xsession
```

`/etc/xrdp`

getenforce  // Selinux

cd /usr/sbin

ls -Z xrdp*

chcon -t bin_t /usr/sbin/xrdp /usr/sbin/xrdp-sesman

systemctl start xrdp

systemctl enable xrdp

netstat -ltn

cd /etc/xrdp

~/.xsession

chmod +x ~/.xsession

yum -y groups install "GNOME Desktop"

startx

http://unix.stackexchange.com/questions/181503/how-to-install-desktop-environments-on-centos-7

echo "exec gnome-session" >> ~/.xinitrc

startx

systemctl get-default

systemctl set-default graphical.target

http://www.itzgeek.com/how-tos/linux/centos-how-tos/install-xrdp-on-centos-7-rhel-7.html

https://it.megocollector.com/linux/rdp-into-centos-7-with-xrdp/

http://c-nergy.be/blog/?p=5984

ctrl + alt L  Toggle UI or text version of boot screen
