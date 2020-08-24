https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

>kubectl get namespaces
NAME                   STATUS   AGE
default                Active   24d
kube-node-lease        Active   24d
kube-public            Active   24d
kube-system            Active   24d
kubernetes-dashboard   Active   5d15h

>kubectl create ns my-ns
>vi my-ns-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-ns-pod
  namespace: my-ns
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']

>kubectl create -f my-ns-pod.yml
#default namespace
>kubectl describe pod my-ns-pod
 Error from server (NotFound): pods "my-ns-pod" not found

>kubectl get pods -n default
NAME         READY   STATUS      RESTARTS   AGE
busybox      0/1     Completed   0          38h
shell-demo   1/1     Running     0          39h

>kubectl get pods -n my-ns
NAME        READY   STATUS    RESTARTS   AGE
my-ns-pod   1/1     Running   0          2m29s

>kubectl describe pod my-ns-pod -n my-ns
