https://kubernetes.io/docs/concepts/services-networking/network-policies/

wget -O canal.yaml https://docs.projectcalico.org/v3.5/getting-started/kubernetes/installation/hosted/canal/canal.yaml

kubectl apply -f canal.yaml

>vi network-policy-secure-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: network-policy-secure-pod
  labels:
    app: secure-app
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80

>kubectl apply -f network-policy-secure-pod.yml

>vi network-policy-client-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: network-policy-client-pod
spec:
  containers:
  - name: busybox
    image: radial/busyboxplus:curl
    command: ["/bin/sh", "-c", "while true; do sleep 3600; done"]

>kubectl apply -f network-policy-client-pod.yml

>kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
busybox                              0/1     Completed   0          9d
my-configmap-pod                     1/1     Running     31         7d23h
my-configmap-volume-pod              1/1     Running     31         7d23h
my-containerport-pod                 1/1     Running     1          8d
my-liveness-pod                      1/1     Running     15         5d18h
my-production-label-pod              1/1     Running     1          5d21h
my-pvc-pod                           1/1     Running     1          6d18h
my-readiness-pod                     1/1     Running     1          5d18h
my-secret-pod                        1/1     Running     29         7d18h
network-policy-client-pod            1/1     Running     0          7s
network-policy-secure-pod            1/1     Running     0          2m19s
nginx-deployment-5bf87f5f59-6r6kc    1/1     Running     0          43h
nginx-deployment-5bf87f5f59-rd7rm    1/1     Running     0          43h
nginx-deployment-5bf87f5f59-zchvp    1/1     Running     0          43h
rolling-deployment-7f76fc567-694r9   1/1     Running     0          43h
rolling-deployment-7f76fc567-k2ktd   1/1     Running     0          43h
rolling-deployment-7f76fc567-xhfhs   1/1     Running     0          43h

>kubectl get pod network-policy-secure-pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE     IP            NODE       NOMINATED NODE   READINESS GATES
network-policy-secure-pod   1/1     Running   0          3m55s   172.17.0.16   minikube   <none>           <none>

>kubectl exec network-policy-client-pod -- curl 172.17.0.16
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0  51754      0 --:--:-- --:--:-- --:--:-- 5563<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
6

>vi my-network-policy-yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: my-network-policy
spec:
  podSelector:
    matchLabels:
      app: secure-app
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          allow-access: "true"
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - podSelector:
        matchLabels:
          allow-access: "true"
    ports:
    - protocol: TCP
      port: 80

>kubectl apply -f my-network-policy-yml

>kubectl get networkpolicies
NAME                POD-SELECTOR     AGE
my-network-policy   app=secure-app   23s

>kubectl describe networkpolicy my-network-polic
Name:         my-network-policy
Namespace:    default
Created on:   2020-06-14 13:49:56 +0200 CEST
Labels:       <none>
Annotations:  Spec:
  PodSelector:     app=secure-app
  Allowing ingress traffic:
    To Port: 80/TCP
    From:
      PodSelector: allow-access=true
  Allowing egress traffic:
    To Port: 80/TCP
    To:
      PodSelector: allow-access=true
  Policy Types: Ingress, Egress

>kubectl edit pod network-policy-client-pod

-podSelector
-namespaceSelector
-ipBlock
