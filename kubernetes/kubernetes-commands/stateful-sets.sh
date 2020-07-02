-create a stateful app
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mehdb
spec:
  selector:
    matchLabels:
      app: mehdb
  serviceName: "mehdb"
  replicas: 2
  template:
    metadata:
      labels:
        app: mehdb
    spec:
      containers:
      - name: shard
        image: quay.io/mhausenblas/mehdb:0.6
        ports:
        - containerPort: 9876
        env:
        - name: MEHDB_DATADIR

-get pods
kubectl get pods
NAME      READY   STATUS              RESTARTS   AGE
mehdb-0   0/1     ContainerCreating   0          6s

-get all the resouces created
kubectl get sts,po,pvc,svc
NAME                     READY   AGE
statefulset.apps/mehdb   0/2     50s

NAME          READY   STATUS    RESTARTS   AGE
pod/mehdb-0   0/1     Running   0          50s

NAME                                 STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS    AGE
persistentvolumeclaim/data-mehdb-0   Bound    pvc-662279b1-44d4-45dd-bd87-cd1c3bce43fc   1Gi        RWO            standard        50s
persistentvolumeclaim/my-pvc         Bound    my-pv                                      1Gi        RWO            local-storage   25d

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    50d
service/mehdb        ClusterIP   None            <none>        9876/TCP   50s
service/my-service   ClusterIP   10.102.152.99   <none>        8080/TCP   20d
service/thesvc       ClusterIP   10.96.131.150   <none>        80/TCP     6h59m

-check if the stateful app working or not
kubectl run -it --rm jumpod --restart=Never --image=quay.io/openshiftlabs/jump:0.2 -- curl mehdb:9876/status?level=full
