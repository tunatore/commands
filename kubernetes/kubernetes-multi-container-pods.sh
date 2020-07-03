https://kubernetes.io/docs/concepts/cluster-administration/logging/#using-a-sidecar-container-with-the-logging-agent
https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/
https://kubernetes.io/blog/2015/06/the-distributed-system-toolkit-patterns/

>vi multi-container-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.15.8
    ports:
    - containerPort: 80
  - name: busybox-sidecar
    image: busybox
    command: ['sh', '-c', 'while true; do sleep 30; done;']

>kubectl apply -f multi-container-pod.yml
>kubectl get pods
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          2d23h
multi-container-pod       2/2     Running            0          31s
my-args-pod               0/1     Completed          0          31h
my-command-pod            0/1     Completed          0          31h
my-configmap-pod          1/1     Running            10         30h
my-configmap-volume-pod   1/1     Running            10         30h
my-containerport-pod      1/1     Running            0          31h
my-pvc-pod                1/1     Running            0          73m
my-resource-pod           1/1     Running            8          26h
my-secret-pod             1/1     Running            8          26h
my-securitycontext-pod    0/1     CrashLoopBackOff   113        28h
my-serviceaccount-pod     1/1     Running            7          25h
shell-demo                1/1     Running            0          3d1h
volume-pod                1/1     Running            0          10h
