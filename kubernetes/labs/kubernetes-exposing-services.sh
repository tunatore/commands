>kubectl get deployment auth-deployment -o yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"auth-deployment","namespace":"default"},"spec":{"replicas":2,"selector":{"matchLabels":{"app":"auth"}},"template":{"metadata":{"labels":{"app":"auth"}},"spec":{"containers":[{"image":"nginx","name":"nginx","ports":[{"containerPort":80}]}]}}}}
  creationTimestamp: "2020-06-20T12:06:04Z"
  generation: 1
  name: auth-deployment
  namespace: default
  resourceVersion: "770"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/auth-deployment
  uid: 6aacb7da-b2ee-11ea-a859-0ae2e5f368a1
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: auth
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: auth
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: "2020-06-20T12:07:41Z"
    lastUpdateTime: "2020-06-20T12:07:41Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2020-06-20T12:06:04Z"
    lastUpdateTime: "2020-06-20T12:07:41Z"
    message: ReplicaSet "auth-deployment-b448d8b76" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 2
  replicas: 2
  updatedReplicas: 2

>vi auth-svc.yml
apiVersion: v1
kind: Service
metadata:
  name: auth-svc
spec:
  type: NodePort
  selector:
    app: auth
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 80

>kubectl apply -f auth-svc.yml

>kubectl get deployment data-deployment -o yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"auth-deployment","namespace":"default"},"spec":{"replicas":2,"selector":{"matchLabels":{"app":"auth"}},"template":{"metadata":{"labels":{"app":"auth"}},"spec":{"containers":[{"image":"nginx","name":"nginx","ports":[{"containerPort":80}]}]}}}}
  creationTimestamp: "2020-06-20T12:06:04Z"
  generation: 1
  name: auth-deployment
  namespace: default
  resourceVersion: "770"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/auth-deployment
  uid: 6aacb7da-b2ee-11ea-a859-0ae2e5f368a1
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: auth
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: auth
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: "2020-06-20T12:07:41Z"
    lastUpdateTime: "2020-06-20T12:07:41Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2020-06-20T12:06:04Z"
    lastUpdateTime: "2020-06-20T12:07:41Z"
    message: ReplicaSet "auth-deployment-b448d8b76" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 2
  replicas: 2
  updatedReplicas: 2
cloud_user@ip-10-0-1-101:~$ vi auth-svc.yml
cloud_user@ip-10-0-1-101:~$ vi auth-svc.yml
cloud_user@ip-10-0-1-101:~$ kubectl apply -f auth-svc.yml
service/auth-svc created
cloud_user@ip-10-0-1-101:~$ kubectl get deployment data-deployment -o yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"data-deployment","namespace":"default"},"spec":{"replicas":3,"selector":{"matchLabels":{"app":"data"}},"template":{"metadata":{"labels":{"app":"data"}},"spec":{"containers":[{"image":"nginx","name":"nginx","ports":[{"containerPort":80}]}]}}}}
  creationTimestamp: "2020-06-20T12:06:05Z"
  generation: 1
  name: data-deployment
  namespace: default
  resourceVersion: "768"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/data-deployment
  uid: 6ad74911-b2ee-11ea-a859-0ae2e5f368a1
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: data
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: data
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 3
  conditions:
  - lastTransitionTime: "2020-06-20T12:07:41Z"
    lastUpdateTime: "2020-06-20T12:07:41Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2020-06-20T12:06:05Z"
    lastUpdateTime: "2020-06-20T12:07:41Z"
    message: ReplicaSet "data-deployment-dcfff7fd6" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 3
  replicas: 3
  updatedReplicas: 3

>vi data-svc.yml
apiVersion: v1
kind: Service
metadata:
  name: data-svc
spec:
  type: ClusterIP
  selector:
    app: data
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 80

>kubectl apply -f data-svc.yml

>kubectl get deploy
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
auth-deployment   2/2     2            2           90m
data-deployment   3/3     3            3           90m

>kubectl get svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
auth-svc     NodePort    10.105.86.213    <none>        8080:32369/TCP   6m14s
data-svc     ClusterIP   10.106.179.119   <none>        8080/TCP         4m53s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP          92m

>kubectl get ep auth-svc
NAME       ENDPOINTS                     AGE
auth-svc   10.244.1.2:80,10.244.2.3:80   7m2s

>kubectl get pods
NAME                              READY   STATUS    RESTARTS   AGE
auth-deployment-b448d8b76-rxhl8   1/1     Running   0          93m
auth-deployment-b448d8b76-tmgr2   1/1     Running   0          93m
data-deployment-dcfff7fd6-k2q7c   1/1     Running   0          93m
data-deployment-dcfff7fd6-mz6x2   1/1     Running   0          93m
data-deployment-dcfff7fd6-x29tj   1/1     Running   0          93m

