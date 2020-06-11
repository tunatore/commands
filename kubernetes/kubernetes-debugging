https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/
https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/
https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/

>kubectl create namespace nginx-ns
namespace/nginx-ns created

>vi my-nginx-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: nginx-ns
spec:
  containers:
  - name: nginx
    image: nginx:1.158

>kubectl create -f my-nginx-pod.yml

>kubectl get namespace
NAME                   STATUS   AGE
default                Active   29d
kube-node-lease        Active   29d
kube-public            Active   29d
kube-system            Active   29d
kubernetes-dashboard   Active   10d
my-ns                  Active   5d7h
nginx-ns               Active   2m20s

>kubectl get pods --all-namespaces
NAMESPACE              NAME                                         READY   STATUS             RESTARTS   AGE
default                busybox                                      0/1     Completed          0          6d22h
default                my-annotation-pod                            1/1     Running            0          3d2h
default                my-args-pod                                  0/1     Completed          0          5d5h
default                my-command-pod                               0/1     Completed          0          5d5h
default                my-configmap-pod                             1/1     Running            24         5d4h
default                my-configmap-volume-pod                      1/1     Running            24         5d4h
default                my-containerport-pod                         1/1     Running            0          5d5h
default                my-development-label-pod                     1/1     Running            0          3d2h
default                my-liveness-pod                              1/1     Running            8          2d23h
default                my-production-label-pod                      1/1     Running            0          3d2h
default                my-pvc-pod                                   1/1     Running            0          3d23h
default                my-readiness-pod                             1/1     Running            0          2d23h
default                my-resource-pod                              1/1     Running            22         5d
default                my-secret-pod                                1/1     Running            22         5d
default                my-securitycontext-pod                       0/1     CrashLoopBackOff   287        5d2h
default                my-serviceaccount-pod                        1/1     Running            21         4d23h
kube-system            coredns-66bff467f8-94pcf                     1/1     Running            2          29d
kube-system            coredns-66bff467f8-j7g9t                     1/1     Running            2          29d
kube-system            etcd-minikube                                1/1     Running            1          29d
kube-system            kube-apiserver-minikube                      1/1     Running            1          29d
kube-system            kube-controller-manager-minikube             1/1     Running            1          29d
kube-system            kube-proxy-ntds7                             1/1     Running            1          29d
kube-system            kube-scheduler-minikube                      1/1     Running            1          29d
kube-system            storage-provisioner                          1/1     Running            2          29d
kubernetes-dashboard   dashboard-metrics-scraper-84bfdf55ff-mrjkv   1/1     Running            0          10d
kubernetes-dashboard   kubernetes-dashboard-696dbcc666-75mqp        1/1     Running            0          10d
my-ns                  my-ns-pod                                    1/1     Running            26         5d7h
nginx-ns               nginx                                        0/1     ImagePullBackOff   0          95s

>kubectl describe pod nginx -n nginx-ns
Name:         nginx
Namespace:    nginx-ns
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Thu, 11 Jun 2020 19:15:15 +0200
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           172.17.0.20
IPs:
  IP:  172.17.0.20
Containers:
  nginx:
    Container ID:
    Image:          nginx:1.158
    Image ID:
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-r77v8 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  default-token-r77v8:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-r77v8
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  <unknown>            default-scheduler  Successfully assigned nginx-ns/nginx to minikube
  Normal   Pulling    63s (x4 over 2m40s)  kubelet, minikube  Pulling image "nginx:1.158"
  Warning  Failed     61s (x4 over 2m39s)  kubelet, minikube  Failed to pull image "nginx:1.158": rpc error: code = Unknown desc = Error response from daemon: manifest for nginx:1.158 not found: manifest unknown: manifest unknown
  Warning  Failed     61s (x4 over 2m39s)  kubelet, minikube  Error: ErrImagePull
  Normal   BackOff    49s (x6 over 2m38s)  kubelet, minikube  Back-off pulling image "nginx:1.158"
  Warning  Failed     37s (x7 over 2m38s)  kubelet, minikube  Error: ImagePullBackOff

>kubectl edit pod nginx -n nginx-ns
>kubectl get pods -n nginx-ns
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          5m37s

>kubectl get pod nginx -n nginx-ns -o yaml --export > my-nginx-pod.yml

>kubectl get pod nginx -n nginx-ns -o yaml --export > nginx.pod.yml
>kubectl delete pod nginx -n nginx-ns
>kubectl apply -f nginx.pod.yml -n nginx-ns

>kubectl get pods -n nginx-ns
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          46s

>kubectl describe pods nginx -n nginx-ns
