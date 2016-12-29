Linux

[Common administrative commands in Red Hat Enterprise Linux 5, 6, and 7](https://access.redhat.com/articles/1189123)

[Common administrative commands PDF](https://access.redhat.com/sites/default/files/attachments/rhel_5_6_7_cheatsheet_8.5x11_1114_jcs_0.pdf)

Display System Version Infomration
```
[root@37151]# cat /etc/system-release
CentOS Linux release 7.2.1511 (Core)
```

```
-------------------------------------------------------
touch            //Create the file
touch -a f1      //Change access time
touch -m f1      //Change modified time
touch file{1..5} //Create file1 file2 file3
file f1          //Empty file
file /bin/ls     //Binary file details
file sales.pdf   //File details
stat f1          //File status
-------------------------------------------------------
find -type f   //Find by type f file, d directory, l link
find -mmin 5   //Modified in last 5 minutes
find -mtime 0  //Modified today
find -newer baselinefile
find -empty
find -size +10M
-------------------------------------------------------
commandwithstderror 2>/dev/null  /Pipe errors to supress or redirect
-------------------------------------------------------
tar -c
tar -tf
tar -xvf
tar -czvf
gunzip etc.tar.gz //Will return etc.tar 

cpio

tar -z

Linux Notes

hostnamectl
/etc/hostname
hostnamectl set-hostname "abc@xyz.com"
/etc/machine-info  - pretty name
/etc/hosts  - IP FQDN ALIAS 
/etc/nsswitch
date
timedatectl set-time "2016-04-06 13:30:34"
timedatectl set-ntp false
hwclock --systohc --hctosys
yum install -y chrony
vim /etc/chrony.conf
systemctl enable chronyd
systemctl start chronyd
systemctl stop chronyd
systemctl disable chronyd
chronyc tracking
chronyc sources
ntpd
vim /etc/ntp.conf
ntpq -p
systemctl status NetworkManager
nmcli -p connection show test22
nmcli connection add con-name home ifname test22 type ethernet ip4 192.168.1.90 gw4 192.168.1.254
nmcli connection show
ip -4 address show test22
ip -6 address show
ip address add 192.168.0.199/24 dev test22
nmcli connection down test22
nmcli connection down home
cp test1 test2
vim !$    -opens test2
ip route show
ip route add desfault via 192.168.1.254

lspci
lsusb
lsblk

Virtual File System
/proc
/sys
/dev

ctrl + L = clear screen
man procfs

Kernel message bus
dmesg
cat /dev/kmsg
dmesg -C //Clears ring buffer

lsmod //List currently loaded drivers from /proc/modules
modprobe -r sr_mod  //Unload a loaded driver
modprobe -rv sr_mod //Unload a loaded driver verbose
modinfo msdos //List module info
modprobe sr_mod xa_test=1 //Load module with paramaters
modprobe.conf ??
/etc/modprobe.d/*
eject /dev/cdrom
modprobe -v sr_mod //Load module
insmod /lib.../sr_mod.ko //Is run behind the scenes

cat /proc/cmdline //Kernel boot paramaters
uname -r //Kernel version

top -p 1

SysVinit
Upstart
systemd

SysVinit
/sbin/init as PID1
Reads /etc/inittab
Initially starts in S mode single user
Then targets runlevel from initdefault
LSB scripts in /etc/init.d linked to runlevels in /etc/rcX.d

systemd-analyze blame
cat /lib/systemd/system/ssh.service
-----------------------------------------------------------
[Unit]
Description=OpenBSD Secure Shell server
After=network.target auditd.service
ConditionPathExists=!/etc/ssh/sshd_not_to_be_run

[Service]
EnvironmentFile=-/etc/default/ssh
ExecStart=/usr/sbin/sshd -D $SSHD_OPTS
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
RestartPreventExitStatus=255
Type=notify

[Install]
WantedBy=multi-user.target
Alias=sshd.service
-----------------------------------------------------------
dmesg -H  //Human readable
/dev/kmsg
/var/log/dmesg or boot.msg
dmesg -C  //Clear messages
dmesg -w  //Wait - Tail read
-----------------------------------------------------------
/etc/inittab
cd /etc/rc5.d/  //Change to runlevel symlink folder
chkconfig atd off  //Remove symbolic link from current runlevel
chkconfig atd on   //Add symbolic link from current runlevel
service atd status

poweroff.target  //0
rescue.target    //1
multiuser.target //2,3,4
graphical.target //5
reboot.target    //6

systemctl get-default //systemd
systemctl set-default multi-user.target //systemd
//Created symlink from /etc/systemd/system/default.target to /usr/lib/systemd/system/multi-user.target
systemctl disable rsyslog.service
//Removed symlink /etc/systemd/system/multi-user.target.wants/rsyslog.service.
systemctl enable rsyslog.service
//Created symlink from /etc/systemd/system/multi-user.target.wants/rsyslog.service to /usr/lib/systemd/system/rsyslog.service.
------------------------------------------------------------
systemctl status rsyslog.service

rsyslog.service - System Logging Service
   Loaded: loaded (/usr/lib/systemd/system/rsyslog.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2016-07-01 00:37:25 EDT; 36min ago
 Main PID: 770 (rsyslogd)
   CGroup: /system.slice/rsyslog.service
           -- /usr/sbin/rsyslogd -n

Jul 01 00:37:25 localhost.localdomain systemd[1]: Starting System Logging Service...
Jul 01 00:37:25 localhost.localdomain systemd[1]: Started  System Logging Service.
-------------------------------------------------------------
SystemV Change run level
telinit 1 //target run level
who -r
run-level 3  2016-07-01 00:37  //Current run level
runlevel
N 3  //Current run level 3 previous level N
-------------------------------------------------------------
systemd Change to run level
systemctl isolate multi-user.target
-------------------------------------------------------------
shutdown -h now
shutdown -r now
shutdown -h +10
shutdown -r +10 "reboot in 10 minutes"
echo "My message" | wall
-------------------------------------------------------------
systemd directory
ls /lib/systemd/  //systemd scripts
ls /lib/systemd/system  //services
ls /etc/systemd/system/  //serivces symlinks
ls /etc/systemd  //Config files
-------------------------------------------------------------
---- Network ------------------------------------------------
-------------------------------------------------------------
//Task: Find full or half duplex speed
dmesg | grep -i duplex
//Use ethtool to display or change ethernet card settings
ethtool eth1
//You can also use mii-tool to find out your duplex mode
mii-tool
mii-tool -F 100baseTx-FD
mii-tool -F 10baseT-HD
-------------------------------------------------------------
Grub Legacy - Centos 6, Suse 11
MBR First 512 Bytes of disk or First Sector of Partition
Grub 2 - CentOS 7, SLES 12, Debian 8, Ubuntu
MBR or GPT
-------------------------------------------------------------
446 bytes for boot loader 
Partition table for 4 primary partitions @ 16 bytes each
Sentinal 2 bytes
0xAA55 = Bootable
-------------------------------------------------------------
dd if=/dev/sda of=/root/sda.mbr count=1 bs=512
dd if=/root/sda.mbr of=/dev/sda
-------------------------------------------------------------
Grub Legacy
sudo cat /boot/grub/menu.lst
grub-install /dev/sda  //Install MBR
grub-install /dev/sda1 //Install To First Partition
grub > setup (hd0)
-------------------------------------------------------------
Grub2 on Debian
ls /boot/grub/grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg
-------------------------------------------------------------
ldd /bin/ls  //List libraries command is dependant on
which ls  //Shows command full path
ldd $(which ls)
Location - /lib + /usr/lib
Read from path specified in /etc/ld.so.conf
ldconfig -n <path> only reads fron the paths specified
Variable LD_LIBRARY_PATH is read ahead of others if set except when -n is used

ldconfig -p  //Print library cache
ldconfig     //Recompile cache
echo /usr/local/lib/tup > /etc/ld.so.conf.d/tup.conf
-------------------------------------------------------------
Debian Package (dpkg) .deb
Ubuntu and Mint are Debian
dpkg -i <package.deb>  //Install
dpkg -r <package>      //Remove
dpkg -P <package>      //Purge
dpkg --get-selections  //Currently Installed
dpkg -l 'vim*'         //List all available packages start with vim
dpkg -S /usr/bin/lp    //Find what package a file belongs to
dpkg -L cups-client    //List files that belong to a package
dpkg-reconfigure cups-client
--------------------------------------------------------------
aptitude
apt-get update
apt-cache search zsh
apt-get autoremove
apt-get dist-upgrade
cat /etc/apt/sources.list
aptitude search 'zsh.*'
aptitude search '~nzsh.*'
aptitude install zsh
aptitude purge zsh
--------------------------------------------------------------
rpm -i <package.rpm>     //Install
rpm -U <package.rpm>     //Update
rpm -F <package.rpm>     //Freshen
rpm -e <package>         //Remove
rpm -qpR <package.rpm>   //Show dependencies
rpm -K <package.rpm>     //Check package signature
rpm -qpi <package.rpm>   //Display Information
rpm -qpl <package.rpm>   //List Contents
rpm -qf /etc/hosts.allow //List owning package
--------------------------------------------------------------
/etc/yum.conf
/etc/yum/repos.d/
--------------------------------------------------------------
yum repolist
yum install nmap
yum remove nmap
yum update nmap
yum search nmap
yum info nmap
yum list
yum list installed
yum provides /etc/hosts.allow
man yum
--------------------------------------------------------------
yumdownloader
rpm2cpio zsh.rpm > z.cpio
cpio -id < z.cpio
cd etc
--------------------------------------------------------------
sh-4.2# uname -a
Linux 2d6745b83a1a 4.4.14-moby #1 SMP Wed Jun 29 10:00:58 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
type ls  //What or where is the command
--------------------------------------------------------------
FRUIT=apple
echo $FRUIT
export FRUIT=apple
unset FRUIT
--------------------------------------------------------------
Display Shell Settings
env    //displays exported variables
set    //displays variables and functions
set -o //Display shell options
set -o allexport //Turn on an option
set +o allexport //Turn off an option
alias  //Displays Aliases
---------------------------------------------------------------
!b //last command
!$ //last argument
---------------------------------------------------------------
cat /etc/services
head /etc/services
head -n 3 /etc/services
tail -n 3 /etc/services
tail -f /var/log/messages

cat -vet /etc/hosts    //Display file
tac /etc/hosts         //Display file lines backwards
head /etc/services     //Show the first 10 lines of file
tail -n1 /etc/services //Show the last n lines of the file
less /etc/services
-- / start searching forwards
-- ? start searching backwards
---------------------------------------------------------------
tabs 4
echo -e "File\twith\ttabs" > ft
cat ft; cat -vet ft
expand ft > fs
cat -vet fs
unexpand -a fs > ft

od ft    /Display file as octal dump
od -b ft //Displays as octal bytes 011 = Tab
od -a ft //Displays as text ht = TAB
od -x ft //Displays as hex 09 = TAB
---------------------------------------------------------------
fmt
head /etc/services | fmt
pr /etc/services  //66 lines 56 of data
echo -e "a\na\nb\nb\nb\nc\nd" | uniq
join f1 f2
paste f1 f2
sort -t':' -n -k3 /etc/password
wc /etc/services  //Lines, words, characters
     1184      4813     36141 /etc/services
wc -l /etc/services //Just lines (-l -w -c)
find /etc/-maxdepth 1 -type f -exec wc -l {}\; | sort -n
wc
split
tr[a-z[A-Z]] < /etc/hosts //Translate
sed 's/bash/sh/' /etc/passwd  //Replace bash with sh
sed 's/bash$/sh/' /etc/passwd  //Replace with sh if bash is at end of lines
sed '/^#/d' /etc/ntp.conf //Delete commented lines
tr -s [:space:] < hostsnew > hosts  //Single spaces only
cut -f1 -d$'\t' /etc/services
-----------------------------------------------------------------
cp
mv
rm
cp -u /etc/services .  //Only if newer
cp -a /etc/services .  //Maintain owner permission
mv services services.old
mv services services.$(date +%F)
mv -i services services.old  //Interactive
mv -n services services.old  //Prevent overwrite
mv services ~/Documents
-----------------------------------------------------------------
ls /dev/sda*
ls /dev/sda?
ls /dev/sd[ab]?
ls ~      //List file in home directory
ls -a ~   //List all file including hidden files
ls -A ~   //Almost all excludes . and ..
ls -lha ~ //Long list with size in human readable format
-----------------------------------------------------------------
mkdir -p sub/dir  //Create directory and parrent
mkdir -m 700 private
ls -ld private/
rmdir private
rmdir sub  //Sub not emprty
rm -rf sub  //Recursive sub dir delete
-----------------------------------------------------------------
touch f1
touch -a f1 //Update access time
touch -m f1 //Update modified time
file f1
file /bin/ls

root@e80b6e962795:/# file /bin/ls
/bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=eca98eeadafddff44caf37ae3d4b227132861218, stripped
-----------------------------------------------------------------
Redirection
>    Redirect to file overwrite
>>   Redirect to file append
1>   Redirect stdoutput to file overwrite
2>   Redirect stderror to file overwrite
2>&1 Redirect stderror to stdoutput
-----------------------------------------------------------------
strace ls -l
strace ls -l 2>&1 | grep passwd
while read H ; do ping -c3 $H ; done < servers.txt
greap tux /etc/passwd | cut -f1 -d':' | tr [:lower] [:upper]
-----------------------------------------------------------------
Command output as arguments
cd /lib.modules/`uname -r`
cd lib/modules/$(uname -r)
for F in $(ls ~) ; do stat $F ; done
ls *.sh | xargs
ls *.sh | xargs wc -l
find -name '*.sh' | xargs grep 'ksh$'
-----------------------------------------------------------------
More Research
tee
xargs
-----------------------------------------------------------------
$(date +%F) // Format date 2015-05-27
echo sdfsff | tee file1 //Send stdoutput to screen and file
-----------------------------------------------------------------
sleep
sleep 30&
sleep 30
ctrl z
bg
jobs
-----------------------------------------------------------------
screen sleep 100  #Create a screen for sleep
Ctrl+a d          #Detach from screen
screen -ls        #Lists screens
screen -r <screenid>
-----------------------------------------------------------------
chmod u+a $(which screen)
chmod 755 /var/run/screen
-----------------------------------------------------------------
nohup sleep 30000&  #Parrent process will be root process
-----------------------------------------------------------------
ps aux
ps -elf

root@2dd3b9c158fc:/# ps -elf
F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
4 S root         1     0  0  80   0 -  4577 -      18:16 ?        00:00:00 /bin/bash
4 T root       333     1  0  80   0 -  6036 -      19:58 ?        00:00:00 screen -la
5 S root       334   333  0  80   0 -  6104 -      19:58 ?        00:00:00 SCREEN -la
4 S root       335   334  0  80   0 -  1127 -      19:58 pts/1    00:00:00 /bin/sh
4 T root       340     1  0  80   0 -  6036 -      20:00 ?        00:00:00 screen ping -c 1000 4.2.2.1
5 Z root       341   340  0  80   0 -     0 -      20:00 ?        00:00:00 [screen] <defunct>
4 S root       380     1  0  80   0 - 11748 -      20:24 ?        00:00:00 su root
4 S root       381   380  0  80   0 -  4560 -      20:24 ?        00:00:00 bash
0 R root       386   381  0  80   0 -  8606 -      20:25 ?        00:00:00 ps -elf

PID  # Process Id
PPID # Parrent Process Id
PRI  # Priority
NI   # Neceness
-----------------------------------------------------------------
pgrep
pkill
killall -u bob
killall sleep
kill 2399
kill -15 | -term | -sigterm 2399  //softkill
kill -9 | -kill | -sigkill 2399   //hard kill
-----------------------------------------------------------------
uptime
free
top
nice #default 0 lower value gets more cpu
ps -l
renice
-----------------------------------------------------------------
grep
egrep
fgrep
-----------------------------------------------------------------
^root
grep 'art$' /usr/share/dict/words
grep 'sd[ab]' /proc/mounts
-----------------------------------------------------------------
^  start
$  end
\s whitespace   matches file system
\b word boundry matches file system and file-system
+  one or more
*  zero or more
?  zero or one
{3}  neber specified
sed -i.bak ''
------------------------------------------------------------------
vi
vim
vimtutor   #############
k up
j down
h left
l right
/text search forward
?text search backwards
n  
N
------------------------------------------------------------------
fdisk  #mbr only
parted #guid or mbr partition table
gdisk  # guim partition table

mbr most common stored in first 512 sectors of the disk
BIOS based system must have MBR
-------------------------------------------------------------------
fdisk /dev/sdb

root@85503fe60060:/# lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0   60G  0 disk
|-sda1   8:1    0  3.9G  0 part [SWAP]
`-sda2   8:2    0 56.1G  0 part /etc/hosts
sr0     11:0    1 1024M  0 rom
-------------------------------------------------------------------
mkfs -t vfat /dev/sdd1
mkfs.vfat /dev/sdd1
mkdosfs /dev/sdd1
fdisk -l /dev/sdc
mkfs -t ext4 /dev/sdc1
mkfs.ext4 /dev/sdc1
mkfs.xfs /dev/sdc2
mkfs.xfs -f /dev/sdc2
mkswap /dev/sdc3
-------------------------------------------------------------------
fsck
e2fsck
xfs_repair
btrfsck
fsck /dev/sda1 #Just name partition
fsck -A   #Check all file system with fsckpass > 0 in /etc/fstab
fsck -AR  #As before excluding root
fsck -ARM #As before excluding mounted file systems
fsck -f /dev/sda1  #Force a chack even if marked as clean
xfs_check
xfs_repair -n  #Check only No Action
xfs_repair
tune2fs -i 0 -c 0  #Automated file system check
df -T
df -h  #Show disk Space human readable
du -sh /home  #Show directory size summary only
df -i  #Display available Inodes
head /etc/mke2fs.conf  #Config File
tune2fs -l /dev/sdc1  #See Inode stats ++
-------------------------------------------------------------------
mount -o rw,noatime /dev/sdb1 /data
umount /data

fstab
/dev/sdb1 /data ext4 defaults 0 2
UUID=4DE408BF-B762-4537-B0D8-C133EA261440 /data ext4 defaults 0 2
/dev/cdrom /media/cdrom iso9660 ro,user,noauto 0 0
blkid /dev/sdb1

/etc/mtab  #Lists mounts
cat etc/fstab
/proc/mounts

mount -a
swapon -s
swapon -a
--------------------------------------------------------------------
From VI
:r!blkid /dev/sdb1

mkdir -p /data/{xfs,ext} /media/cdrom  #Create 3 directories and parrents
--------------------------------------------------------------------
apt-get install quota
yum install quota
For group or user is groug then group as a single counter
--------------------------------------------------------------------
mount /dev/sdXX /mnt
rsync -av /home/ /mnt
rm -rf /home/*
UUID=4DE408BF-B762-4537-B0D8-C133EA261440 /home ext4 userquota,auto 0 2
--------------------------------------------------------------------
/etc/nologin #Block new user logins
du -sh /home
umount /dev/sdc1
mount !$ /mnt
apt-get install quota rsync
rsync -arv /home/ /mnt
rm -rf /home/*unmount /mnt
vi /etc/fstab
mount -a   #??????
mount | grep home
--------------------------------------------------------------------
quotacheck -cmu /dev/sdXX
quotaon /dev/sdXX
Creates aquota.user in the root of partition
setquota -u bob 100000 150000 0 0 /dev/sdXX  #softblocks hardblocks
edquota
edquota -p bob -u tux
repquota -au /dev/sdXX
--------------------------------------------------------------------
Default permission folders 777
Default permission files   666
ls -l
chmod u+x hello
chmod 744 hello
chmod +x
chmod u=rwx,g=rx,o= hello.sh
umask  #Remove permissions
stat file1 #All properties of the inode entry or meta-data
stat -c %A hello #symbolic permissions
stat -c %a hello #octal permissions
stat -c %G hello #GID name
stat -c %g hello #GID number
chown
--------------------------------------------------------------------
id  #???
4 is r, 2 is w, 1 is x
u for User, g for Group, o for Others, s
Users primary group defined in /etc/passwd
To change your GID use /usr/bin/newgrp
--------------------------------------------------------------------
chown user1 hello.sh
chown user1:users hello.sh
chgrp sales hello.sh
--------------------------------------------------------------------
Special permissions modes - Review again????
Set user Id
Set group Id
Sticky bit

Sticky bit - When set on a folder you can only delete files you own such as /tmp
Indicated by t in the others execute block
Uppercase T would indicate that the execute permission is not set for others

ls -ld /tmp
chmod o+t /shared
chmod 1777 /shared
find /usr/bin -perm -u+s

The most common use of the sticky bit is on directories residing within filesystems 
for Unix-like operating systems. When a directory's sticky bit is set, the 
filesystem treats the files in such directories in a special way so only the 
file's owner, the directory's owner, or root can rename or delete the file. 
Without the sticky bit set, any user with write and execute permissions for the 
directory can rename or delete contained files, regardless of the file's owner. 
Typically, this is set on the /tmp directory to prevent ordinary users from deleting 
or moving other users' files. This feature was introduced in 4.3BSD in 1986, and 
today it is found in most modern Unix-like systems.
---------------------------------------------------------------------
'S' = The directory's setgid bit is set, but the execute bit isn't set.
's' = The directory's setgid bit is set, and the execute bit is set.
SetGID = When another user creates a file or directory under such a setgid 
directory, the new file or directory will have its group set as the group 
of the directory's owner, instead of the group of the user who creates it.
https://en.wikipedia.org/wiki/Chmod
---------------------------------------------------------------------
# Directories are hardlinked 2
ls -ld /usr/share  # Will show link count after permissions
ln file1 file2 #Create hard link
ls -li  #Directory listing with iNode reference id
# Hardlinks restricted to same volume because they just reference same iNode.
---------------------------------------------------------------------
A symbolic link is a file type of la
Is a seperate file in the file system 
Can cross file system boundaries
Becomes a broken link is target is deleted
find . -type l -xtype l
ls -s file2 file3  #Symbolic link
---------------------------------------------------------------------
Shareable - Static
Files accessable to user but not usually writable
Programs or documentation
eg: /usr /opt
/usr #Unix system resource
---------------------------------------------------------------------
find -name 'file*' -type f
find -name 'file*' -o type f
locate   #Indexed find
updatedb
/etc/updatedb.conf
mlocate
whatis locate
man 1 locate
whereis locate
which locate
type locate
---------------------------------------------------------------------
Shell Enviroment
Variable
Alias
Functions

Local Variables
VARIABLENAME=variablevalue
Enviroment Variables
export VARIABLENAME=variablevalue

env  #Display current enviroment
env TZ='America/Denver' date
env -i PATH=/usr/bin USER=bob env
----------------------------------------------------------------------
alias   #List alias
alias grep='grep --color=auto'
unalias
\grep   #Run unaliased command
----------------------------------------------------------------------
declare -F
function clean_file{
	sed -i.bak'/^\s*#/d;/^$/d' $1
}
declare -f clean_file  #Print function
unset clean_file
----------------------------------------------------------------------
grep --color=auto
----------------------------------------------------------------------
Login Shell
/etc/profile
   ~/.bash_profile
   ~/.bash_login
   ~/.profile
~/.bash_logout
~/.bashrc also call /etc/bash.bashrc

test -f /etc/bash.bashrc && . /etc/bash.bashrc
if [ -f /etc/bash.bashrc] ; then
    . /etc/bash.bashrc
fi
-----------------------------------------------------------------------
set -o noclobber
/etc/skel
-----------------------------------------------------------------------
Display x.org
X Server
xorg.conf, fonts, xwininfo, xdpyinfo
/etc/X11/xorg.conf + /etc/X11/xorg.conf.d
/usr/share/X11/xorg.conf.d
Starts automaticalls in runlevel 5 (graphical.target)
From runlevel 3 (multi-user.target) started with startx
Display Manager Provides the login screen
Window manager provides the desktop enviroment.

xhost +
xhost -
xwininfo
xdpyinfo
ls /usr/share/X11/xorg.conf.d/
cvt 1280 720 60 #Coordinated Video Timings
xrandr --newmode <Modeline value from cvt>
xrandr -q <retrieve monitor name>
xrandar --addmode <monitor name> 1280x720_60.00
------------------------------------------------------------------------
apt-get install lightdm
dpkg-reconfigure lightdm
vi /etc/X11/default-display-manager
/etc/lightdm/lightdm.conf
/etc/lightdm/lightdm-gtk-greeter.conf
Avatar ~/.face  #User Image
-------------------------------------------------------------------------
