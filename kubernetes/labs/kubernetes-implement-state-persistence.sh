>vi mysql-pv.yml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: mysql-pv
spec:
  storageClassName: localdisk
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"

>kubectl apply -f mysql-pv.yml

>vi mysql-pv-claim.yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  storageClassName: localdisk
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi

>kubectl apply -f mysql-pv-claim.yml

>vi mysql-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: mysql-pod
spec:
  containers:
  - name: mysql
    image: mysql:5.6
    ports:
    - containerPort: 3306
    env:
    - name: MYSQL_ROOT_PASSWORD
      value: password
    volumeMounts:
    - name: mysql-storage
      mountPath: /var/lib/mysql
  volumes:
  - name: mysql-storage
    persistentVolumeClaim:
      claimName: mysql-pv-claim

>kubectl apply -f mysql-pod.yml

>kubectl get pod mysql-pod
NAME        READY   STATUS              RESTARTS   AGE
mysql-pod   0/1     ContainerCreating   0          17s

#check worker nodes
>kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
ip-10-0-1-101   Ready    master   19m   v1.13.3
ip-10-0-1-102   Ready    <none>   19m   v1.13.3

#login to worker node using master node
>ssh cloud_user@10.0.1.102

>ls /mnt/data
auto.cnf  ib_logfile0  ib_logfile1  ibdata1  mysql  performance_schema
