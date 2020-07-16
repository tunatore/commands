context
-----------------------------------------------------------------------
kubectl config get-contexts
CURRENT   NAME                 CLUSTER          AUTHINFO         NAMESPACE
          docker-desktop       docker-desktop   docker-desktop
          docker-for-desktop   docker-desktop   docker-desktop
*         minikube             minikube         minikube

kubectl config current-context
minikube

kubectl config use-context minikube
Switched to context "minikube".

namespaces
-----------------------------------------------------------------------
-create namespace
kubectl create namespace mynamespace

-get all pods in a namespace
kubectl get pods --all-namespaces
or
kubectl get pods -A

kubectl get namespaces
kubectl get ns

kubectl get pod -n my-ns

kubectl get svc -n my-ns

pod
-----------------------------------------------------------------------
-create pod help command
kubectl create pod -h

-create a pod in the namespace
kubectl run nginx --image=nginx --restart=Never -n mynamespace

-create a pod from yaml
kubectl create -f pod.yaml

-get with different level verbosity
kubectl get po nginx --v=2
kubectl get po nginx --v=6
kubectl get po nginx --v=7
kubectl get po nginx --v=8

-list all pods sorted by podname
kubectl get po --sort-by=.metadata.name

-delete a pod
kubectl delete pod podname

-show all labels
kubectl get pods --show-labels

-export to yaml
kubectl get pod podname -o yaml > pod.yaml

-without cluster information
kubectl get pod podname -o yaml --export

-label a pod
kubectl label pod podname env=qa
kubectl label pod podname env=prod --overwrite
kubectl get pods -l env=qa
kubectl get pods -l 'env in (qa,prod)'

-annotate a pod
kubectl annotate pod nginx name=nginxpod
kubectl describe po nginx | grep -i annotations
-remove an annotation
kubectl annotate pod nginx name-

-describe
kubectl describe pod podname

-delete a pod
kubectl delete pod podname

-delete all pods
kubectl delete pod --all

-force delete a pod without waiting
kubectl delete pod nginx --grace-period=0 --force

-set image to a new version
kubectl set image pod/nginx nginx=nginx:1.5.0

deployment
-----------------------------------------------------------------------
kubectl get deploy
kubectl get deployment deploymentname -o yaml > deployment.yaml

-create a busybox with sleep
kubectl run busybox --image=busybox --restart=Never -- /bin/sh -c "sleep 5000"

service
-----------------------------------------------------------------------
kubectl get service
kubectl get service servicename -o yaml > service.yaml

logs
-----------------------------------------------------------------------
kubectl logs -f podname
kubectl logs -f podname containername
kubectl logs podname -c containername

run
-----------------------------------------------------------------------
kubectl run nginx --image=nginx --restart=Never --dry-run=client -o yaml
kubectl run nginx --image=nginx --restart=Never --port=80 --dry-run=client -o yaml
kubectl run nginx --image=nginx --restart=Never --labels=env=dev
kubectl run nginx --image=nginx --restart=Never --labels=env=prod

other commands
-----------------------------------------------------------------------
kubectl top pod busybox --containers
