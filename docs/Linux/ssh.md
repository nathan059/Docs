# SSH

## Install

### Ubuntu 16.04

```bash
sudo apt-get install openssh-server

# Check ssh is running
sudo service ssh status
sudo systemctl status sshd
```

## Config File

- Sytem file: `/etc/ssh/ssh_config`
- User file:  `~/.ssh/config`

Common Configuration Settings

```text
Port 1234
PermitRootLogin no
AllowUsers tim
```

Run last ssh command

```bash
!ssh
```

