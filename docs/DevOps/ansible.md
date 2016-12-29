# Ansible

Ansible is a free-software platform for configuring and managing computers which combines multi-node software deployment, ad hoc task execution, and configuration management.

- It manages nodes over SSH or over PowerShell.
- Modules work over JSON and standard output and can be written in any programming language.
- The system uses YAML to express reusable descriptions of systems.

[https://www.ansible.com/](https://www.ansible.com/)

./inventory

```bash
[RancherHost]
192.168.1.105 ansible_ssh_user=bob ansible_ssh_pass=
```

ansible 192.168.1.105 -i inventory -u bob -m ping -k

## Debug Levels

- -v level 1 debug
- -vv level 2 debug
- -vvv level 3 debug

ansible all -i inventory -u bob -m command -a "command1"

command and shell module
shell module can use shell modules

```bash
[bob@unknown00155D037151 ansiblelab]$ ansible all -i inventory -m ping -k -vvv
Using /etc/ansible/ansible.cfg as config file
SSH password:
<192.168.1.105> ESTABLISH SSH CONNECTION FOR USER: bob
<192.168.1.105> SSH: EXEC sshpass -d12 ssh -C -q -o ControlMaster=auto -o ControlPersist=60s -o User=bob -o ConnectTimeout=10 -o ControlPath=/home/bob/.ansible/cp/ansible-ssh-%h-%p-%r
 192.168.1.105 '/bin/sh -c '"'"'( umask 77 && mkdir -p "` echo $HOME/.ansible/tmp/ansible-tmp-1475387002.67-101290707024052 `" && echo ansible-tmp-1475387002.67-101290707024052="` echo $HOM
E/.ansible/tmp/ansible-tmp-1475387002.67-101290707024052 `" ) && sleep 0'"'"''
<192.168.1.105> PUT /tmp/tmp1Ql_HI TO /home/bob/.ansible/tmp/ansible-tmp-1475387002.67-101290707024052/ping
<192.168.1.105> SSH: EXEC sshpass -d12 sftp -o BatchMode=no -b - -C -o ControlMaster=auto -o ControlPersist=60s -o User=bob -o ConnectTimeout=10 -o ControlPath=/home/bob/.ansible/cp/a
nsible-ssh-%h-%p-%r '[192.168.1.105]'
<192.168.1.105> ESTABLISH SSH CONNECTION FOR USER: bob
<192.168.1.105> SSH: EXEC sshpass -d12 ssh -C -q -o ControlMaster=auto -o ControlPersist=60s -o User=bob -o ConnectTimeout=10 -o ControlPath=/home/bob/.ansible/cp/ansible-ssh-%h-%p-%r
 -tt 192.168.1.105 '/bin/sh -c '"'"'LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LC_MESSAGES=en_US.UTF-8 /usr/bin/python /home/bob/.ansible/tmp/ansible-tmp-1475387002.67-101290707024052/ping; rm
-rf "/home/bob/.ansible/tmp/ansible-tmp-1475387002.67-101290707024052/" > /dev/null 2>&1 && sleep 0'"'"''
192.168.1.105 | SUCCESS => {
    "changed": false,
    "invocation": {
        "module_args": {
            "data": null
        },
        "module_name": "ping"
    },
    "ping": "pong"
}
```

ansible-doc -l

```yaml

rancher_host.yaml
---
- hosts: RancherHost
  sudo: yes

  tasks:
  - name: Add Docker Repository
    yum_repository:
      name: docker
      description: Docker Repository
      baseurl: https://yum.dockerproject.org/repo/main/centos/7/
      gpgkey: https://yum.dockerproject.org/gpg
      gpgcheck: yes

  - name: Ensure Docker Is Installed
    yum: name=docker-engine state=latest

  - name: Start Docker Service
    service: name=docker enabled=yes state=started

```

Jinja2 Tamplates

```bash

tasks:

  - template:
      src=templates/httpd.j2
      dest=/etc/httpd/conf/httpd.conf
      owner=httpd

```
