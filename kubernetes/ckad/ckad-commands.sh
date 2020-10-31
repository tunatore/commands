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

Network Policy
k config get-contexts
k config set-context minikube

vi nginx-networkpolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: nginx-network-policy
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: api
    ports:
      - port: 3333
        protocol: TCP
  - to:
    ports:
      - port: 53
        protocol: TCP
      - port: 53
        protocol: UDP

k create -f nginx-networkpolicy.yaml

vi api-networkpolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-network-policy
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            app: nginx
      ports:
        - port: 3333
          protocol: TCP

k create -f api-networkpolicy.yaml

vi api-networkpolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-network-policy
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Egress
  - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            app: nginx
      ports:
        - port: 3333
          protocol: TCP
  egress:
  - to:
    - ipBlock:
        cidr: 216.58.208.35/32
    ports:
      - port: 443
        protocol: TCP
  - to:
    ports:
      - port: 53
        protocol: TCP
      - port: 53
        protocol: UDP

k apply -f api-networkpolicy.yaml

Migrate a Service
k run --help
k run -h
k create deploy compute --image=byrnedo/alpine-curl --dry-run=client -oyaml > compute.yaml

vi compute.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: compute
  name: compute
spec:
  replicas: 3
  selector:
    matchLabels:
      app: compute
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: compute
    spec:
      containers:
      - command:
        - /bin/sh
        - -c
        - sleep 10d
        image: byrnedo/alpine-curl
        name: alpine-curl
        resources: {}
status: {}

k create -f compute.yaml
k exec compute-7c669b88f5-527lb -- curl www.google.com:80
k create svc --help
k create svc externalname --help
k create svc externalname webapi --external-name www.google.com
k describe svc webapi
k exec compute-7c669b88f5-527lb -- ping webapi
k exec compute-7c669b88f5-527lb -- curl webapi --header "Host: www.google.com"
k create deploy nginx --image=nginx
k run nginx --image=nginx
k get svc webapi -o yaml > webapi.yaml
k delete -f webapi.yaml
k create -f webapi.yaml
k exec compute-7c669b88f5-527lb -- ping webapi
k exec compute-7c669b88f5-527lb -- curl webapi

Logging Sidecar
vi deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      run: nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx
    spec:
      volumes:
      - name: logs
        emptyDir: {}
      containers:
      - image: nginx
        name: nginx
        resources: {}
        volumeMounts:
          - name: logs
            mountPath: /var/log/nginx
status: {}

k create -f deployment.yaml
vi loadbalancer.yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  ports:
  - port: 1234
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
  type: LoadBalancer
status:
  loadBalancer: {}

k create -f loadbalancer.yaml
k edit deploy nginx
k nginx -o yaml --export > d_nginx.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      run: nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx
    spec:
      volumes:
      - name: logs
        emptyDir: {}
      containers:
      - image: bash
        name: sidecar
        volumeMounts:
        - mountPath: /tmp/logs
          name: logs
        command:
          - "/bin/sh"
          - "-c"
          - "tail -f /tmp/logs/access.log"
      - image: nginx
        name: nginx
        resources: {}
        volumeMounts:
          - name: logs
            mountPath: /var/log/nginx
status: {}

k replace deploy -f deployment.yaml
k delete deploy nginx
k logs nginx-6b48fb65c6-mhm8t sidecar

SecurityContext
vi pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bash
  name: bash
spec:
  volumes:
    - name: share
      emptyDir: {}
  containers:
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash1
    volumeMounts:
      - name: share
        mountPath: /tmp/share
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash2
    volumeMounts:
      - name: share
        mountPath: /tmp/share
  restartPolicy: Never

k create -f pod.yaml

k exec bash -c bash1 -- touch /tmp/share/file
k exec -it bash -c bash2 -- ls -lh /tmp/share/file

vi pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bash
  name: bash
spec:
  securityContext:
    runAsUser: 21
  volumes:
    - name: share
      emptyDir: {}
  containers:
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash1
    volumeMounts:
      - name: share
        mountPath: /tmp/share
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash2
    volumeMounts:
      - name: share
        mountPath: /tmp/share
  restartPolicy: Never

k delete -f pod.yaml
k create -f pod.yaml
k exec bash -c bash1 -- whoami
k exec bash -c bash2 -- whoami

vi pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bash
  name: bash
spec:
  securityContext:
    runAsUser: 21
  volumes:
    - name: share
      emptyDir: {}
  containers:
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash1
    volumeMounts:
      - name: share
        mountPath: /tmp/share
    securityContext:
      runAsUser: 0
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash2
    volumeMounts:
      - name: share
        mountPath: /tmp/share
  restartPolicy: Never

k delete -f pod.yaml
k create -f pod.yaml

vi pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bash
  name: bash
spec:
  securityContext:
    runAsUser: 21
  volumes:
    - name: share
      emptyDir: {}
  initContainers:
  - name: permission-handler
    image: bash
    command:
    - /bin/sh
    - -c
    - chmod og-w -R /tmp/share
    volumeMounts:
      - name: share
        mountPath: /tmp/share
    securityContext:
      runAsUser: 0
  containers:
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash1
    volumeMounts:
      - name: share
        mountPath: /tmp/share
    securityContext:
      runAsUser: 0
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: bash
    name: bash2
    volumeMounts:
      - name: share
        mountPath: /tmp/share
  restartPolicy: Never

ReplicaSet without Downtime
vi pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-calc
spec:
  containers:
  - command:
    - sh
    - -c
    - echo "important calculation"; sleep 1d
    image: nginx
    name: pod-calc

k create -f pod.yaml
k label pod pod-calc id=calc
k get pod --show-labels

vi replicaset.yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs1
spec:
  replicas: 2
  selector:
    matchLabels:
      id: calc
  template:
    # from here down its the pod template
    metadata:
      name: pod-calc
      labels:
        id: calc
    spec:
      containers:
      - command:
        - sh
        - -c
        - echo "important calculation"; sleep 1d
        image: nginx
        name: pod-calc

k create -f replicaset.yaml

Various Env Variables
vi env-variables.env
CREDENTIAL_001=-bQ(ETLPGE[uT?6C;ed
CREDENTIAL_002=C_;SU@ev7yg.8m6hNqS
CREDENTIAL_003=ZA#$$-Ml6et&4?pKdvy
CREDENTIAL_004=QlIc3$5*+SKsw==9=p{
CREDENTIAL_005=C_2\a{]XD}1#9BpE[k?
CREDENTIAL_006=9*KD8_w<);ozb:ns;JC
CREDENTIAL_007=C[V$Eb5yQ)c~!..{LRT
SETTING_USE_SEC=true
SETTING_ALLOW_ANON=true
SETTING_PREVENT_ADMIN_LOGIN=true

k create secret -h
k create secret generic -h
k create secret generic my-secret --from-env-file=env_file
k get secret my-secret-env -oyaml

apiVersion: v1
data:
  CREDENTIAL_001: LWJRKEVUTFBHRVt1VD82QztlZA==
  CREDENTIAL_002: Q187U1VAZXY3eWcuOG02aE5xUw==
  CREDENTIAL_003: WkEjJCQtTWw2ZXQmND9wS2R2eQ==
  CREDENTIAL_004: UWxJYzMkNSorU0tzdz09OT1wew==
  CREDENTIAL_005: Q18yXGF7XVhEfTEjOUJwRVtrPw==
  CREDENTIAL_006: OSpLRDhfdzwpO296YjpucztKQw==
  CREDENTIAL_007: Q1tWJEViNXlRKWN+IS4ue0xSVA==
  SETTING_ALLOW_ANON: dHJ1ZQ==
  SETTING_PREVENT_ADMIN_LOGIN: dHJ1ZQ==
  SETTING_USE_SEC: dHJ1ZQ==
kind: Secret
metadata:
  creationTimestamp: "2020-07-19T16:22:25Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:CREDENTIAL_001: {}
        f:CREDENTIAL_002: {}
        f:CREDENTIAL_003: {}
        f:CREDENTIAL_004: {}
        f:CREDENTIAL_005: {}
        f:CREDENTIAL_006: {}
        f:CREDENTIAL_007: {}
        f:SETTING_ALLOW_ANON: {}
        f:SETTING_PREVENT_ADMIN_LOGIN: {}
        f:SETTING_USE_SEC: {}
      f:type: {}
    manager: kubectl
    operation: Update
    time: "2020-07-19T16:22:25Z"
  name: my-secret-env
  namespace: default
  resourceVersion: "909123"
  selfLink: /api/v1/namespaces/default/secrets/my-secret-env
  uid: 34ad3e90-0ada-479c-85e2-1d662351c088
type: Opaque

k run nginx --image=nginx -oyaml --dry-run=client > nginx.yaml

vi ngix.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx-secret
spec:
  containers:
  - image: nginx
    envFrom:                # envFrom
    - secretRef:
        name: my-secret
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

k exec nginx -- env

Deployment Hacking
k create deploy nginx --image nginx
k scale deploy nginx --replicas 3
k get pod --show-labels
k get rs --show-labels
k run nginx --image=nginx --labels="app=nginx,pod-template-hash=f89759699"
k get pods

#Delete all resources
kubectl delete all --all
