#!/bin/bash -ex
sudo apt install snapd -fy
sudo snap install microk8s --classic --channel=1.19
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
echo "export PATH=$PATH:/snap/bin" >> ~/.profile
echo "alias kubectl='microk8s kubectl'" >> ~/.bash_aliases
.  ~/.bash_aliases
microk8s status --wait-ready
microk8s enable dns storage ingress rbac registry
sudo bash -c 'cat << EOF >> /etc/docker/daemon.json
{
    "insecure-registries" : ["localhost:32000"]
}
EOF'
sudo systemctl restart docker