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

--deployment
kubectl create deploy nginx-deploy –-image=nginx –-dry-run -oyaml > nginx-deploy.yaml
kubectl set image deployment/<deployment name> <container name>=<image name> --record
kubectl set image deploy/nginx nginx=nginx:1.9.1 --record
kubectl rollout history deployment/<deployment name> --revision=<revision number>
kubectl rollout undo deployment.v1.apps/<deployment name> --to-revision=<revision number>
kubectl rollout undo deployment/nginx --to-revision=<revision number>
kubectl rollout history deployment/nginx --revision=1
kubectl rollout status deploy/nginx
kubectl rollout undo deploy/nginx
kubectl scale deploy/nginx --replicas=3
kubectl get deploy
kubectl get deploy nginx --export -o yaml > exported.yaml
