https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

>vi nginx-deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
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
        image: nginx:1.7.9
        ports:
        - containerPort: 80

>kubectl apply -f nginx-deployment.yml
kubectl get pods                                    [18:16:47]
NAME                                READY   STATUS             RESTARTS   AGE
busybox                             0/1     Completed          0          3d21h
multi-container-pod                 2/2     Running            0          21h
my-annotation-pod                   1/1     Running            0          93m
my-args-pod                         0/1     Completed          0          2d4h
my-command-pod                      0/1     Completed          0          2d4h
my-configmap-pod                    1/1     Running            14         2d3h
my-configmap-volume-pod             1/1     Running            14         2d3h
my-containerport-pod                1/1     Running            0          2d4h
my-development-label-pod            1/1     Running            0          114m
my-production-label-pod             1/1     Running            0          117m
my-pvc-pod                          1/1     Running            0          22h
my-resource-pod                     1/1     Running            12         47h
my-secret-pod                       1/1     Running            12         47h
my-securitycontext-pod              0/1     CrashLoopBackOff   166        2d1h
my-serviceaccount-pod               1/1     Running            12         46h
nginx-deployment-5bf87f5f59-8wj4z   1/1     Running            0          23s
nginx-deployment-5bf87f5f59-9sfmg   1/1     Running            0          23s
nginx-deployment-5bf87f5f59-9xmdq   1/1     Running            0          23s
shell-demo                          1/1     Running            0          3d22h
volume-pod                          1/1     Running            0          31h

>kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           52s

>kubectl get deployment nginx-deployment
>kubectl edit deployment nginx-deployment
>kubectl describe deployment nginx-deployment
>kubectl delete deployment nginx-deployment
