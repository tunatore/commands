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
kubectl create configmap config --from-literal=foo=lala --from-literal=foo2=lolo
kubectl create cm configmap2 --from-file=config.txt
kubectl create cm configmap3 --from-env-file=config.env
kubectl create cm configmap4 --from-file=special=config4.txt
kubectl create configmap anotherone --from-literal=var6=val6 --from-literal=var7=val7

--create secret
kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt
kubectl create secret generic db-user-pass --from-file=username=./username.txt --from-file=password=./password.txt
kubectl create secret generic dev-db-secret --from-literal=username=devuser --from-literal=password='S!B\*d$zDsb='
kubectl create secret generic my-secret --from-literal=foo=bar -o yaml --dry-run > my-secret.yaml
kubectl create secret generic my-secret --from-env-file=myvars.env
kubectl create secret generic mysecret --from-literal=password=mypass
kubectl create secret generic mysecret2 --from-file=username
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
kubectl rollout history deploy nginx --revision=6
kubectl rollout undo deployment/nginx --to-revision=<revision number>
kubectl rollout history deployment/nginx --revision=1
kubectl rollout status deploy/nginx
kubectl rollout undo deploy/nginx
kubectl scale deploy/nginx --replicas=3
kubectl get deploy
kubectl get deploy nginx --export -o yaml > exported.yaml
kubectl create deployment nginx --image=nginx:1.7.8 --dry-run=client -o yaml > deploy.yaml

--run
kubectl run nginx --image=nginx --restart=Never
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml > mypod.yaml
kubectl run crontest --image=busybox --schedule="*/1 * * * *" --restart=OnFailure --dry-run -o yaml
kubectl run nginx --image=nginx --replicas=3
kubectl run nginx --image=nginx --replicas=3 expose --port=80 --dry-run -o yaml > nginx.yaml
kubectl run nginx --image=nginx --restart=Never --requests='cpu=100m,memory=256Mi' --limits='cpu=200m,memory=512Mi'
kubectl run wordpress --image=wordpress --restart=Never --requests=cpu=200,memory=250Mi --limits=cpu=400m,memory=500Mi
kubectl run nginx --image=nginx --replicas=3 --labels=tier=frontend
kubectl run cm-pod --image=nginx --restart=Never --env=place=holder --dry-run -o yaml > cm-pod.yaml
kubectl run nginx --image=nginx --restart=Never -n mynamespace
kubectl run busybox --image=busybox --command --restart=Never -it -- env
kubectl run busybox --image=busybox --command --restart=Never -- env
kubectl run nginx --image=nginx --restart=Never --port=80
kubectl run busybox --image=busybox -it --restart=Never -- echo 'hello world'
kubectl run busybox --image=busybox -it --restart=Never -- /bin/sh -c 'echo hello world'
kubectl run busybox --image=busybox -it --rm --restart=Never -- /bin/sh -c 'echo hello world'
kubectl run busybox --image=busybox --restart=Never -o yaml --dry-run -- /bin/sh -c 'echo hello;sleep 3600' > pod.yaml
kubectl run busybox --image=busybox --restart=Never --dry-run -o yaml --command -- env > envpod.yaml
kubectl run nginx --image=nginx --restart=Never --env=var1=val1
kubectl run nginx --restart=Never --image=nginx --env=var1=val1 -it --rm -- env
kubectl run nginx1 --image=nginx --restart=Never --labels=app=v1
kubectl run foo --image=nginx --labels=app=foo --port=8080 --replicas=3
kubectl run nginx --image=nginx --restart=Never --serviceaccount=myuser -o yaml --dry-run > pod.yaml
kubectl run busybox --image=busybox --rm -it --restart=Never -- wget -O- http://nginx:80 --timeout 2
kubectl run busybox --image=busybox --rm -it --restart=Never --labels=access=granted -- wget -O- http://nginx:80 --timeout 2
kubectl run busybox --image=busybox --rm -it --restart=Never -- wget -O- 10.1.1.131:80

--create
kubectl create -f my-pod.yml
kubectl create job nginx --image=nginx  #job
kubectl create cronjob nginx --image=nginx --schedule="* * * * *"  #cronJob
kubectl create namespace mynamespace
kubectl create -f pod.yaml -n mynamespace
kubectl create quota myrq --hard=cpu=1,memory=1G,pods=2 --dry-run -o yaml
kubectl create job busybox --image=busybox -- /bin/sh -c 'echo hello;sleep 30;echo world'
kubectl create cronjob busybox --image=busybox --schedule="*/1 * * * *" -- /bin/sh -c 'date; echo Hello from the Kubernetes cluster'
kubectl create serviceaccount myuser
kubectl create deploy foo --image=nginx --dry-run -o yaml > foo.yml
kubectl create job busybox --image=busybox -- /bin/sh -c 'echo hello;sleep 30;echo world'

--delete
kubectl delete pods,services -l <label-key>=<label-value> # delete all pods and services with the label-key=label-value
kubectl delete -f mypod.yaml
kubectl delete pod my-pod --grace-period=0 --force
alias kdp='k delete po --force --grace-period=0'

--get
kubectl get pods --all-namespaces
kubectl get all --all-namespaces
kubectl get pod nginx -w
kubectl get pod -o wide
kubectl get pod -L app
kubectl get pod --label-columns=app
kubectl get pod -l app=v2
kubectl get pod -l 'app in (v2)'
kubectl get pod --selector=app=v2
kubectl get po --show-labels
kubectl get jobs -w
kubectl get cm config -o yaml
kubectl get cm configmap2 -o yaml
kubectl get cm configmap3 -o yaml
kubectl get sa --all-namespaces
kubectl get sa -A
kubectl get events | grep -i error
kubectl get svc nginx # services
kubectl get ep # endpoints
kubectl get pv
kubectl get pvc

--label
kubectl label deploy nginx tier=frontend
kubectl label deploy nginx tier-
kubectl label pod nginx2 app=v2 --overwrite
kubectl label pod nginx1 nginx2 nginx3 app-

--exec
kubectl exec -it nginx /bin/bash
kubectl exec -it nginx -- /bin/sh
kubectl exec -it busybox -c busybox2 -- /bin/sh
kubectl exec <pod-name> -c <container-name> -- date

--describe
kubectl describe pods # describe all pods
kubectl describe pods/<pod-name>
kubectl describe po nginx
kubectl describe cm config

--various commands
kubectl top pod -n my-namespace
kubectl annotate po nginx1 nginx2 nginx3 description='my description'
kubectl explain pod.spec.containers.livenessProbe
