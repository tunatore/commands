https://v1-12.docs.kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment
https://v1-12.docs.kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment

>vi rolling-deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.1
        ports:
        - containerPort: 80

>kubectl apply -f rolling-deployment.yml

>kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
busybox                              0/1     Completed           0          6d22h
my-annotation-pod                    1/1     Running             0          3d3h
my-args-pod                          0/1     Completed           0          5d6h
my-command-pod                       0/1     Completed           0          5d6h
my-configmap-pod                     1/1     Running             25         5d5h
my-configmap-volume-pod              1/1     Running             25         5d5h
my-containerport-pod                 1/1     Running             0          5d6h
my-development-label-pod             1/1     Running             0          3d3h
my-liveness-pod                      1/1     Running             9          3d
my-production-label-pod              1/1     Running             0          3d3h
my-pvc-pod                           1/1     Running             0          4d
my-readiness-pod                     1/1     Running             0          3d
my-resource-pod                      1/1     Running             23         5d1h
my-secret-pod                        1/1     Running             22         5d1h
my-securitycontext-pod               0/1     CrashLoopBackOff    294        5d2h
my-serviceaccount-pod                1/1     Running             22         5d
rolling-deployment-7f76fc567-fnkdk   0/1     ContainerCreating   0          27s
rolling-deployment-7f76fc567-vqdp5   0/1     ContainerCreating   0          27s
rolling-deployment-7f76fc567-xjqsb   0/1     ContainerCreating   0          27s

>kubectl set image deployment/rolling-deployment nginx=nginx:1.7.9 --record
>kubectl get pods
NAME                                  READY   STATUS              RESTARTS   AGE
busybox                               0/1     Completed           0          6d22h
my-annotation-pod                     1/1     Running             0          3d3h
my-args-pod                           0/1     Completed           0          5d6h
my-command-pod                        0/1     Completed           0          5d6h
my-configmap-pod                      1/1     Running             25         5d5h
my-configmap-volume-pod               1/1     Running             25         5d5h
my-containerport-pod                  1/1     Running             0          5d6h
my-development-label-pod              1/1     Running             0          3d3h
my-liveness-pod                       1/1     Running             9          3d
my-production-label-pod               1/1     Running             0          3d3h
my-pvc-pod                            1/1     Running             0          4d
my-readiness-pod                      1/1     Running             0          3d
my-resource-pod                       1/1     Running             23         5d1h
my-secret-pod                         1/1     Running             22         5d1h
my-securitycontext-pod                0/1     CrashLoopBackOff    295        5d2h
my-serviceaccount-pod                 1/1     Running             22         5d
rolling-deployment-5bf87f5f59-49bxv   1/1     Running             0          77s
rolling-deployment-5bf87f5f59-szzhq   1/1     Running             0          75s
rolling-deployment-5bf87f5f59-xjnhh   1/1     Running             0          78s
rolling-deployment-6d94f85678-gnlv5   0/1     ContainerCreating   0          12s

>kubectl rollout history deployment/rolling-deployment
deployment.apps/rolling-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl set image deployment/rolling-deployment nginx=nginx:1.7.9 --record=true
3         kubectl set image deployment/rolling-deployment nginx=nginx:1.7.6 --record=true

>kubectl rollout history deployment/rolling-deployment --revision=2
deployment.apps/rolling-deployment with revision #2
Pod Template:
  Labels:	app=nginx
	pod-template-hash=5bf87f5f59
  Annotations:	kubernetes.io/change-cause: kubectl set image deployment/rolling-deployment nginx=nginx:1.7.9 --record=true
  Containers:
   nginx:
    Image:	nginx:1.7.9
    Port:	80/TCP
    Host Port:	0/TCP
    Environment:	<none>
    Mounts:	<none>
  Volumes:	<none>

>kubectl rollout undo deployment/rolling-deployment
>kubectl rollout undo deployment/rolling-deployment --to-revision=1

>kubectl edit deployment rolling-deployment

maxSurge and maxUnavailable:

>vi rolling-deployment-maxSurge-maxUnavailable.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-deployment
spec:
  strategy:
    rollingUpdate:
      maxSurge: 3
      maxUnavailable: 2
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.1
        ports:
        - containerPort: 80
