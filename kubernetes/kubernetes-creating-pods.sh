https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/

> vi my-pod.yml

my-pod.ml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']

>kubectl create -f my-pod.yml
>kubectl get pods
NAME         READY   STATUS      RESTARTS   AGE
busybox      0/1     Completed   0          37h
my-pod       1/1     Running     0          32s
shell-demo   1/1     Running     0          38h

>vi my-pod.yml

#change label

apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: myapp-1
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']

>kubectl edit pod my-pod
>kubectl delete pod my-pod
