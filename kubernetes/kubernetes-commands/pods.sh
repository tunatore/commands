-launch a pod using an image on a specific port
kubectl run sise --image=quay.io/openshiftlabs/simpleservice:0.5.0 --port=9876
-see the pod is running
kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
busybox                              0/1     Completed   0          26d
my-configmap-pod                     1/1     Running     43         25d
my-configmap-volume-pod              1/1     Running     43         25d
my-containerport-pod                 1/1     Running     1          25d
my-liveness-pod                      1/1     Running     27         22d
my-production-label-pod              1/1     Running     1          23d
my-pvc-pod                           1/1     Running     1          23d
my-readiness-pod                     1/1     Running     1          22d
my-secret-pod                        1/1     Running     41         25d
network-policy-client-pod            1/1     Running     0          17d
network-policy-secure-pod            1/1     Running     0          17d
nginx-deployment-5bf87f5f59-6r6kc    1/1     Running     0          19d
nginx-deployment-5bf87f5f59-rd7rm    1/1     Running     0          19d
nginx-deployment-5bf87f5f59-zchvp    1/1     Running     0          19d
rolling-deployment-7f76fc567-694r9   1/1     Running     0          19d
rolling-deployment-7f76fc567-k2ktd   1/1     Running     0          19d
rolling-deployment-7f76fc567-xhfhs   1/1     Running     0          19d
sise                                 1/1     Running     0          3m16s
-get the ip of a running pod
kubectl describe pod sise | grep IP:
IP:           172.17.0.24
  IP:  172.17.0.24
-test pod using curl
curl 172.17.0.24:9876/info

-create a pod using a configuration file
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pods/pod.yaml
-get pods
kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
busybox                              0/1     Completed   0          26d
my-configmap-pod                     1/1     Running     43         25d
my-configmap-volume-pod              1/1     Running     43         25d
my-containerport-pod                 1/1     Running     1          25d
my-liveness-pod                      1/1     Running     27         22d
my-production-label-pod              1/1     Running     1          23d
my-pvc-pod                           1/1     Running     1          23d
my-readiness-pod                     1/1     Running     1          22d
my-secret-pod                        1/1     Running     41         25d
network-policy-client-pod            1/1     Running     0          17d
network-policy-secure-pod            1/1     Running     0          17d
nginx-deployment-5bf87f5f59-6r6kc    1/1     Running     0          19d
nginx-deployment-5bf87f5f59-rd7rm    1/1     Running     0          19d
nginx-deployment-5bf87f5f59-zchvp    1/1     Running     0          19d
rolling-deployment-7f76fc567-694r9   1/1     Running     0          19d
rolling-deployment-7f76fc567-k2ktd   1/1     Running     0          19d
rolling-deployment-7f76fc567-xhfhs   1/1     Running     0          19d
sise                                 1/1     Running     0          7m47s
twocontainers                        2/2     Running     0          48s

-run a command in a container
kubectl exec twocontainers -c shell -i -t -- bash
[root@twocontainers /]# ls
anaconda-post.log  dev  home  lib64  mnt  proc  run   srv  tmp  var
bin                etc  lib   media  opt  root  sbin  sys  usr
[root@twocontainers /]# curl -s localhost:9876/info
{"host": "localhost:9876", "version": "0.5.0", "from": "127.0.0.1"}[root@twocont

-create a constraint container
kubectl create -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pods/constraint-pod.yaml
-specify the details of constraint container
kubectl describe pod constraintpod
...
Containers:
  sise:
    ...
    Limits:
      cpu:      500m
      memory:   64Mi
    Requests:
      cpu:      500m
      memory:   64Mi
...
-delete containers
kubectl delete pod twocontainers
kubectl delete pod constraintpod
kubectl delete --all pods
