-get nodes
kubectl get nodes
NAME       STATUS   ROLES    AGE   VERSION
minikube   Ready    master   51d   v1.18.1

-label the node
kubectl label nodes minikube shouldrun=here

-add pod to the labeled node
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/nodes/pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: onspecificnode
spec:
  containers:
  - name: sise
    image: quay.io/openshiftlabs/simpleservice:0.5.0
    ports:
    - containerPort: 9876
  nodeSelector:
    shouldrun: here

-get pods
NAME                        READY   STATUS    RESTARTS   AGE    IP           NODE       NOMINATED NODE   READINESS GATES
ic-deploy-5fbc98df8-77prr   1/1     Running   0          7m8s   172.17.0.4   minikube   <none>           <none>
mehdb-0                     1/1     Running   0          51m    172.17.0.2   minikube   <none>           <none>
mehdb-1                     1/1     Running   0          49m    172.17.0.3   minikube   <none>           <none>

-describe node
kubectl describe node

Name:               minikube
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=minikube
                    kubernetes.io/os=linux
                    minikube.k8s.io/commit=f318680e7e5bf539f7fadeaaf198f4e468393fb9
                    minikube.k8s.io/name=minikube
                    minikube.k8s.io/updated_at=2020_05_12T20_20_10_0700
                    minikube.k8s.io/version=v1.10.0
                    node-role.kubernetes.io/master=
                    shouldrun=here
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 12 May 2020 20:20:07 +0200
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  minikube
  AcquireTime:     <unset>
  RenewTime:       Thu, 02 Jul 2020 20:50:58 +0200
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Thu, 02 Jul 2020 20:50:06 +0200   Tue, 12 May 2020 20:20:03 +0200   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Thu, 02 Jul 2020 20:50:06 +0200   Tue, 12 May 2020 20:20:03 +0200   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Thu, 02 Jul 2020 20:50:06 +0200   Tue, 12 May 2020 20:20:03 +0200   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Thu, 02 Jul 2020 20:50:06 +0200   Tue, 12 May 2020 20:20:21 +0200   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.168.99.100
  Hostname:    minikube
Capacity:
  cpu:                2
  ephemeral-storage:  17784752Ki
  hugepages-2Mi:      0
  memory:             3936856Ki
  pods:               110
Allocatable:
  cpu:                2
  ephemeral-storage:  17784752Ki
  hugepages-2Mi:      0
  memory:             3936856Ki
  pods:               110
System Info:
  Machine ID:
  System UUID:
  Boot ID:
  Kernel Version:             4.19.107
  OS Image:                   Buildroot 2019.02.10
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  docker://19.3.8
  Kubelet Version:            v1.18.1
  Kube-Proxy Version:         v1.18.1
Non-terminated Pods:          (14 in total)
  Namespace                   Name                                          CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                   ----                                          ------------  ----------  ---------------  -------------  ---
  default                     ic-deploy-5fbc98df8-77prr                     0 (0%)        0 (0%)      0 (0%)           0 (0%)         8m28s
  default                     mehdb-0                                       0 (0%)        0 (0%)      0 (0%)           0 (0%)         52m
  default                     mehdb-1                                       0 (0%)        0 (0%)      0 (0%)           0 (0%)         51m
  kube-system                 coredns-66bff467f8-94pcf                      100m (5%)     0 (0%)      70Mi (1%)        170Mi (4%)     51d
  kube-system                 coredns-66bff467f8-j7g9t                      100m (5%)     0 (0%)      70Mi (1%)        170Mi (4%)     51d
  kube-system                 etcd-minikube                                 0 (0%)        0 (0%)      0 (0%)           0 (0%)         51d
  kube-system                 kube-apiserver-minikube                       250m (12%)    0 (0%)      0 (0%)           0 (0%)         51d
  kube-system                 kube-controller-manager-minikube              200m (10%)    0 (0%)      0 (0%)           0 (0%)         51d
  kube-system                 kube-proxy-ntds7                              0 (0%)        0 (0%)      0 (0%)           0 (0%)         51d
  kube-system                 kube-scheduler-minikube                       100m (5%)     0 (0%)      0 (0%)           0 (0%)         51d
  kube-system                 storage-provisioner                           0 (0%)        0 (0%)      0 (0%)           0 (0%)         51d
  kubernetes-dashboard        dashboard-metrics-scraper-84bfdf55ff-mrjkv    0 (0%)        0 (0%)      0 (0%)           0 (0%)         32d
  kubernetes-dashboard        kubernetes-dashboard-696dbcc666-75mqp         0 (0%)        0 (0%)      0 (0%)           0 (0%)         32d
  nginx-ns                    nginx                                         0 (0%)        0 (0%)      0 (0%)           0 (0%)         21d
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                750m (37%)  0 (0%)
  memory             140Mi (3%)  340Mi (8%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:              <none>
