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
kubectl rollout history deploy nginx --revision=6
kubectl rollout undo deployment.v1.apps/<deployment name> --to-revision=<revision number>
kubectl rollout undo deployment/nginx --to-revision=<revision number>
kubectl rollout history deployment/nginx --revision=1
kubectl rollout status deploy/nginx
kubectl rollout undo deploy/nginx
kubectl scale deploy/nginx --replicas=3
kubectl get deploy
kubectl get deploy nginx --export -o yaml > exported.yaml
kubectl create deployment nginx  --image=nginx:1.7.8  --dry-run=client -o yaml > deploy.yaml

--run
kubectl run nginx --image=nginx --restart=Never
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml > mypod.yaml
kubectl run crontest  --image=busybox --schedule="*/1 * * * *" --restart=OnFailure --dry-run -o yaml
kubectl run nginx --image=nginx  --replicas=3
kubectl run nginx --image=nginx --replicas=3 expose --port=80 --dry-run -o yaml > nginx.yaml
kubectl run bb-cj --image=busybox --restart=OnFailure --schedule="*/1 * * * *" -- date
kubectl run bb-job --image=busybox --restart=OnFailure -- /bin/sh -c "sleep 4800"
kubectl run wordpress --image=wordpress --restart=Never --requests=cpu=200,memory=250Mi --limits=cpu=400m,memory=500Mi
kubectl run nginx --image=nginx --replicas=3 --labels=tier=frontend
kubectl run cm-pod --image=nginx --restart=Never --env=place=holder --dry-run -o yaml > cm-pod.yaml
kubectl run nginx --image=nginx --restart=Never -n mynamespace
kubectl run busybox --image=busybox --command --restart=Never -it -- env
kubectl run busybox --image=busybox --command --restart=Never -- env
kubectl run busybox --image=busybox --restart=Never --dry-run -o yaml --command -- env > envpod.yaml
kubectl run nginx --image=nginx --restart=Never --port=80
kubectl run busybox --image=busybox -it --restart=Never -- echo 'hello world'
kubectl run busybox --image=busybox -it --restart=Never -- /bin/sh -c 'echo hello world'
kubectl run busybox --image=busybox -it --rm --restart=Never -- /bin/sh -c 'echo hello world'
kubectl run nginx --image=nginx --restart=Never --env=var1=val1 #create a pod
kubectl run nginx --restart=Never --image=nginx --env=var1=val1 -it --rm -- env
kubectl run busybox --image=busybox --restart=Never -o yaml --dry-run -- /bin/sh -c 'echo hello;sleep 3600' > pod.yaml
kubectl run nginx1 --image=nginx --restart=Never --labels=app=v1
kubectl run nginx --image=nginx --restart=Never --requests='cpu=100m,memory=256Mi' --limits='cpu=200m,memory=512Mi'
kubectl run nginx --image=nginx --restart=Never --serviceaccount=myuser -o yaml --dry-run > pod.yaml

--create
kubectl create -f my-pod.yml
kubectl create job nginx --image=nginx  #job
kubectl create cronjob nginx --image=nginx --schedule="* * * * *"  #cronJob
kubectl create namespace mynamespace
kubectl create -f pod.yaml -n mynamespace
kubectl create quota myrq --hard=cpu=1,memory=1G,pods=2 --dry-run -o yaml
kubectl create job busybox --image=busybox -- /bin/sh -c 'echo hello;sleep 30;echo world'
kubectl create cronjob busybox --image=busybox --schedule="*/1 * * * *" -- /bin/sh -c 'date; echo Hello from the Kubernetes cluster'
kubectl create configmap config --from-literal=foo=lala --from-literal=foo2=lolo
kubectl create cm configmap2 --from-file=config.txt
kubectl create cm configmap3 --from-env-file=config.env
kubectl create cm configmap4 --from-file=special=config4.txt
kubectl create configmap anotherone --from-literal=var6=val6 --from-literal=var7=val7
kubectl create secret generic mysecret --from-literal=password=mypass
kubectl create secret generic mysecret2 --from-file=username
kubectl create serviceaccount myuser

--delete
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
