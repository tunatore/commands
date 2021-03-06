https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/

>minikube start
>kubectl api-resources -o name
>kubectl get pods

#system pods -n namespace
>kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS   AGE
coredns-66bff467f8-94pcf           1/1     Running   2          24d
coredns-66bff467f8-j7g9t           1/1     Running   2          24d
etcd-minikube                      1/1     Running   1          24d
kube-apiserver-minikube            1/1     Running   1          24d
kube-controller-manager-minikube   1/1     Running   1          24d
kube-proxy-ntds7                   1/1     Running   1          24d
kube-scheduler-minikube            1/1     Running   1          24d
storage-provisioner                1/1     Running   2          24d

>kubectl get nodes
 NAME       STATUS   ROLES    AGE   VERSION
 minikube   Ready    master   24d   v1.18.1

>kubectl get node minikube
>kubectl get node minikube -o yaml
>kubectl describe node minikube
