#!/bin/bash
PUBLIC_IP=$(curl -s ifconfig.co) \
PRIVATE_IP=$(hostname -I | awk '{print $1}')

curl -sSLf https://get.k0s.sh | sudo sh
sudo k0s default-config > k0s-cluster-config.yml
cp k0s-cluster-config.yml k0s-cluster-config.yml.bk
sudo sed -i "s/$PRIVATE_IP/$PUBLIC_IP/g" k0s-cluster-config.yml
sudo k0s install controller --enable-worker -c k0s-cluster-config.yml
sudo k0s start

WAIT_START_K0S=$(sudo k0s kubectl get nodes | grep Ready > /dev/null && echo $?)
while [$WAIT_START_K0S -eq 0 ]; do
  WAIT_START_K0S=$(sudo k0s kubectl get nodes | grep Ready > /dev/null && echo $?)
  sleep 5
done

sudo k0s kubeconfig admin > k0s-kubectl-config.yml
sudo sed -i "s/$PRIVATE_IP/$PUBLIC_IP/g" k0s-kubectl-config.yml
echo "alias kubectl='sudo k0s kubectl'" >> ~/.bash_aliases && . ~/.bash_aliases
cat k0s-kubectl-config.yml

# curl -sk https://raw.githubusercontent.com/mauserkar/tools/master/scripts/install/k0s.sh | bash