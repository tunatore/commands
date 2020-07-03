https://kubernetes.io/docs/concepts/services-networking/service/
https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/

>vi sample-deployment.yml
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

>kubectl apply -f sample-deployment.yml

>kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
busybox                              0/1     Completed   0          7d21h
my-configmap-pod                     1/1     Running     28         6d4h
my-configmap-volume-pod              1/1     Running     28         6d3h
my-containerport-pod                 1/1     Running     1          6d4h
my-liveness-pod                      1/1     Running     12         3d23h
my-production-label-pod              1/1     Running     1          4d2h
my-pvc-pod                           1/1     Running     1          4d22h
my-readiness-pod                     1/1     Running     1          3d22h
my-secret-pod                        1/1     Running     26         5d23h
nginx-deployment-5bf87f5f59-6r6kc    1/1     Running     0          15s
nginx-deployment-5bf87f5f59-rd7rm    1/1     Running     0          15s
nginx-deployment-5bf87f5f59-zchvp    1/1     Running     0          15s
rolling-deployment-7f76fc567-694r9   1/1     Running     0          21m
rolling-deployment-7f76fc567-k2ktd   1/1     Running     0          21m
rolling-deployment-7f76fc567-xhfhs   1/1     Running     0          27m

>vi my-service.yml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 80

>kubectl apply -f my-service.yml
>kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    30d
my-service   ClusterIP   10.102.152.99   <none>        8080/TCP   26s

>kubectl get services
>kubectl get endpoints my-service
NAME         ENDPOINTS                                                  AGE
my-service   172.17.0.13:80,172.17.0.14:80,172.17.0.15:80 + 3 more...   49s
