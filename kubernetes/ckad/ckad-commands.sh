Creating Pods
k run pod1 --image=bash -l=my-label=test -oyaml --dry-run=client -- bash -c "hostname >> /tmp/hostname && sleep 1d"
k delete pod pod1 --grace-period=0 --force
k delete pod pod1 --force --grace-period 0
k exec pod1 -- cat /tmp/hostname
k label pod pod1 new-label=test2
k get pod pod1 --show-labels

Namespaces, Deployments and Services
k create ns k8n-challenge2-a
k config set-context docker-for-desktop --namespace=k8n-challenge-2-a
k config set-context --current --namespace=k8n-challenge2-a
k create deployment nginx-deployment --image=nginx -oyaml --dry-run=client >nginx-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-deployment
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deployment
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources:
          limits:
            memory: "64Mi"
      restartPolicy: Always

k get deploy
k get pod
k get rs
k expose deployment nginx-deployment --name=nginx-service --port=4444 --target-port=80
k get services

k run -it pod1 --image=cosmintitei/bash-curl --restart=Never --rm
If you don't see a command prompt, try pressing enter.
bash-4.4# curl http://nginx-service:4444
<!DOCTYPE html>
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
bash-4.4#

k create ns k8n-challenge-2-b
k run -it pod2 --image=cosmintitei/bash-curl --restart=Never --namespace=k8n-challenge-2-b --rm
If you don't see a command prompt, try pressing enter.
bash-4.4# curl http://nginx-service.k8n-challenge-2-a:4444
curl: (6) Couldn't resolve host 'nginx-service.k8n-challenge-2-a'
bash-4.4# curl http://nginx-service.k8n-challenge2-a:4444
<!DOCTYPE html>
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
bash-4.4#
