-create a pod exposing an endpoint /health and responding 200 having livenessProbe
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/healthz/pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: hc
spec:
  containers:
  - name: sise
    image: quay.io/openshiftlabs/simpleservice:0.5.0
    ports:
    - containerPort: 9876
    livenessProbe:
      initialDelaySeconds: 2
      periodSeconds: 5
      httpGet:
        path: /health
        port: 9876

-get pods
NAME   READY   STATUS    RESTARTS   AGE
hc     1/1     Running   0          5s

-describe pod
kubectl describe pod hc
Name:         hc
Namespace:    default
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Thu, 02 Jul 2020 13:54:35 +0200
Labels:       <none>
Annotations:  Status:  Running
IP:           172.17.0.2
IPs:
  IP:  172.17.0.2
Containers:
  sise:
    Container ID:   docker://15a8b6b6e0d7fa68e98ae432f115c103385432d2b9ee449ca0d0959a560b9705
    Image:          quay.io/openshiftlabs/simpleservice:0.5.0
    Image ID:       docker-pullable://quay.io/openshiftlabs/simpleservice@sha256:72bfe1acc54829c306dd6683fe28089d222cf50a2df9d10c4e9d32974a591673
    Port:           9876/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 02 Jul 2020 13:54:35 +0200
    Ready:          True
    Restart Count:  0
    Liveness:       http-get http://:9876/health delay=2s timeout=1s period=5s #success=1 #failure=3
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
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/hc to minikube
  Normal  Pulled     34s        kubelet, minikube  Container image "quay.io/openshiftlabs/simpleservice:0.5.0" already present on machine
  Normal  Created    34s        kubelet, minikube  Created container sise
  Normal  Started    33s        kubelet, minikube  Started container sise

-create a bad pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/healthz/badpod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: badpod
spec:
  containers:
  - name: sise
    image: quay.io/openshiftlabs/simpleservice:0.5.0
    ports:
    - containerPort: 9876
    env:
    - name: HEALTH_MIN
      value: "1000"
    - name: HEALTH_MAX
      value: "4000"
    livenessProbe:
      initialDelaySeconds: 2
      periodSeconds: 5
      httpGet:
        path: /health
        port: 9876

-get pods
NAME     READY   STATUS    RESTARTS   AGE
badpod   1/1     Running   0          44s
hc       1/1     Running   0          2m48s

-describe pod
Name:         badpod
Namespace:    default
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Thu, 02 Jul 2020 13:56:39 +0200
Labels:       <none>
Annotations:  Status:  Running
IP:           172.17.0.3
IPs:
  IP:  172.17.0.3
Containers:
  sise:
    Container ID:   docker://e2491cbcb2b9255467999722dca6b49584a8876c604a5b2123672f0bec873d0b
    Image:          quay.io/openshiftlabs/simpleservice:0.5.0
    Image ID:       docker-pullable://quay.io/openshiftlabs/simpleservice@sha256:72bfe1acc54829c306dd6683fe28089d222cf50a2df9d10c4e9d32974a591673
    Port:           9876/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 02 Jul 2020 13:57:27 +0200
    Last State:     Terminated
      Reason:       Error
      Exit Code:    137
      Started:      Thu, 02 Jul 2020 13:56:40 +0200
      Finished:     Thu, 02 Jul 2020 13:57:27 +0200
    Ready:          True
    Restart Count:  1
    Liveness:       http-get http://:9876/health delay=2s timeout=1s period=5s #success=1 #failure=3
    Environment:
      HEALTH_MIN:  1000
      HEALTH_MAX:  4000
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
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  <unknown>          default-scheduler  Successfully assigned default/badpod to minikube
  Normal   Killing    41s                kubelet, minikube  Container sise failed liveness probe, will be restarted
  Normal   Pulled     11s (x2 over 58s)  kubelet, minikube  Container image "quay.io/openshiftlabs/simpleservice:0.5.0" already present on machine
  Normal   Created    11s (x2 over 58s)  kubelet, minikube  Created container sise
  Normal   Started    11s (x2 over 58s)  kubelet, minikube  Started container sise
  Warning  Unhealthy  1s (x5 over 51s)   kubelet, minikube  Liveness probe failed: Get http://172.17.0.3:9876/health: net/http: request canceled (Client.Timeout exceeded while awaiting headers)

-get pods
kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
badpod   1/1     Running   2          107s
hc       1/1     Running   0          3m51s

-create a pod with readinessProbe
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/healthz/ready.yaml

apiVersion: v1
kind: Pod
metadata:
  name: ready
spec:
  containers:
  - name: sise
    image: quay.io/openshiftlabs/simpleservice:0.5.0
    ports:
    - containerPort: 9876
    readinessProbe:
      initialDelaySeconds: 10
      httpGet:
        path: /health
        port: 9876

-describe pod
kubectl describe pod ready
Name:         ready
Namespace:    default
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Thu, 02 Jul 2020 14:00:00 +0200
Labels:       <none>
Annotations:  Status:  Running
IP:           172.17.0.4
IPs:
  IP:  172.17.0.4
Containers:
  sise:
    Container ID:   docker://806334fecaac8e7d8a56296ebe50adfa909ea07c13c433850d97e566cb777b6a
    Image:          quay.io/openshiftlabs/simpleservice:0.5.0
    Image ID:       docker-pullable://quay.io/openshiftlabs/simpleservice@sha256:72bfe1acc54829c306dd6683fe28089d222cf50a2df9d10c4e9d32974a591673
    Port:           9876/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 02 Jul 2020 14:00:01 +0200
    Ready:          False
    Restart Count:  0
    Readiness:      http-get http://:9876/health delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-x45wv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
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
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/ready to minikube
  Normal  Pulled     6s         kubelet, minikube  Container image "quay.io/openshiftlabs/simpleservice:0.5.0" already present on machine
  Normal  Created    6s         kubelet, minikube  Created container sise
  Normal  Started    6s         kubelet, minikube  Started container sise

-delete all pods
kubectl delete pod/hc pod/ready pod/badpod
