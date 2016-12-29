# KVM/QEMU

## **KVM** - Kernel-based Virtual Machine

Full virtualization solution for Linux on x86 hardware containing virtualization extensions (Intel VT or AMD-V).

It consists of a loadable kernel module, `kvm.ko`, that provides the core virtualization infrastructure and a processor specific module, `kvm-intel.ko` or `kvm-amd.ko`.

## **QEMU** - open source machine emulator and virtualizer

When used as a machine emulator, QEMU can run OSes and programs made for one machine (e.g. an ARM board) on a different machine (e.g. your own PC). By using dynamic translation, it achieves very good performance.

When used as a virtualizer, QEMU achieves near native performance by executing the guest code directly on the host CPU. QEMU supports virtualization when executing under the Xen hypervisor or using the KVM kernel module in Linux. When using KVM, QEMU can virtualize x86, server and embedded PowerPC, S390, 32-bit and 64-bit ARM, and MIPS guests.

[VIRTUALIZATION GETTING STARTED GUIDE](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Virtualization_Getting_Started_Guide/index.html)

---

## Install

[Install KVM on Ubuntu 16.04 LTS Headless Server](https://www.cyberciti.biz/faq/installing-kvm-on-ubuntu-16-04-lts-server/)

Check for hypervisor compatability

`lsmod | grep kvm`

| Package | Command |
| - | - |
| qemu-kvm | `yum install qemu-kvm` |
| libvirt | `yum install libvirt` |
| libvert-client | `yum install libvert-client` |
| virt-install | `yum install virt-install` |
| virt-manager | `yum install virt-manager` |
| virt-top | `yum install virt-top` |
| virt-viewer | `yum install virt-viewer` |

---

## **libvirt** - The virtualization API

A toolkit to interact with the virtualization capabilities of recent versions of Linux (and other OSes)

Configuration: `/etc/libvirt/qemu/`

| Keyword | Name |
| - | - |
| domain | Domain Management |
| monitor | Domain Monitoring |
| host | Host and Hypervisor |
| interface | Interface |
| filter | Network Filter |
| network | Networking |
| nodedev | Node Device |
| secret | Secret |
| snapshot | Snapshot |
| pool | Storage Pool |
| volume | Storage Volume |

### Start and enable **libvirtd** service

```text
systemctl start libvirtd
systemctl enable libvirtd
```

---

## **virsh** - virtualization interactive terminal

virsh is a command line interface tool for managing guests and the hypervisor.

The virsh tool is built on the libvirt management API and operates as an alternative to the xm tool and the graphical guest Manager

[Virtualization Guide - Managing guests with virsh](https://www.centos.org/docs/5/html/5.2/Virtualization/chap-Virtualization-Managing_guests_with_virsh.html)

|||
|-|-|
|list | list domains |
|iface-list | list physical host interfaces |
|nwfilter-list | list network filters |
|net-list | list networks |
|nodedev-list | enumerate devices on this host |
|secret-list | list secrets |
|snapshot-list | List snapshots for a domain |
|pool-list | list pools |
|vol-list | list vols |

---

### virsh network

|||
|-|-|
| net-autostart | autostart a network |
| net-create | create a network from an XML file |
| net-define | define an inactive persistent virtual network or modify an existing persistent one from an XML file |
| net-destroy | destroy (stop) a network |
| net-dhcp-leases | print lease info for a given network |
| net-dumpxml | network information in XML |
| net-edit | edit XML configuration for a network |
| net-event | Network Events |
| net-info | network information |
| net-list | list networks |
| net-name | convert a network UUID to network name |
| net-start | start a (previously defined) inactive network |
| net-undefine | undefine a persistent network |
| net-update | update parts of an existing network's configuration |
| net-uuid | convert a network name to network UUID |

#### List virtual networks

```bash
[root@37151]# virsh net-list [--inactive]
 Name                 State      Autostart     Persistent
----------------------------------------------------------
 default              active     yes           yes
```

#### Set virtual network auto start

```bash
virsh net-autostart [--disable] default
```

Creates or deletes a symbolic link to the config file in the auto start folder

```bash
ls -l /etc/libvirt/qemu/networks/autostart/
lrwxrwxrwx. 1 root root 14 Sep 10 02:07 default.xml -> ../default.xml
```

#### Define new virtual network

```bash
virsh net-define default.xml
```

- Using brctl to display bridge connections
- virbr0 default network installed by libvirt

```bash
virsh net-define default.xml
virsh net-autostart default
virsh net-edit default
/etc/libvirt/qemu/networks
```

### Share install disk via httpd

```bash
yum -y install httpd
systemctl start httpd
mount -o loop /tmp/CentOS-7-x86_64-Minimal-1511.iso /media
cp -a /media/. /var/www/html/inst/
chcon -R --reference=/var/www/html /var/www/html/inst
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
```

- cd /etc/libvirt/qemu/networks/default.xml
- cd /etc/libvirt/qemu/networks/
- **virbr0** - (Virtual Bridge 0) Interface is used for NAT (Network Address Translation).
- **virbr0-nic** - (Virtual bridge NIC) Bridge between physical Network Card and Virtual Machine
- To manage bridged interface you can use the `brctl` command.

```text
3: virbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 52:54:00:80:db:5a brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
4: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast master virbr0 state DOWN qlen 500
    link/ether 52:54:00:80:db:5a brd ff:ff:ff:ff:ff:ff
11: vnet0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master virbr0 state UNKNOWN qlen 500
    link/ether fe:54:00:68:31:59 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::fc54:ff:fe68:3159/64 scope link
       valid_lft forever preferred_lft forever
```

/etc/libvirt/qemu/networks/default.xml

```xml
<network>
  <name>default</name>
  <uuid>3a942357-0778-418b-87ad-e905fd57feb1</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:80:db:5a'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```

### **brctl** - ethernet bridge administration

[man pages](http://linuxcommand.org/man_pages/brctl8.html)

```text
Usage: brctl [commands]
commands:
    addbr       <bridge>        add bridge
    delbr       <bridge>        delete bridge
    addif       <bridge> <device>   add interface to bridge
    delif       <bridge> <device>   delete interface from bridge
    hairpin     <bridge> <port> {on|off}    turn hairpin on/off
    setageing   <bridge> <time>     set ageing time
    setbridgeprio  <bridge> <prio>     set bridge priority
    setfd       <bridge> <time>     set bridge forward delay
    sethello    <bridge> <time>     set hello time
    setmaxage   <bridge> <time>     set max message age
    setpathcost <bridge> <port> <cost>  set path cost
    setportprio <bridge> <port> <prio>  set port priority
    show        [ <bridge> ]        show a list of bridges
    showmacs    <bridge>        show a list of mac addrs
    showstp     <bridge>        show bridge stp info
    stp         <bridge> {on|off}  turn stp on/off
```

```bash
brctl addbr br0
brctl show br0
brctl show
brctl stp br0 on
brctl delbr br0
```

Connect to remote system

```bash
virsh -c qemu:///system
virsh -c qemu+ssh://root@192.168.1.100/system
```

- /var/lib/libvirt/images - ISO and vm location

#### PXE Boot

- vsftp services course
- /var/ftp/pubcentos72  - Install Files
- /var/ftp/pubcentos72/text.ks - Kickstart Answer File

#### PXE Tftp Xml

```xml
<network>
  <name>default</name>
  <uuid>3a942357-0778-418b-87ad-e905fd57feb1</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:80:db:5a'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <tftp root='/tftpboot' />
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
      <bootp file='pxelinux.0' />
    </dhcp>
  </ip>
</network>
```

[Installing Virtual Machines with virt-install, plus copy pastable distro install one-liners](https://raymii.org/s/articles/virt-install_introduction_and_copy_paste_distro_install_commands.html)

```bash
sudo virt-install --hvm --networkbridge:virbr0 \
    --pxe --graphics spice --name=c7-auto --ram=728
    --vcpus=1 --os-type=linux --os-variant=rhel7
    --disk path=/var/lib/libvirt/images/c7-auto.qcow2,size=9

sudo virt-install --hvm --connect qemu:///system \
    --network=bridge:virbr0 --pxe --graphics spice \
    --name=centos7-vm --ram=728 --vcpus=1 \
    --os-type=linux --os-variant=rhel7 \
    --disk path=/var/lib/libvirt/images/centos7-vm.qcow2,size=9

virt-install -n vmname -r 2048 --os-type=linux \
    --os-variant=ubuntu \
    --disk /kvm/images/disk/vmname_boot.img,device=disk,bus=virtio,size=40,sparse=true,format=raw \
    -w bridge=br0,model=virtio \
    --vnc --noautoconsole \
    -c /kvm/images/iso/ubuntu.iso

virt-install \
--name centos7 \
--ram 1024 \
--disk path=./centos7.qcow2,size=8 \
--vcpus 1 \
--os-type linux \
--os-variant centos7 \
--network bridge=virbr0 \
--graphics none \
--console pty,target_type=serial \
--location 'http://mirror.i3d.net/pub/centos/7/os/x86_64/' \
--extra-args 'console=ttyS0,115200n8 serial'

virt-install \
--name freebsd10 \
--ram 1024 \
--disk path=./freebsd10.qcow2,size=8 \
--vcpus 1 \
--os-type generic \
--os-variant generic \
--network bridge=virbr0 \
--graphics vnc,port=5999 \
--console pty,target_type=serial \
--cdrom ./CentOS-7-x86_64-Minimal-1511.iso

```

```bash
virsh net-edit
virsh net-update default add ip-dhcp-host \
    "<host mac='52:54:00:00:00:01' name='bob' ip='192.168.56.11'/>" \
    --live --config

virsh net-update default add ip-dhcp-host \
    "<host mac='52:54:00:00:00:02' name='jim' ip='192.168.56.12'/>" \
    --live --config

cat /tftpboot/pxelinux.cfg/01-52-54-00-00-00-01
cat /tftpboot/pxelinux.cfg/01-52-54-00-00-00-02
```

[http://www.syslinux.org/wiki/index.php?title=PXELINUX](http://www.syslinux.org/wiki/index.php?title=PXELINUX)
[https://wiki.centos.org/HowTos/PXE/PXE_Setup/Menus](https://wiki.centos.org/HowTos/PXE/PXE_Setup/Menus)
[https://coreos.com/os/docs/latest/booting-with-pxe.html](https://coreos.com/os/docs/latest/booting-with-pxe.html)