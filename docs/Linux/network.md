# Networking

## Network Status

```bash
systemctl status network

systemctl restart network

nmcli dev status

ip address show
```

## GUI Mode

```bash
nmtui
```

## **nmcli** - Network Manager commang-line tool

Network manager can store diffrent profiles also known as connections, for the same network interface.

```bash
nmcli general status
nmcli general hostname
nmcli general hostname servername.com
nmcli general permissions
nmcli general logging
nmcli connection up eth0
nmcli connection show
nmcli connection show eth0
nmcli connection add con-name "eth0-work" type ethernet ifname eth0
nmcli connection modify "eth0-work" ipv4.addresses "192.168.20.100/24 192.168.20.1"
nmcli connection modify "eth0-work" +ipv4.dns 192.168.20.1
nmcli connection modify "eth0-work" connection.autoconnect no
```

**nmtui**  - GUI Config Tool

---

### **ifconfig**

[15 Useful “ifconfig” Commands to Configure Network Interface in Linux](http://www.tecmint.com/ifconfig-command-examples/)

---

### Config File

/etc/sysconfig/network-scripts/ifcfg-eth0

[Red Hat Enterprise Linux 3: Interface Configuration Reference](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/3/html/Reference_Guide/s1-networkscripts-interfaces.html)

```txt
DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
```

```txt
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
NETWORK=10.0.1.0
NETMASK=255.255.255.0
IPADDR=10.0.1.27
USERCTL=no
```

---

### Misc

```bash
systemctl restart network
```

[12 Tcpdump Commands – A Network Sniffer Tool](http://www.tecmint.com/12-tcpdump-commands-a-network-sniffer-tool/)

http://www.server-world.info/en/note?os=CentOS_7&p=initial_conf&f=3