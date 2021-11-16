## Deploys
### Carlosgaro tools
kubectl apply -f https://raw.githubusercontent.com/mauserkar/tools/master/k8s/deploy-tools.yml
kubectl apply -f https://raw.githubusercontent.com/mauserkar/tools/master/k8s/deploy-echo.yml
### Nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/baremetal/deploy.yaml
### Cert manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml
### Metallb
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml

## Commands
### Get all
kubectl get deployment,svc,pods,pvc,pv,ing --all-namespaces -o wide
### Cert manager
kubectl get pods --namespace cert-manager
kubectl describe clusterissuer,certificate,order,challenge,certificaterequest --all-namespaces