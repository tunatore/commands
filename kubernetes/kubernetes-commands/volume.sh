-create a pod with two containers having emptyDir volume
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/volumes/pod.yaml

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
