# Linux container with sysadmin tools
## How to use:
* mkdir -p $(pwd)/workdir or mount your workdir
* docker run -it --rm -v $(pwd)/workdir:/workdir carlosgaro/tools:2.0
* docker run -it --rm --name carlosgaro-tools carlosgaro/tools:2.0
* docker run -d --rm --name carlosgaro-tools -p 4000:4000 carlosgaro/tools:2.0 nc -l 4000
* kubectl run tools -it --rm --image=carlosgaro/tools:2.0 -- bash

## Package installed:
- ansible
- apache-libcloud
- apache2-utils
- apt-transport-https
- awscli
- azure-cli
- build-essential
- ca-certificates
- coverage
- curl
- databricks-cli
- default-mysql-client
- dnsutils
- docker-ce-cli
- docker-compose
- dos2unix
- dotnet-sdk-3.1
- dotnet-sdk-5.0
- git 
- gnupg
- gnupg-agent
- gnupg2
- google-auth
- google-cloud-sdk
- ipcalc
- iputils-ping
- jq
- kubectl
- lsb-release
- make 
- mdadm
- msrestazure
- mypy
- net-tools
- netcat 
- nload
- nmap
- openssh-client
- openssh-server
- packaging
- paramiko
- powershell 
- pylint
- pyspark
- pytest
- python3
- python3-pip
- python3-venv
- pywinrm
- requests
- rpl
- screen
- sdkman
- setuptools
- software-properties-common
- sqlcmd
- sshpass 
- sshuttle
- sudo
- telnet
- telnet
- terraform-switcher
- traceroute
- tree
- unzip
- unzip
- urllib3
- vim 
- virtualenv 
- wget
- zip 
