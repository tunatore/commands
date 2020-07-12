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

pod
-----------------------------------------------------------------------
-create pod help command
kubectl create pod -h

-create a pod in the namespace
kubectl run nginx --image=nginx --restart=Never -n mynamespace

-create a pod from yaml
kubectl create -f pod.yaml

-delete a pod
kubectl delete pod podname

-show all labels
kubectl get pods --show-labels

-export to yaml
kubectl get pod podname -o yaml > pod.yaml

-label a pod
kubectl label pod podname env=qa
kubectl label pod podname env=prod --overwrite

deployment
-----------------------------------------------------------------------
kubectl get deploy
kubectl get deployment deploymentname -o yaml > deployment.yaml

service
-----------------------------------------------------------------------
kubectl get service
kubectl get service servicename -o yaml > service.yaml

logs
-----------------------------------------------------------------------
kubectl logs -f podname
kubectl logs -f podname containername
