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
bash-4.4#'

Cron Jobs and Volumes
vi pv.yml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: task-pv-volume
  labels:
    id: vol1
spec:
  storageClassName: manual
  capacity:
    storage: 50Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/tmp/k8s-challenge-3"

k create -f pv.yaml
vi pvc.yml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: task-pv-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 40Mi
  selector:
    matchLabels:
      id: vol1

k create -f pvc.yaml

k get pv, pvc

k create cj -h
k create cj cronjob1 --image=bash --schedule="*/1 * * * *" -o yaml --dry-run=client -- bash -c "hostname >> /tmp/vol/storage" > cronjob1.yaml
vi cronjob.yaml

apiVersion: batch/v1beta1
kind: CronJob
metadata:
  creationTimestamp: null
  labels:
    run: cronjob1
  name: cronjob1
spec:
  concurrencyPolicy: Allow
  jobTemplate:
    metadata:
      creationTimestamp: null
    spec:
      parallelism: 2
      template:
        metadata:
          creationTimestamp: null
          labels:
            run: cronjob1
        spec:
          volumes:
            - name: cron-vol
              persistentVolumeClaim:
                claimName: task-pv-claim
          containers:
          - args:
            - bash
            - -c
            - hostname >> /tmp/vol/storage
            image: bash
            name: cronjob1
            resources: {}
            volumeMounts:
              - name: cron-vol
                mountPath: /tmp/vol
          restartPolicy: Never
  schedule: '*/1 * * * *'
  successfulJobsHistoryLimit: 4

k create -f cronjob1.yaml

tail -f /tmp/k8s-challenge-3/storage

kubectl get job,pod

Deployments, Rollouts, Rollbacks

k create ns one
k config set-context --current --namespace=one
k create deploy nginx1 --image=nginx:1.14.2
k scale deploy nginx1 --replicas=3
k get pods
NAME                      READY   STATUS      RESTARTS   AGE
busybox                   0/1     Completed   0          4d18h
nginx                     0/1     Completed   0          3d20h
nginx1-7f5f7bcf68-f5zzt   1/1     Running     0          24s
nginx1-7f5f7bcf68-llv68   1/1     Running     0          24s
nginx1-7f5f7bcf68-pr7kf   1/1     Running     0          41s
pod1                      1/1     Running     0          43h

k edit deploy nginx1
k set image deploy/nginx1 nginx=nginx:1.15.10
k set image deploy/nginx1 nginx=nginx:1.15.666
k get pods
NAME                      READY   STATUS         RESTARTS   AGE
busybox                   0/1     Completed      0          4d18h
nginx                     0/1     Completed      0          3d20h
nginx1-6544df87cd-8swm6   1/1     Running        0          80s
nginx1-6544df87cd-9sxnt   1/1     Running        0          79s
nginx1-6544df87cd-lcqbt   1/1     Running        0          89s
nginx1-6b5cd94ddc-74r6r   0/1     ErrImagePull   0          44s
pod1                      1/1     Running        0          43h

k logs nginx1-6b5cd94ddc-74r6r
k describe pod nginx1-6b5cd94ddc-74r6r
k rollout history deploy nginx1
k rollout undo deploy nginx1
k get pods
NAME                      READY   STATUS      RESTARTS   AGE
busybox                   0/1     Completed   0          4d18h
nginx                     0/1     Completed   0          3d20h
nginx1-6544df87cd-8swm6   1/1     Running     0          4m8s
nginx1-6544df87cd-9sxnt   1/1     Running     0          4m7s
nginx1-6544df87cd-lcqbt   1/1     Running     0          4m17s
pod1                      1/1     Running     0          43h

Secrets and ConfigMaps
k create secret generic secret1 --from-literal=password=12345678 --dry-run=client -o yaml > secret1.yml
k run pod1 --image=bash --dry-run=client -o yaml sleep 9999 > pod1.yaml
vi pod1.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: pod1
  name: pod1
spec:
  volumes:
    - name: sec-vol
      secret:
        secretName: secret1
  containers:
  - args:
    - sleep
    - "9999"
    image: bash
    name: pod1
    resources: {}
    volumeMounts:
      - name: sec-vol
        mountPath: /tmp/secret1
  dnsPolicy: ClusterFirst
  restartPolicy: Always

k create -f pod1.yaml
k exec pod1 -- cat /tmp/secret1/password
mkdir drinks; echo ipa > drinks/beer; echo red > drinks/wine; echo sparkling > drinks/water
k create configmap drink1 --from-file ./drinks

vi pod1.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: pod1
  name: pod1
spec:
  volumes:
    - name: sec-vol
      secret:
        secretName: secret1
  containers:
  - args:
    - sleep
    - "9999"
    image: bash
    name: pod1
    resources: {}
    volumeMounts:
      - name: sec-vol
        mountPath: /tmp/secret1
    envFrom:
      - configMapRef:
          name: drink1
  dnsPolicy: ClusterFirst
  restartPolicy: Never

k -f pod1.yaml replace --force --grace-period 0
k exec pod1 env
