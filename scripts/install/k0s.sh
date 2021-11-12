#!/bin/bash
curl -sSLf https://get.k0s.sh | sudo sh
sudo k0s install controller --single
sudo k0s start
sudo k0s kubectl get nodes
echo "alias kc='sudo k0s kubectl'" >> ~/.bash_aliases
source ~/.bash_aliases