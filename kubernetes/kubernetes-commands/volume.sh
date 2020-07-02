-create a pod with two containers having emptyDir volume
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/volumes/pod.yaml

Last login: Wed Jul  1 18:41:23 on ttys001
[oh-my-zsh] Random theme 'Soliah' loaded
tuna on tunas-MacBook-Pro.local in ~
$ minikube start
😄  minikube v1.10.0 on Darwin 10.15.5
✨  Using the virtualbox driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🏃  Updating the running virtualbox "minikube" VM ...
🐳  Preparing Kubernetes v1.18.1 on Docker 19.03.8 ...
🌟  Enabled addons: dashboard, default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube"
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/rc.yaml
replicationcontroller/rcsise created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/svc.yaml
service/thesvc created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/jumpod.yaml
pod/jumpod created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl exec -it jumpod -c shell -- ping thesvc.default.svc.cluster.local
PING thesvc.default.svc.cluster.local (10.96.131.150) 56(84) bytes of data.
^Z^C
--- thesvc.default.svc.cluster.local ping statistics ---
55 packets transmitted, 0 received, 100% packet loss, time 55285ms

command terminated with exit code 1
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
jumpod         1/1     Running   0          5m12s
rcsise-czmgd   1/1     Running   0          5m40s
rcsise-df2nf   1/1     Running   0          5m40s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get ns
NAME                   STATUS   AGE
default                Active   50d
kube-node-lease        Active   50d
kube-public            Active   50d
kube-system            Active   50d
kubernetes-dashboard   Active   31d
my-ns                  Active   26d
nginx-ns               Active   20d
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete ns my-ns
namespace "my-ns" deleted




^C
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete pod jumpod
pod "jumpod" deleted


tuna on tunas-MacBook-Pro.local in ~
$
tuna on tunas-MacBook-Pro.local in ~
$
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
rcsise-df2nf   1/1     Running   0          7m27s
rcsise-hn5v5   1/1     Running   0          36s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete pods rcsise-df2nf rcsise-hn5v5
pod "rcsise-df2nf" deleted
pod "rcsise-hn5v5" deleted
^C
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/services/rc.yaml
replicationcontroller/rcsise configured
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/services/svc.yaml
service/simpleservice created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods -l app=sise
NAME           READY   STATUS        RESTARTS   AGE
rcsise-mkh4d   1/1     Terminating   0          41s
rcsise-wmxfd   1/1     Running       0          41s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl describe pod rcsise-6nq3k
Error from server (NotFound): pods "rcsise-6nq3k" not found
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods -l app=sise
NAME           READY   STATUS    RESTARTS   AGE
rcsise-wmxfd   1/1     Running   0          68s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl describe pod rcsise-wmxfd
Name:         rcsise-wmxfd
Namespace:    default
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Thu, 02 Jul 2020 13:07:10 +0200
Labels:       app=sise
Annotations:  <none>
Status:       Running
IP:           172.17.0.5
IPs:
  IP:           172.17.0.5
Controlled By:  ReplicationController/rcsise
Containers:
  sise:
    Container ID:   docker://65848e7891f7f830b9e5e04d2c502754701342f42c8a97a85537d60058f27b82
    Image:          quay.io/openshiftlabs/simpleservice:0.5.0
    Image ID:       docker-pullable://quay.io/openshiftlabs/simpleservice@sha256:72bfe1acc54829c306dd6683fe28089d222cf50a2df9d10c4e9d32974a591673
    Port:           9876/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 02 Jul 2020 13:07:11 +0200
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-x45wv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-x45wv:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-x45wv
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age        From               Message
  ----    ------     ----       ----               -------
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/rcsise-wmxfd to minikube
  Normal  Pulled     86s        kubelet, minikube  Container image "quay.io/openshiftlabs/simpleservice:0.5.0" already present on machine
  Normal  Created    86s        kubelet, minikube  Created container sise
  Normal  Started    86s        kubelet, minikube  Started container sise
tuna on tunas-MacBook-Pro.local in ~
$ curl 172.17.0.5:9876/info
^Z
[1]  + 6273 suspended  curl 172.17.0.5:9876/info
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get svc
NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP    50d
my-service      ClusterIP   10.102.152.99    <none>        8080/TCP   19d
simpleservice   ClusterIP   10.106.180.116   <none>        80/TCP     79s
thesvc          ClusterIP   10.96.131.150    <none>        80/TCP     9m17s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl describe svc simpleservice
Name:              simpleservice
Namespace:         default
Labels:            <none>
Annotations:       Selector:  app=sise
Type:              ClusterIP
IP:                10.106.180.116
Port:              <unset>  80/TCP
TargetPort:        9876/TCP
Endpoints:         172.17.0.5:9876
Session Affinity:  None
Events:            <none>
tuna on tunas-MacBook-Pro.local in ~
$ curl 172.17.0.5:80/info
^C
tuna on tunas-MacBook-Pro.local in ~
$ sudo iptables-save | grep simpleservice
Password:
sudo: iptables-save: command not found
tuna on tunas-MacBook-Pro.local in ~
$ sudo iptables-save | grep simpleservice
sudo: iptables-save: command not found
tuna on tunas-MacBook-Pro.local in ~
$ kubectl scale --replicas=2 rc/rcsise
replicationcontroller/rcsise scaled
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods -l app=sise
NAME           READY   STATUS    RESTARTS   AGE
rcsise-hfl8z   1/1     Running   0          7s
rcsise-wmxfd   1/1     Running   0          3m16s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete svc simpleservice
service "simpleservice" deleted
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods -l app=sise
NAME           READY   STATUS    RESTARTS   AGE
rcsise-hfl8z   1/1     Running   0          22s
rcsise-wmxfd   1/1     Running   0          3m31s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete rc rcsise
replicationcontroller "rcsise" deleted
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods -l app=sise
NAME           READY   STATUS        RESTARTS   AGE
rcsise-hfl8z   1/1     Terminating   0          30s
rcsise-wmxfd   1/1     Terminating   0          3m39s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pf/app.yaml
deployment.apps/sise-deploy created
service/simpleservice created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl port-forward service/simpleservice 8080:80
Forwarding from 127.0.0.1:8080 -> 9876
Forwarding from [::1]:8080 -> 9876
curl localhost:8080/info
Handling connection for 8080
{"host": "localhost:8080", "version": "0.5.0", "from": "127.0.0.1"}

^Z
[2]  + 6614 suspended  kubectl port-forward service/simpleservice 8080:80
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/deploy.yaml
deployment.apps/pv-deploy created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS    RESTARTS   AGE
pv-deploy-6bd44744c4-drl26   1/1     Running   0          28s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl exec -it pv-deploy-6bd44744c4-drl26 -- bash
[root@pv-deploy-6bd44744c4-drl26 /]# touch /tmp/persistent/data
[root@pv-deploy-6bd44744c4-drl26 /]# ls /tmp/persistent/
data
[root@pv-deploy-6bd44744c4-drl26 /]# ls -al /tmp/persistent/
total 4
drwxr-xr-x 2 root root   60 Jul  2 14:22 .
drwxrwxrwt 1 root root 4096 Jul  2 14:21 ..
-rw-r--r-- 1 root root    0 Jul  2 14:22 data
[root@pv-deploy-6bd44744c4-drl26 /]# kubectl delete po pv-deploy-6bd44744c4-drl26
bash: kubectl: command not found
[root@pv-deploy-6bd44744c4-drl26 /]# exit
exit
command terminated with exit code 127
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete po pv-deploy-6bd44744c4-drl26
pod "pv-deploy-6bd44744c4-drl26" deleted
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS    RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Running   0          34s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl exec -it pv-deploy-pv-deploy-6bd44744c4-xsjk9 -- bash
Error from server (NotFound): pods "pv-deploy-pv-deploy-6bd44744c4-xsjk9" not found
tuna on tunas-MacBook-Pro.local in ~
$ kubectl exec -it pv-deploy-6bd44744c4-xsjk9 -- bash
[root@pv-deploy-6bd44744c4-xsjk9 /]# ls /tmp/persistent/
data
[root@pv-deploy-6bd44744c4-xsjk9 /]# kubectl delete pvc myclaim
bash: kubectl: command not found
[root@pv-deploy-6bd44744c4-xsjk9 /]# exit
exit
command terminated with exit code 127
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete pvc myclaim
persistentvolumeclaim "myclaim" deleted
^Z
[3]  + 11691 suspended  kubectl delete pvc myclaim
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS    RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Running   0          3m9s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get deploy
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
pv-deploy   1/1     1            1           6m1s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete deploy pv-deploy
deployment.apps "pv-deploy" deleted
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m32s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m46s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m48s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m52s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m53s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m55s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Terminating   0          3m56s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                         READY   STATUS        RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   0/1     Terminating   0          4m
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                  READY   STATUS              RESTARTS   AGE
recycler-for-pv0001   0/1     ContainerCreating   0          0s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                  READY   STATUS              RESTARTS   AGE
recycler-for-pv0001   0/1     ContainerCreating   0          2s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
NAME                  READY   STATUS              RESTARTS   AGE
recycler-for-pv0001   0/1     ContainerCreating   0          3s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
No resources found in default namespace.
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
No resources found in default namespace.
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
No resources found in default namespace.
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get po
No resources found in default namespace.
tuna on tunas-MacBook-Pro.local in ~
$ echo -n "A19fh68B001j" > ./apikey.txt
tuna on tunas-MacBook-Pro.local in ~
$ kubectl create secret generic apikey --from-file=./apikey.txt
secret/apikey created
tuna on tunas-MacBook-Pro.local in ~
$ kubectl describe secrets/apikey
Name:         apikey
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
apikey.txt:  12 bytes
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/secrets/pod.yaml
pod/consumesec created
tuna on tunas-MacBook-Pro.local in ~
$ vi  https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/secrets/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ kubectl exec -it consumesec -c shell -- bash
[root@consumesec /]# mount | grep apikey
tmpfs on /tmp/apikey type tmpfs (ro,relatime)
[root@consumesec /]# cat /tmp/apikey/apikey.txt
A19fh68B001j[root@consumesec /]# kubectl delete pod/consumesec secret/apikey
bash: kubectl: command not found
[root@consumesec /]# exit
exit
command terminated with exit code 127
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete pod/consumesec secret/apikey
pod "consumesec" deleted
secret "apikey" deleted
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/pod.yaml
pod/logme created
tuna on tunas-MacBook-Pro.local in ~
$ vi  https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
logme   1/1     Running   0          42s
tuna on tunas-MacBook-Pro.local in ~
$ kubectl logs --tail=5 logme -c gen
Thu Jul 2 15:02:13 UTC 2020
Thu Jul 2 15:02:14 UTC 2020
Thu Jul 2 15:02:14 UTC 2020
Thu Jul 2 15:02:15 UTC 2020
Thu Jul 2 15:02:15 UTC 2020
tuna on tunas-MacBook-Pro.local in ~
$ kubectl logs -f --since=10s logme -c gen
Thu Jul 2 15:03:10 UTC 2020
Thu Jul 2 15:03:10 UTC 2020
Thu Jul 2 15:03:11 UTC 2020
Thu Jul 2 15:03:11 UTC 2020
Thu Jul 2 15:03:12 UTC 2020
Thu Jul 2 15:03:12 UTC 2020
Thu Jul 2 15:03:13 UTC 2020
Thu Jul 2 15:03:13 UTC 2020
Thu Jul 2 15:03:14 UTC 2020
Thu Jul 2 15:03:14 UTC 2020
Thu Jul 2 15:03:15 UTC 2020
Thu Jul 2 15:03:15 UTC 2020
Thu Jul 2 15:03:16 UTC 2020
Thu Jul 2 15:03:16 UTC 2020
Thu Jul 2 15:03:17 UTC 2020
Thu Jul 2 15:03:17 UTC 2020
Thu Jul 2 15:03:18 UTC 2020
Thu Jul 2 15:03:18 UTC 2020
Thu Jul 2 15:03:19 UTC 2020
Thu Jul 2 15:03:19 UTC 2020
Thu Jul 2 15:03:20 UTC 2020
Thu Jul 2 15:03:20 UTC 2020
Thu Jul 2 15:03:21 UTC 2020
Thu Jul 2 15:03:21 UTC 2020
Thu Jul 2 15:03:22 UTC 2020
Thu Jul 2 15:03:22 UTC 2020
Thu Jul 2 15:03:23 UTC 2020
Thu Jul 2 15:03:23 UTC 2020
Thu Jul 2 15:03:24 UTC 2020
Thu Jul 2 15:03:24 UTC 2020
Thu Jul 2 15:03:25 UTC 2020
Thu Jul 2 15:03:25 UTC 2020
Thu Jul 2 15:03:26 UTC 2020
Thu Jul 2 15:03:26 UTC 2020
Thu Jul 2 15:03:27 UTC 2020
Thu Jul 2 15:03:27 UTC 2020
Thu Jul 2 15:03:28 UTC 2020
Thu Jul 2 15:03:28 UTC 2020
Thu Jul 2 15:03:29 UTC 2020
Thu Jul 2 15:03:29 UTC 2020
Thu Jul 2 15:03:30 UTC 2020
Thu Jul 2 15:03:30 UTC 2020
Thu Jul 2 15:03:31 UTC 2020
Thu Jul 2 15:03:31 UTC 2020
Thu Jul 2 15:03:32 UTC 2020
Thu Jul 2 15:03:32 UTC 2020
Thu Jul 2 15:03:33 UTC 2020
Thu Jul 2 15:03:33 UTC 2020
Thu Jul 2 15:03:34 UTC 2020
Thu Jul 2 15:03:34 UTC 2020
Thu Jul 2 15:03:35 UTC 2020
Thu Jul 2 15:03:35 UTC 2020
Thu Jul 2 15:03:36 UTC 2020
Thu Jul 2 15:03:36 UTC 2020
Thu Jul 2 15:03:37 UTC 2020
Thu Jul 2 15:03:37 UTC 2020
Thu Jul 2 15:03:38 UTC 2020
Thu Jul 2 15:03:38 UTC 2020
Thu Jul 2 15:03:39 UTC 2020
Thu Jul 2 15:03:39 UTC 2020
Thu Jul 2 15:03:40 UTC 2020
Thu Jul 2 15:03:40 UTC 2020
Thu Jul 2 15:03:41 UTC 2020
Thu Jul 2 15:03:41 UTC 2020
Thu Jul 2 15:03:42 UTC 2020
Thu Jul 2 15:03:42 UTC 2020
Thu Jul 2 15:03:43 UTC 2020
Thu Jul 2 15:03:43 UTC 2020
Thu Jul 2 15:03:44 UTC 2020
Thu Jul 2 15:03:44 UTC 2020
Thu Jul 2 15:03:45 UTC 2020
Thu Jul 2 15:03:45 UTC 2020
Thu Jul 2 15:03:46 UTC 2020
Thu Jul 2 15:03:46 UTC 2020
^Z
[4]  + 12299 suspended  kubectl logs -f --since=10s logme -c gen
tuna on tunas-MacBook-Pro.local in ~
$ kubectl logs -f logme -c gen
Thu Jul 2 15:01:02 UTC 2020
Thu Jul 2 15:01:02 UTC 2020
Thu Jul 2 15:01:03 UTC 2020
Thu Jul 2 15:01:03 UTC 2020
Thu Jul 2 15:01:04 UTC 2020
Thu Jul 2 15:01:04 UTC 2020
Thu Jul 2 15:01:05 UTC 2020
Thu Jul 2 15:01:05 UTC 2020
Thu Jul 2 15:01:06 UTC 2020
Thu Jul 2 15:01:06 UTC 2020
Thu Jul 2 15:01:07 UTC 2020
Thu Jul 2 15:01:07 UTC 2020
Thu Jul 2 15:01:08 UTC 2020
Thu Jul 2 15:01:08 UTC 2020
Thu Jul 2 15:01:09 UTC 2020
Thu Jul 2 15:01:09 UTC 2020
Thu Jul 2 15:01:10 UTC 2020
Thu Jul 2 15:01:10 UTC 2020
Thu Jul 2 15:01:11 UTC 2020
Thu Jul 2 15:01:11 UTC 2020
Thu Jul 2 15:01:12 UTC 2020
Thu Jul 2 15:01:12 UTC 2020
Thu Jul 2 15:01:13 UTC 2020
Thu Jul 2 15:01:13 UTC 2020
Thu Jul 2 15:01:14 UTC 2020
Thu Jul 2 15:01:14 UTC 2020
Thu Jul 2 15:01:15 UTC 2020
Thu Jul 2 15:01:15 UTC 2020
Thu Jul 2 15:01:16 UTC 2020
Thu Jul 2 15:01:16 UTC 2020
Thu Jul 2 15:01:17 UTC 2020
Thu Jul 2 15:01:17 UTC 2020
Thu Jul 2 15:01:18 UTC 2020
Thu Jul 2 15:01:18 UTC 2020
Thu Jul 2 15:01:19 UTC 2020
Thu Jul 2 15:01:19 UTC 2020
Thu Jul 2 15:01:20 UTC 2020
Thu Jul 2 15:01:20 UTC 2020
Thu Jul 2 15:01:21 UTC 2020
Thu Jul 2 15:01:21 UTC 2020
Thu Jul 2 15:01:22 UTC 2020
Thu Jul 2 15:01:22 UTC 2020
Thu Jul 2 15:01:23 UTC 2020
Thu Jul 2 15:01:23 UTC 2020
Thu Jul 2 15:01:24 UTC 2020
Thu Jul 2 15:01:24 UTC 2020
Thu Jul 2 15:01:25 UTC 2020
Thu Jul 2 15:01:25 UTC 2020
Thu Jul 2 15:01:26 UTC 2020
Thu Jul 2 15:01:26 UTC 2020
Thu Jul 2 15:01:27 UTC 2020
Thu Jul 2 15:01:27 UTC 2020
Thu Jul 2 15:01:28 UTC 2020
Thu Jul 2 15:01:28 UTC 2020
Thu Jul 2 15:01:29 UTC 2020
Thu Jul 2 15:01:29 UTC 2020
Thu Jul 2 15:01:30 UTC 2020
Thu Jul 2 15:01:30 UTC 2020
Thu Jul 2 15:01:31 UTC 2020
Thu Jul 2 15:01:31 UTC 2020
Thu Jul 2 15:01:32 UTC 2020
Thu Jul 2 15:01:32 UTC 2020
Thu Jul 2 15:01:33 UTC 2020
Thu Jul 2 15:01:33 UTC 2020
Thu Jul 2 15:01:34 UTC 2020
Thu Jul 2 15:01:34 UTC 2020
Thu Jul 2 15:01:35 UTC 2020
Thu Jul 2 15:01:35 UTC 2020
Thu Jul 2 15:01:36 UTC 2020
Thu Jul 2 15:01:36 UTC 2020
Thu Jul 2 15:01:37 UTC 2020
Thu Jul 2 15:01:37 UTC 2020
Thu Jul 2 15:01:38 UTC 2020
Thu Jul 2 15:01:38 UTC 2020
Thu Jul 2 15:01:39 UTC 2020
Thu Jul 2 15:01:39 UTC 2020
Thu Jul 2 15:01:40 UTC 2020
Thu Jul 2 15:01:40 UTC 2020
Thu Jul 2 15:01:41 UTC 2020
Thu Jul 2 15:01:41 UTC 2020
Thu Jul 2 15:01:42 UTC 2020
Thu Jul 2 15:01:42 UTC 2020
Thu Jul 2 15:01:43 UTC 2020
Thu Jul 2 15:01:43 UTC 2020
Thu Jul 2 15:01:44 UTC 2020
Thu Jul 2 15:01:44 UTC 2020
Thu Jul 2 15:01:45 UTC 2020
Thu Jul 2 15:01:45 UTC 2020
Thu Jul 2 15:01:46 UTC 2020
Thu Jul 2 15:01:46 UTC 2020
Thu Jul 2 15:01:47 UTC 2020
Thu Jul 2 15:01:47 UTC 2020
Thu Jul 2 15:01:48 UTC 2020
Thu Jul 2 15:01:48 UTC 2020
Thu Jul 2 15:01:49 UTC 2020
Thu Jul 2 15:01:49 UTC 2020
Thu Jul 2 15:01:50 UTC 2020
Thu Jul 2 15:01:50 UTC 2020
Thu Jul 2 15:01:51 UTC 2020
Thu Jul 2 15:01:51 UTC 2020
Thu Jul 2 15:01:52 UTC 2020
Thu Jul 2 15:01:52 UTC 2020
Thu Jul 2 15:01:53 UTC 2020
Thu Jul 2 15:01:53 UTC 2020
Thu Jul 2 15:01:54 UTC 2020
Thu Jul 2 15:01:54 UTC 2020
Thu Jul 2 15:01:55 UTC 2020
Thu Jul 2 15:01:55 UTC 2020
Thu Jul 2 15:01:56 UTC 2020
Thu Jul 2 15:01:56 UTC 2020
Thu Jul 2 15:01:57 UTC 2020
Thu Jul 2 15:01:57 UTC 2020
Thu Jul 2 15:01:58 UTC 2020
Thu Jul 2 15:01:58 UTC 2020
Thu Jul 2 15:01:59 UTC 2020
Thu Jul 2 15:01:59 UTC 2020
Thu Jul 2 15:02:00 UTC 2020
Thu Jul 2 15:02:00 UTC 2020
Thu Jul 2 15:02:01 UTC 2020
Thu Jul 2 15:02:01 UTC 2020
Thu Jul 2 15:02:02 UTC 2020
Thu Jul 2 15:02:02 UTC 2020
Thu Jul 2 15:02:03 UTC 2020
Thu Jul 2 15:02:03 UTC 2020
Thu Jul 2 15:02:04 UTC 2020
Thu Jul 2 15:02:04 UTC 2020
Thu Jul 2 15:02:05 UTC 2020
Thu Jul 2 15:02:05 UTC 2020
Thu Jul 2 15:02:06 UTC 2020
Thu Jul 2 15:02:06 UTC 2020
Thu Jul 2 15:02:07 UTC 2020
Thu Jul 2 15:02:07 UTC 2020
Thu Jul 2 15:02:08 UTC 2020
Thu Jul 2 15:02:08 UTC 2020
Thu Jul 2 15:02:09 UTC 2020
Thu Jul 2 15:02:09 UTC 2020
Thu Jul 2 15:02:10 UTC 2020
Thu Jul 2 15:02:10 UTC 2020
Thu Jul 2 15:02:11 UTC 2020
Thu Jul 2 15:02:11 UTC 2020
Thu Jul 2 15:02:12 UTC 2020
Thu Jul 2 15:02:12 UTC 2020
Thu Jul 2 15:02:13 UTC 2020
Thu Jul 2 15:02:13 UTC 2020
Thu Jul 2 15:02:14 UTC 2020
Thu Jul 2 15:02:14 UTC 2020
Thu Jul 2 15:02:15 UTC 2020
Thu Jul 2 15:02:15 UTC 2020
Thu Jul 2 15:02:16 UTC 2020
Thu Jul 2 15:02:16 UTC 2020
Thu Jul 2 15:02:17 UTC 2020
Thu Jul 2 15:02:17 UTC 2020
Thu Jul 2 15:02:18 UTC 2020
Thu Jul 2 15:02:18 UTC 2020
Thu Jul 2 15:02:19 UTC 2020
Thu Jul 2 15:02:19 UTC 2020
Thu Jul 2 15:02:20 UTC 2020
Thu Jul 2 15:02:20 UTC 2020
Thu Jul 2 15:02:21 UTC 2020
Thu Jul 2 15:02:21 UTC 2020
Thu Jul 2 15:02:22 UTC 2020
Thu Jul 2 15:02:22 UTC 2020
Thu Jul 2 15:02:23 UTC 2020
Thu Jul 2 15:02:23 UTC 2020
Thu Jul 2 15:02:24 UTC 2020
Thu Jul 2 15:02:24 UTC 2020
Thu Jul 2 15:02:25 UTC 2020
Thu Jul 2 15:02:25 UTC 2020
Thu Jul 2 15:02:26 UTC 2020
Thu Jul 2 15:02:26 UTC 2020
Thu Jul 2 15:02:27 UTC 2020
Thu Jul 2 15:02:27 UTC 2020
Thu Jul 2 15:02:28 UTC 2020
Thu Jul 2 15:02:28 UTC 2020
Thu Jul 2 15:02:29 UTC 2020
Thu Jul 2 15:02:29 UTC 2020
Thu Jul 2 15:02:30 UTC 2020
Thu Jul 2 15:02:30 UTC 2020
Thu Jul 2 15:02:31 UTC 2020
Thu Jul 2 15:02:31 UTC 2020
Thu Jul 2 15:02:32 UTC 2020
Thu Jul 2 15:02:32 UTC 2020
Thu Jul 2 15:02:33 UTC 2020
Thu Jul 2 15:02:33 UTC 2020
Thu Jul 2 15:02:34 UTC 2020
Thu Jul 2 15:02:34 UTC 2020
Thu Jul 2 15:02:35 UTC 2020
Thu Jul 2 15:02:35 UTC 2020
Thu Jul 2 15:02:36 UTC 2020
Thu Jul 2 15:02:36 UTC 2020
Thu Jul 2 15:02:37 UTC 2020
Thu Jul 2 15:02:37 UTC 2020
Thu Jul 2 15:02:38 UTC 2020
Thu Jul 2 15:02:38 UTC 2020
Thu Jul 2 15:02:39 UTC 2020
Thu Jul 2 15:02:39 UTC 2020
Thu Jul 2 15:02:40 UTC 2020
Thu Jul 2 15:02:40 UTC 2020
Thu Jul 2 15:02:41 UTC 2020
Thu Jul 2 15:02:41 UTC 2020
Thu Jul 2 15:02:42 UTC 2020
Thu Jul 2 15:02:42 UTC 2020
Thu Jul 2 15:02:43 UTC 2020
Thu Jul 2 15:02:43 UTC 2020
Thu Jul 2 15:02:44 UTC 2020
Thu Jul 2 15:02:44 UTC 2020
Thu Jul 2 15:02:45 UTC 2020
Thu Jul 2 15:02:45 UTC 2020
Thu Jul 2 15:02:46 UTC 2020
Thu Jul 2 15:02:46 UTC 2020
Thu Jul 2 15:02:47 UTC 2020
Thu Jul 2 15:02:47 UTC 2020
Thu Jul 2 15:02:48 UTC 2020
Thu Jul 2 15:02:48 UTC 2020
Thu Jul 2 15:02:49 UTC 2020
Thu Jul 2 15:02:49 UTC 2020
Thu Jul 2 15:02:50 UTC 2020
Thu Jul 2 15:02:50 UTC 2020
Thu Jul 2 15:02:51 UTC 2020
Thu Jul 2 15:02:51 UTC 2020
Thu Jul 2 15:02:52 UTC 2020
Thu Jul 2 15:02:52 UTC 2020
Thu Jul 2 15:02:53 UTC 2020
Thu Jul 2 15:02:53 UTC 2020
Thu Jul 2 15:02:54 UTC 2020
Thu Jul 2 15:02:54 UTC 2020
Thu Jul 2 15:02:55 UTC 2020
Thu Jul 2 15:02:55 UTC 2020
Thu Jul 2 15:02:56 UTC 2020
Thu Jul 2 15:02:56 UTC 2020
Thu Jul 2 15:02:57 UTC 2020
Thu Jul 2 15:02:57 UTC 2020
Thu Jul 2 15:02:58 UTC 2020
Thu Jul 2 15:02:58 UTC 2020
Thu Jul 2 15:02:59 UTC 2020
Thu Jul 2 15:02:59 UTC 2020
Thu Jul 2 15:03:00 UTC 2020
Thu Jul 2 15:03:00 UTC 2020
Thu Jul 2 15:03:01 UTC 2020
Thu Jul 2 15:03:01 UTC 2020
Thu Jul 2 15:03:02 UTC 2020
Thu Jul 2 15:03:02 UTC 2020
Thu Jul 2 15:03:03 UTC 2020
Thu Jul 2 15:03:03 UTC 2020
Thu Jul 2 15:03:04 UTC 2020
Thu Jul 2 15:03:04 UTC 2020
Thu Jul 2 15:03:05 UTC 2020
Thu Jul 2 15:03:05 UTC 2020
Thu Jul 2 15:03:06 UTC 2020
Thu Jul 2 15:03:06 UTC 2020
Thu Jul 2 15:03:07 UTC 2020
Thu Jul 2 15:03:07 UTC 2020
Thu Jul 2 15:03:08 UTC 2020
Thu Jul 2 15:03:08 UTC 2020
Thu Jul 2 15:03:09 UTC 2020
Thu Jul 2 15:03:09 UTC 2020
Thu Jul 2 15:03:10 UTC 2020
Thu Jul 2 15:03:10 UTC 2020
Thu Jul 2 15:03:11 UTC 2020
Thu Jul 2 15:03:11 UTC 2020
Thu Jul 2 15:03:12 UTC 2020
Thu Jul 2 15:03:12 UTC 2020
Thu Jul 2 15:03:13 UTC 2020
Thu Jul 2 15:03:13 UTC 2020
Thu Jul 2 15:03:14 UTC 2020
Thu Jul 2 15:03:14 UTC 2020
Thu Jul 2 15:03:15 UTC 2020
Thu Jul 2 15:03:15 UTC 2020
Thu Jul 2 15:03:16 UTC 2020
Thu Jul 2 15:03:16 UTC 2020
Thu Jul 2 15:03:17 UTC 2020
Thu Jul 2 15:03:17 UTC 2020
Thu Jul 2 15:03:18 UTC 2020
Thu Jul 2 15:03:18 UTC 2020
Thu Jul 2 15:03:19 UTC 2020
Thu Jul 2 15:03:19 UTC 2020
Thu Jul 2 15:03:20 UTC 2020
Thu Jul 2 15:03:20 UTC 2020
Thu Jul 2 15:03:21 UTC 2020
Thu Jul 2 15:03:21 UTC 2020
Thu Jul 2 15:03:22 UTC 2020
Thu Jul 2 15:03:22 UTC 2020
Thu Jul 2 15:03:23 UTC 2020
Thu Jul 2 15:03:23 UTC 2020
Thu Jul 2 15:03:24 UTC 2020
Thu Jul 2 15:03:24 UTC 2020
Thu Jul 2 15:03:25 UTC 2020
Thu Jul 2 15:03:25 UTC 2020
Thu Jul 2 15:03:26 UTC 2020
Thu Jul 2 15:03:26 UTC 2020
Thu Jul 2 15:03:27 UTC 2020
Thu Jul 2 15:03:27 UTC 2020
Thu Jul 2 15:03:28 UTC 2020
Thu Jul 2 15:03:28 UTC 2020
Thu Jul 2 15:03:29 UTC 2020
Thu Jul 2 15:03:29 UTC 2020
Thu Jul 2 15:03:30 UTC 2020
Thu Jul 2 15:03:30 UTC 2020
Thu Jul 2 15:03:31 UTC 2020
Thu Jul 2 15:03:31 UTC 2020
Thu Jul 2 15:03:32 UTC 2020
Thu Jul 2 15:03:32 UTC 2020
Thu Jul 2 15:03:33 UTC 2020
Thu Jul 2 15:03:33 UTC 2020
Thu Jul 2 15:03:34 UTC 2020
Thu Jul 2 15:03:34 UTC 2020
Thu Jul 2 15:03:35 UTC 2020
Thu Jul 2 15:03:35 UTC 2020
Thu Jul 2 15:03:36 UTC 2020
Thu Jul 2 15:03:36 UTC 2020
Thu Jul 2 15:03:37 UTC 2020
Thu Jul 2 15:03:37 UTC 2020
Thu Jul 2 15:03:38 UTC 2020
Thu Jul 2 15:03:38 UTC 2020
Thu Jul 2 15:03:39 UTC 2020
Thu Jul 2 15:03:39 UTC 2020
Thu Jul 2 15:03:40 UTC 2020
Thu Jul 2 15:03:40 UTC 2020
Thu Jul 2 15:03:41 UTC 2020
Thu Jul 2 15:03:41 UTC 2020
Thu Jul 2 15:03:42 UTC 2020
Thu Jul 2 15:03:42 UTC 2020
Thu Jul 2 15:03:43 UTC 2020
Thu Jul 2 15:03:43 UTC 2020
Thu Jul 2 15:03:44 UTC 2020
Thu Jul 2 15:03:44 UTC 2020
Thu Jul 2 15:03:45 UTC 2020
Thu Jul 2 15:03:45 UTC 2020
Thu Jul 2 15:03:46 UTC 2020
Thu Jul 2 15:03:46 UTC 2020
Thu Jul 2 15:03:47 UTC 2020
Thu Jul 2 15:03:47 UTC 2020
Thu Jul 2 15:03:48 UTC 2020
Thu Jul 2 15:03:48 UTC 2020
Thu Jul 2 15:03:50 UTC 2020
Thu Jul 2 15:03:50 UTC 2020
Thu Jul 2 15:03:51 UTC 2020
Thu Jul 2 15:03:51 UTC 2020
Thu Jul 2 15:03:52 UTC 2020
Thu Jul 2 15:03:52 UTC 2020
Thu Jul 2 15:03:53 UTC 2020
Thu Jul 2 15:03:53 UTC 2020
Thu Jul 2 15:03:54 UTC 2020
Thu Jul 2 15:03:54 UTC 2020
Thu Jul 2 15:03:55 UTC 2020
Thu Jul 2 15:03:55 UTC 2020
Thu Jul 2 15:03:56 UTC 2020
Thu Jul 2 15:03:56 UTC 2020
Thu Jul 2 15:03:57 UTC 2020
Thu Jul 2 15:03:57 UTC 2020
Thu Jul 2 15:03:58 UTC 2020
Thu Jul 2 15:03:58 UTC 2020
Thu Jul 2 15:03:59 UTC 2020
Thu Jul 2 15:03:59 UTC 2020
Thu Jul 2 15:04:00 UTC 2020
Thu Jul 2 15:04:00 UTC 2020
Thu Jul 2 15:04:01 UTC 2020
Thu Jul 2 15:04:01 UTC 2020
Thu Jul 2 15:04:02 UTC 2020
Thu Jul 2 15:04:02 UTC 2020
Thu Jul 2 15:04:03 UTC 2020
Thu Jul 2 15:04:03 UTC 2020
Thu Jul 2 15:04:04 UTC 2020
Thu Jul 2 15:04:04 UTC 2020
Thu Jul 2 15:04:05 UTC 2020
Thu Jul 2 15:04:05 UTC 2020
Thu Jul 2 15:04:06 UTC 2020
Thu Jul 2 15:04:06 UTC 2020
Thu Jul 2 15:04:07 UTC 2020
Thu Jul 2 15:04:07 UTC 2020
Thu Jul 2 15:04:08 UTC 2020
Thu Jul 2 15:04:08 UTC 2020
Thu Jul 2 15:04:09 UTC 2020
Thu Jul 2 15:04:09 UTC 2020
Thu Jul 2 15:04:10 UTC 2020
Thu Jul 2 15:04:10 UTC 2020
Thu Jul 2 15:04:11 UTC 2020
Thu Jul 2 15:04:11 UTC 2020
Thu Jul 2 15:04:12 UTC 2020
Thu Jul 2 15:04:12 UTC 2020
Thu Jul 2 15:04:13 UTC 2020
Thu Jul 2 15:04:13 UTC 2020
Thu Jul 2 15:04:14 UTC 2020
Thu Jul 2 15:04:14 UTC 2020
Thu Jul 2 15:04:15 UTC 2020
Thu Jul 2 15:04:15 UTC 2020
Thu Jul 2 15:04:16 UTC 2020
Thu Jul 2 15:04:16 UTC 2020
Thu Jul 2 15:04:17 UTC 2020
Thu Jul 2 15:04:17 UTC 2020
qThu Jul 2 15:04:18 UTC 2020
Thu Jul 2 15:04:18 UTC 2020
^R
^Z
[5]  + 12311 suspended  kubectl logs -f logme -c gen
tuna on tunas-MacBook-Pro.local in ~
$ kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/oneshotpod.yaml
pod/oneshot created
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/oneshotpod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ kubectl logs -p oneshot -c gen
unable to retrieve container logs for docker://16e4d9629d3cdce9738b2af579a4dfe04eb7810c9c37e4902f8e440898d97f9c%                                                                                  tuna on tunas-MacBook-Pro.local in ~
$ kubectl logs -p oneshot -c gen
unable to retrieve container logs for docker://16e4d9629d3cdce9738b2af579a4dfe04eb7810c9c37e4902f8e440898d97f9c%                                                                                  tuna on tunas-MacBook-Pro.local in ~
$ kubectl logs -p oneshot -c gen
9
8
7
6
5
4
3
2
1
tuna on tunas-MacBook-Pro.local in ~
$ kubectl delete pod/logme pod/oneshot
pod "logme" deleted
pod "oneshot" deleted
tuna on tunas-MacBook-Pro.local in ~
$ vi

tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/deployments/d09.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/deployments/d10.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/envs/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/healthz/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/healthz/badpod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/healthz/ready.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/labels/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/labels/anotherpod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ns/ns.yaml
zsh: no such file or directory: https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ns/ns.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ns/ns.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ns/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/pv.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/pvc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/deploy.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pods/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pods/constraint-pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pf/app.yaml
tuna on tunas-MacBook-Pro.local in ~
$ clear

tuna on tunas-MacBook-Pro.local in ~
$ https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pf/app.yaml
zsh: no such file or directory: https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pf/app.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pf/app.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/secrets/pod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/rc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/svc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/jumpod.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-ns.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-rc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-svc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/services/rc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/services/svc.yaml
tuna on tunas-MacBook-Pro.local in ~
$ vi https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/volumes/pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: sharevol
spec:
  containers:
  - name: c1
    image: centos:7
    command:
      - "bin/bash"
      - "-c"
      - "sleep 10000"
    volumeMounts:
      - name: xchange
        mountPath: "/tmp/xchange"
  - name: c2
    image: centos:7
    command:
      - "bin/bash"
      - "-c"
      - "sleep 10000"
    volumeMounts:
      - name: xchange

-describe pod
kubectl describe pod sharevol
Name:         sharevol
Namespace:    default
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Thu, 02 Jul 2020 15:31:42 +0200
Labels:       <none>
Annotations:  Status:  Running
IP:           172.17.0.2
IPs:
  IP:  172.17.0.2
Containers:
  c1:
    Container ID:  docker://6205c604b5c8ab6ad699cdb013a3e0f37bc609657758b1d926694031de7695e6
    Image:         centos:7
    Image ID:      docker-pullable://centos@sha256:e9ce0b76f29f942502facd849f3e468232492b259b9d9f076f71b392293f1582
    Port:          <none>
    Host Port:     <none>
    Command:
      bin/bash
      -c
      sleep 10000
    State:          Running
      Started:      Thu, 02 Jul 2020 15:31:43 +0200
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /tmp/xchange from xchange (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-x45wv (ro)
  c2:
    Container ID:  docker://4e96440e52145b1daa1ec7d40893b5a8f26f0d4158b57bf316ddbb0ad4f82a34
    Image:         centos:7
    Image ID:      docker-pullable://centos@sha256:e9ce0b76f29f942502facd849f3e468232492b259b9d9f076f71b392293f1582
    Port:          <none>
    Host Port:     <none>
    Command:
      bin/bash
      -c
      sleep 10000
    State:          Running
      Started:      Thu, 02 Jul 2020 15:31:43 +0200
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /tmp/data from xchange (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-x45wv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  xchange:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  default-token-x45wv:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-x45wv
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age        From               Message
  ----    ------     ----       ----               -------
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/sharevol to minikube
  Normal  Pulled     12s        kubelet, minikube  Container image "centos:7" already present on machine
  Normal  Created    12s        kubelet, minikube  Created container c1
  Normal  Started    12s        kubelet, minikube  Started container c1
  Normal  Pulled     12s        kubelet, minikube  Container image "centos:7" already present on machine
  Normal  Created    12s        kubelet, minikube  Created container c2
  Normal  Started    12s        kubelet, minikube  Started container c2

-get pods
NAME       READY   STATUS    RESTARTS   AGE
sharevol   2/2     Running   0          65s

-exec in container c1 and check volume mount and generate some data
kubectl exec -it sharevol -c c1 -- bash
[root@sharevol /]# mount | grep xchange
/dev/sda1 on /tmp/xchange type ext4 (rw,relatime)
[root@sharevol /]# echo 'some data' > /tmp/xchange/data

--exec in container c2 and check volume mount and generate some data
kubectl exec -it sharevol -c c2 -- bash
[root@sharevol /]# mount | grep /tmp/data
/dev/sda1 on /tmp/data type ext4 (rw,relatime)
[root@sharevol /]# cat /tmp/data/data
some data

-delete pod
kubectl delete pod/sharevol
