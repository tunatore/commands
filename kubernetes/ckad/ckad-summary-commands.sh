-vim settings
vi ~/.vimrc
set number
set tabstop=2 shiftwidth=2 expandtab
. ~/.vimrc

or

vi ~/.vimrc
set ts=2 sts=2 sw=2 et number
. /~.vimrc

--configMap
kubectl create configmap app-config --from-literal=key123=value123

--create secret
kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt
kubectl create secret generic db-user-pass --from-file=username=./username.txt --from-file=password=./password.txt
kubectl create secret generic dev-db-secret --from-literal=username=devuser --from-literal=password='S!B\*d$zDsb='
kubectl create secret generic my-secret --from-literal=foo=bar -o yaml --dry-run > my-secret.yaml
k create secret generic my-secret --from-env-file=myvars.env
kubectl get secrets
kubectl get secret my-secret -o yaml

--namespace
kubectl get namespaces
kubectl get namespaces --show-labels
kubectl get pods --all-namespaces
kubectl create ns mynamespace
kubectl create -f pod.yaml --namespace=test
kubectl apply -f pod.yaml --namespace=test