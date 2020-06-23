>kubectl get pods --all-namespaces
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE
candy-store   auth-ws                                 2/2     Running            1          92m
candy-store   candy-ws                                2/2     Running            1          92m
candy-store   cart-ws                                 0/1     CrashLoopBackOff   37         92m
default       inventory-svc                           1/1     Running            0          93m
default       shipping-svc                            1/1     Running            0          93m
internal      build-svc                               1/1     Running            0          92m
kube-system   coredns-54ff9cd656-f8qpr                1/1     Running            0          93m
kube-system   coredns-54ff9cd656-k74pc                1/1     Running            0          93m
kube-system   etcd-ip-10-0-1-101                      1/1     Running            0          92m
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running            0          92m
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running            0          92m
kube-system   kube-flannel-ds-amd64-7bg9d             1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-b2h48             1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-rq46h             1/1     Running            0          93m
kube-system   kube-proxy-dpwkf                        1/1     Running            0          93m
kube-system   kube-proxy-n52b6                        1/1     Running            0          93m
kube-system   kube-proxy-rgjgt                        1/1     Running            0          93m
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running            0          92m
kube-system   metrics-server-6447c7cf8c-stc5k         1/1     Running            0          92m

>vi /home/cloud_user/debug/broken-pod-name.txt

>kubectl top pod -n candy-store
NAME       CPU(cores)   MEMORY(bytes)
auth-ws    200m         9Mi
candy-ws   100m         9Mi
cart-ws    0m           0Mi

>vi /home/cloud_user/debug/high-cpu-pod-name.txt

>kubectl get pod cart-ws -n candy-store -o json > /home/cloud_user/debug/broken-pod-summary.json

>vi /home/cloud_user/debug/broken-pod-summary.json

>kubectl logs cart-ws -n candy-store > /home/cloud_user/debug/broken-pod-logs.log

>kubectl describe pod cart-ws -n candy-store
Name:               cart-ws
Namespace:          candy-store
Priority:           0
PriorityClassName:  <none>
Node:               ip-10-0-1-102/10.0.1.102
Start Time:         Tue, 23 Jun 2020 16:08:50 +0000
Labels:             <none>
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"cart-ws","namespace":"candy-store"},"spec":{"containers":[{"image":"l...
Status:             Running
IP:                 10.244.1.2
Containers:
  cart-ws:
    Container ID:   docker://9a0a8d137f74ed761abbcc71b61a41382f63e07f57d65d31fefe0b4fca0615a7
    Image:          linuxacademycontent/candy-service:2
    Image ID:       docker-pullable://linuxacademycontent/candy-service@sha256:614fb2c1f251a53968564f0ab22576e6af4236df8c65e19508062541a54bf4fa
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 23 Jun 2020 17:46:54 +0000
      Finished:     Tue, 23 Jun 2020 17:47:09 +0000
    Ready:          False
    Restart Count:  39
    Liveness:       http-get http://:8081/ealthz delay=5s timeout=1s period=5s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-m9ggk (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  default-token-m9ggk:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-m9ggk
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age                    From                    Message
  ----     ------     ----                   ----                    -------
  Warning  Unhealthy  25m (x91 over 99m)     kubelet, ip-10-0-1-102  Liveness probe failed: HTTP probe failed with statuscode: 404
  Warning  BackOff    4m58s (x411 over 98m)  kubelet, ip-10-0-1-102  Back-off restarting failed container

>kubectl get pod cart-ws -n candy-store -o yaml --export > broken-pod.yml

>vi broken-pod.yml
"Last login: Mon Jun 22 21:31:38 on ttys000
[oh-my-zsh] Random theme 'muse' loaded
~ ᐅ cloud_user@54.227.22.6
zsh: command not found: cloud_user@54.227.22.6
~ ᐅ ssh cloud_user@54.227.22.6
The authenticity of host '54.227.22.6 (54.227.22.6)' can't be established.
ECDSA key fingerprint is SHA256:.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '54.227.22.6' (ECDSA) to the list of known hosts.
Password:
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.15.0-1065-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jun 23 17:40:33 UTC 2020

  System load:  0.7                Processes:              123
  Usage of /:   19.9% of 19.32GB   Users logged in:        0
  Memory usage: 24%                IP address for ens5:    10.0.1.101
  Swap usage:   0%                 IP address for docker0: 172.17.0.1

 * "If you've been waiting for the perfect Kubernetes dev solution for
   macOS, the wait is over. Learn how to install Microk8s on macOS."

   https://www.techrepublic.com/article/how-to-install-microk8s-on-macos/

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

32 packages can be updated.
0 updates are security updates.


*** System restart required ***

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

cloud_user@ip-10-0-1-101:~$
cloud_user@ip-10-0-1-101:~$
cloud_user@ip-10-0-1-101:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                    READY   STATUS    RESTARTS   AGE
candy-store   auth-ws                                 2/2     Running   1          92m
candy-store   candy-ws                                2/2     Running   1          92m
candy-store   cart-ws                                 1/1     Running   36         92m
default       inventory-svc                           1/1     Running   0          92m
default       shipping-svc                            1/1     Running   0          92m
internal      build-svc                               1/1     Running   0          92m
kube-system   coredns-54ff9cd656-f8qpr                1/1     Running   0          92m
kube-system   coredns-54ff9cd656-k74pc                1/1     Running   0          92m
kube-system   etcd-ip-10-0-1-101                      1/1     Running   0          91m
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running   0          91m
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running   0          91m
kube-system   kube-flannel-ds-amd64-7bg9d             1/1     Running   0          92m
kube-system   kube-flannel-ds-amd64-b2h48             1/1     Running   0          92m
kube-system   kube-flannel-ds-amd64-rq46h             1/1     Running   0          92m
kube-system   kube-proxy-dpwkf                        1/1     Running   0          92m
kube-system   kube-proxy-n52b6                        1/1     Running   0          92m
kube-system   kube-proxy-rgjgt                        1/1     Running   0          92m
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running   0          91m
kube-system   metrics-server-6447c7cf8c-stc5k         1/1     Running   0          92m
cloud_user@ip-10-0-1-101:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE
candy-store   auth-ws                                 2/2     Running            1          92m
candy-store   candy-ws                                2/2     Running            1          92m
candy-store   cart-ws                                 0/1     CrashLoopBackOff   37         92m
default       inventory-svc                           1/1     Running            0          93m
default       shipping-svc                            1/1     Running            0          93m
internal      build-svc                               1/1     Running            0          92m
kube-system   coredns-54ff9cd656-f8qpr                1/1     Running            0          93m
kube-system   coredns-54ff9cd656-k74pc                1/1     Running            0          93m
kube-system   etcd-ip-10-0-1-101                      1/1     Running            0          92m
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running            0          92m
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running            0          92m
kube-system   kube-flannel-ds-amd64-7bg9d             1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-b2h48             1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-rq46h             1/1     Running            0          93m
kube-system   kube-proxy-dpwkf                        1/1     Running            0          93m
kube-system   kube-proxy-n52b6                        1/1     Running            0          93m
kube-system   kube-proxy-rgjgt                        1/1     Running            0          93m
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running            0          92m
kube-system   metrics-server-6447c7cf8c-stc5k         1/1     Running            0          92m
cloud_user@ip-10-0-1-101:~$ vi /home/cloud_user/debug/broken-pod-name.txt
cloud_user@ip-10-0-1-101:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE
candy-store   auth-ws                                 2/2     Running            1          93m
candy-store   candy-ws                                2/2     Running            1          93m
candy-store   cart-ws                                 0/1     CrashLoopBackOff   37         93m
default       inventory-svc                           1/1     Running            0          93m
default       shipping-svc                            1/1     Running            0          93m
internal      build-svc                               1/1     Running            0          93m
kube-system   coredns-54ff9cd656-f8qpr                1/1     Running            0          94m
kube-system   coredns-54ff9cd656-k74pc                1/1     Running            0          94m
kube-system   etcd-ip-10-0-1-101                      1/1     Running            0          93m
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running            0          93m
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-7bg9d             1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-b2h48             1/1     Running            0          93m
kube-system   kube-flannel-ds-amd64-rq46h             1/1     Running            0          93m
kube-system   kube-proxy-dpwkf                        1/1     Running            0          94m
kube-system   kube-proxy-n52b6                        1/1     Running            0          94m
kube-system   kube-proxy-rgjgt                        1/1     Running            0          94m
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running            0          93m
kube-system   metrics-server-6447c7cf8c-stc5k         1/1     Running            0          93m
cloud_user@ip-10-0-1-101:~$ kubectl top pod -n candy-store
NAME       CPU(cores)   MEMORY(bytes)
auth-ws    200m         9Mi
candy-ws   100m         9Mi
cart-ws    0m           0Mi
cloud_user@ip-10-0-1-101:~$ vi vi /home/cloud_user/debug/high-cpu-pod-name.txt
2 files to edit
cloud_user@ip-10-0-1-101:~$ vi /home/cloud_user/debug/high-cpu-pod-name.txt
cloud_user@ip-10-0-1-101:~$ kubectl get pod cart-ws -n candy-store -o json > /home/cloud_user/debug/broken-pod-summary.json
cloud_user@ip-10-0-1-101:~$ vi /home/cloud_user/debug/broken-pod-summary.json
cloud_user@ip-10-0-1-101:~$ vi /home/cloud_user/debug/broken-pod-summary.json
cloud_user@ip-10-0-1-101:~$ kubectl logs cart-ws -n candy-store > /home/cloud_user/debug/broken-pod-logs.log
cloud_user@ip-10-0-1-101:~$ vi /home/cloud_user/debug/broken-pod-logs.log
cloud_user@ip-10-0-1-101:~$ kubectl logs cart-ws -n candy-store
2020/06/23 17:46:59 [error] 6#6: *1 open() "/etc/nginx/html/ealthz" failed (2: No such file or directory), client: 10.244.1.1, server: , request: "GET /ealthz HTTP/1.1", host: "10.244.1.2:8081"
10.244.1.1 - - [23/Jun/2020:17:46:59 +0000] "GET /ealthz HTTP/1.1" 404 153 "-" "kube-probe/1.13"
2020/06/23 17:47:04 [error] 6#6: *2 open() "/etc/nginx/html/ealthz" failed (2: No such file or directory), client: 10.244.1.1, server: , request: "GET /ealthz HTTP/1.1", host: "10.244.1.2:8081"
10.244.1.1 - - [23/Jun/2020:17:47:04 +0000] "GET /ealthz HTTP/1.1" 404 153 "-" "kube-probe/1.13"
cloud_user@ip-10-0-1-101:~$ kubectl logs cart-ws -n candy-store > /home/cloud_user/debug/broken-pod-logs.log
cloud_user@ip-10-0-1-101:~$ vi /home/cloud_user/debug/broken-pod-logs.log
cloud_user@ip-10-0-1-101:~$ kubectl describe pod cart-ws -n candy-store
Name:               cart-ws
Namespace:          candy-store
Priority:           0
PriorityClassName:  <none>
Node:               ip-10-0-1-102/10.0.1.102
Start Time:         Tue, 23 Jun 2020 16:08:50 +0000
Labels:             <none>
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"cart-ws","namespace":"candy-store"},"spec":{"containers":[{"image":"l...
Status:             Running
IP:                 10.244.1.2
Containers:
  cart-ws:
    Container ID:   docker://9a0a8d137f74ed761abbcc71b61a41382f63e07f57d65d31fefe0b4fca0615a7
    Image:          linuxacademycontent/candy-service:2
    Image ID:       docker-pullable://linuxacademycontent/candy-service@sha256:614fb2c1f251a53968564f0ab22576e6af4236df8c65e19508062541a54bf4fa
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 23 Jun 2020 17:46:54 +0000
      Finished:     Tue, 23 Jun 2020 17:47:09 +0000
    Ready:          False
    Restart Count:  39
    Liveness:       http-get http://:8081/ealthz delay=5s timeout=1s period=5s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-m9ggk (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  default-token-m9ggk:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-m9ggk
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age                    From                    Message
  ----     ------     ----                   ----                    -------
  Warning  Unhealthy  25m (x91 over 99m)     kubelet, ip-10-0-1-102  Liveness probe failed: HTTP probe failed with statuscode: 404
  Warning  BackOff    4m58s (x411 over 98m)  kubelet, ip-10-0-1-102  Back-off restarting failed container
cloud_user@ip-10-0-1-101:~$ kubectl get pod cart-ws -n candy-store -o yaml --export > broken-pod.yml
cloud_user@ip-10-0-1-101:~$ vi broken-pod.yml
cloud_user@ip-10-0-1-101:~$ vi broken-pod.yml

  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-m9ggk
    secret:
      defaultMode: 420
      secretName: default-token-m9ggk
status:
  phase: Pending
  qosClass: BestEffort

>kubectl delete pod cart-ws -n candy-store

>kubectl apply -f broken-pod.yml -n candy-store

>kubectl get pod cart-ws -n candy-store
NAME      READY   STATUS    RESTARTS   AGE
cart-ws   1/1     Running   1          20s
