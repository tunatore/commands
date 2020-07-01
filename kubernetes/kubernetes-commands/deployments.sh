-create a deployment
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/deployments/d09.yaml

-get pods
kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
nginx-deployment-5bf87f5f59-4hdj5    1/1     Running   0          144m
nginx-deployment-5bf87f5f59-hj7rg    1/1     Running   0          144m
nginx-deployment-5bf87f5f59-hnt4c    1/1     Running   0          144m
rolling-deployment-7f76fc567-grdjm   1/1     Running   0          144m
rolling-deployment-7f76fc567-h5g9r   1/1     Running   0          144m
rolling-deployment-7f76fc567-hjlhw   1/1     Running   0          144m
sise-deploy-547775c98b-9fps4         1/1     Running   0          7s
sise-deploy-547775c98b-bdgnr         1/1     Running   0          7s

-get deployments
kubectl get deploy
NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment     3/3     3            3           19d
rolling-deployment   3/3     3            3           20d
sise-deploy          2/2     2            2           53s

-get replica set
kubectl get rs
NAME                            DESIRED   CURRENT   READY   AGE
nginx-deployment-5bf87f5f59     3         3         3       19d
rolling-deployment-5bf87f5f59   0         0         0       20d
rolling-deployment-6d94f85678   0         0         0       20d
rolling-deployment-7f76fc567    3         3         3       20d
sise-deploy-547775c98b          2         2         2       77

-get pods
kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
nginx-deployment-5bf87f5f59-4hdj5    1/1     Running   0          146m
nginx-deployment-5bf87f5f59-hj7rg    1/1     Running   0          146m
nginx-deployment-5bf87f5f59-hnt4c    1/1     Running   0          146m
rolling-deployment-7f76fc567-grdjm   1/1     Running   0          146m
rolling-deployment-7f76fc567-h5g9r   1/1     Running   0          146m
rolling-deployment-7f76fc567-hjlhw   1/1     Running   0          146m
sise-deploy-547775c98b-9fps4         1/1     Running   0          98s
sise-deploy-547775c98b-bdgnr         1/1     Running   0          98s

-get pods ip address using kubectl describe
kubectl describe podname

-test containers
curl 172.17.0.12:9876/info
Name:         sise-deploy-547775c98b-9fps4
Namespace:    default
Priority:     0
Node:         minikube/192.168.99.100
Start Time:   Wed, 01 Jul 2020 21:45:37 +0200
Labels:       app=sise
              pod-template-hash=547775c98b
Annotations:  <none>
Status:       Running
IP:           172.17.0.12
IPs:
  IP:           172.17.0.12
Controlled By:  ReplicaSet/sise-deploy-547775c98b
Containers:
  sise:
    Container ID:   docker://973bbf290d6e5c6312691419bbe012158ad135100afffff22f8b73cdd2cde49c
    Image:          quay.io/openshiftlabs/simpleservice:0.5.0
    Image ID:       docker-pullable://quay.io/openshiftlabs/simpleservice@sha256:72bfe1acc54829c306dd6683fe28089d222cf50a2df9d10c4e9d32974a591673
    Port:           9876/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 01 Jul 2020 21:45:38 +0200
    Ready:          True
    Restart Count:  0
    Environment:
      SIMPLE_SERVICE_VERSION:  0.9
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
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/sise-deploy-547775c98b-9fps4 to minikube
  Normal  Pulled     2m22s      kubelet, minikube  Container image "quay.io/openshiftlabs/simpleservice:0.5.0" already present on machine
  Normal  Created    2m22s      kubelet, minikube  Created container sise
  Normal  Started    2m22s      kubelet, minikube  Started container sise

-change version
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/deployments/d10.yaml

-you can also manually edit deployment using the following command
kubectl edit deploy/sise-deploy

-get pods
kubectl get pods
NAME                                 READY   STATUS        RESTARTS   AGE
nginx-deployment-5bf87f5f59-4hdj5    1/1     Running       0          148m
nginx-deployment-5bf87f5f59-hj7rg    1/1     Running       0          148m
nginx-deployment-5bf87f5f59-hnt4c    1/1     Running       0          148m
rolling-deployment-7f76fc567-grdjm   1/1     Running       0          148m
rolling-deployment-7f76fc567-h5g9r   1/1     Running       0          148m
rolling-deployment-7f76fc567-hjlhw   1/1     Running       0          148m
sise-deploy-547775c98b-9fps4         1/1     Terminating   0          3m39s
sise-deploy-547775c98b-bdgnr         1/1     Terminating   0          3m39s
sise-deploy-79c6df4ffd-bpfsv         1/1     Running       0          26s
sise-deploy-79c6df4ffd-skbpf         1/1     Running       0          28s

-get replicate set
kubectl get rs
NAME                            DESIRED   CURRENT   READY   AGE
nginx-deployment-5bf87f5f59     3         3         3       19d
rolling-deployment-5bf87f5f59   0         0         0       20d
rolling-deployment-6d94f85678   0         0         0       20d
rolling-deployment-7f76fc567    3         3         3       20d
sise-deploy-547775c98b          0         0         0       3m54s
sise-deploy-79c6df4ffd          2         2         2       43s

-you can check the rollout status
kubectl rollout status deploy/sise-deploy
deployment "sise-deploy" successfully rolled out

-get the ip of pods using the following command
kubectl describe podname

-test pods using curl
curl 172.17.0.5:9876/info

-check history of deployment
kubectl rollout history deploy/sise-deploy
deployment.apps/sise-deploy
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

-explicitly rollback to specific version
kubectl rollout undo deploy/sise-deploy --to-revision=1

-check the history of deployment
kubectl rollout history deploy/sise-deploy

-get pods
kubectl get pods
NAME                                 READY   STATUS        RESTARTS   AGE
nginx-deployment-5bf87f5f59-4hdj5    1/1     Running       0          149m
nginx-deployment-5bf87f5f59-hj7rg    1/1     Running       0          149m
nginx-deployment-5bf87f5f59-hnt4c    1/1     Running       0          149m
rolling-deployment-7f76fc567-grdjm   1/1     Running       0          149m
rolling-deployment-7f76fc567-h5g9r   1/1     Running       0          149m
rolling-deployment-7f76fc567-hjlhw   1/1     Running       0          149m
sise-deploy-547775c98b-8s72m         1/1     Running       0          17s
sise-deploy-547775c98b-m5w6d         1/1     Running       0          18s
sise-deploy-79c6df4ffd-bpfsv         1/1     Terminating   0          2m
sise-deploy-79c6df4ffd-skbpf         1/1     Terminating   0          2m2s

-delete a deployment
kubectl delete deploy sise-deploy
