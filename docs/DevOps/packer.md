# Packer

Packer is a tool for creating machine and container images for multiple platforms from a single source configuration.

- [https://www.packer.io/](https://www.packer.io/)
- [QEMU BUILDER](https://www.packer.io/docs/builders/qemu.html)
- [Debugging Packer](https://www.packer.io/docs/other/debugging.html)
- [packer github](https://github.com/mitchellh/packer)

`PACKER_LOG=1 /usr/local/packer build -debug template.packer`

```bash
# mkdir /usr/local/packer
# sudo wget https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip
# sudo unzip packer_0.10.1_linux_amd64.zip
#
```

```json
{
    "builders": [

    ],
    "provisioners": [

    ],
    "post-processors": [

    ]
}
```

## Builders

- Generage your image
- Provider Specific

```json
{
    "type": "amazon-ebs",
    "name": "BigAwsServer"
    "region": "us-west-2"
}
```

## Provisioners

- Customize your image
- Scripts or configuration management
- Can be builder specific

```json
{
    "type": "shell",
    "script": "dothings.sh",
    "only": ["BigAwsServer"]
}
```

## Post-processors

- Put on the finishing touches
- Intigration with other services
- Docker conversion

```json
{
    "type": "compress",
    "output": "BigAwsServer.tar.gz",
    "only": ["BigAwsServer"]
}
```

Install version 2.0
yum install qemu-system-x86.x86_64


Kickstart
cat /root/anaconda-ks.cfg
cp /root/anaconda-ks.cfg

/var/www/html/anaconda-ks.cfg
chmod 666 anaconda-ks.cfg

/home/myuser/Documents/packertest
PACKER_LOG=1 /usr/local/packer build template.packer

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-kickstart2-options.html

Power Shell Activate Nested Virtualization
Set-VMProcessor -VMName CentOS-Desktop -ExposeVirtualizationExtensions $true
[Run Hyper-V in a Virtual Machine with Nested Virtualization](https://msdn.microsoft.com/en-us/virtualization/hyperv_on_windows/user_guide/nesting)

