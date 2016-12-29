# Permissions

## How To Give a User Sudo Privileges

### Ubuntu 16.04

```bash
sudo usermod -aG sudo username

sudo gpasswd -a username sudo
```

### CentOS

```bash
sudo usermod -aG wheel username

sudo gpasswd -a username wheel
```