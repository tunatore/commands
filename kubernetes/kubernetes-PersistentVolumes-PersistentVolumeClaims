https://kubernetes.io/docs/concepts/storage/persistent-volumes/
https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

>vi my-pv-yml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: my-pv
spec:
  storageClassName: local-storage
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"

>kubectl apply -f my-pv-yml
>kubectl get pv
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
my-pv   1Gi        RWO            Retain           Available           local-storage            5s

>vi my-pvc.yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: local-storage
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 512Mi

>kubectl apply -f my-pvc.yml
>kubectl get pv
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS    REASON   AGE
my-pv   1Gi        RWO            Retain           Bound    default/my-pvc   local-storage            3m
>kubectl get pvc
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS    AGE
my-pvc   Bound    my-pv    1Gi        RWO            local-storage   5s

>vi my-pvc-pod.yml
kind: Pod
apiVersion: v1
metadata:
  name: my-pvc-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["/bin/sh", "-c", "while true; do sleep 3600; done"]
    volumeMounts:
    - mountPath: "/mnt/storage"
      name: my-storage
  volumes:
  - name: my-storage
    persistentVolumeClaim:
      claimName: my-pvc

>kubectl apply -f my-pvc-pod.yml
>kubectl get pods
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          2d22h
my-args-pod               0/1     Completed          0          30h
my-command-pod            0/1     Completed          0          30h
my-configmap-pod          1/1     Running            9          29h
my-configmap-volume-pod   1/1     Running            9          29h
my-containerport-pod      1/1     Running            0          30h
my-pvc-pod                1/1     Running            0          7s
my-resource-pod           1/1     Running            7          25h
my-secret-pod             1/1     Running            6          24h
my-securitycontext-pod    0/1     CrashLoopBackOff   98         26h
my-serviceaccount-pod     1/1     Running            6          24h
shell-demo                1/1     Running            0          2d23h
volume-pod                1/1     Running            0          9h
