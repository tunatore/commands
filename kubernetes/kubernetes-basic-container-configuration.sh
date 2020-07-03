https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/

#command
> vi my-command-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-command-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['echo']
  restartPolicy: Never

>kubectl create -f my-command-pod.yml
>kubectl get pods
NAME             READY   STATUS      RESTARTS   AGE
busybox          0/1     Completed   0          40h
my-command-pod   0/1     Completed   0          11s
shell-demo       1/1     Running     0          41h

#args
>vi my-args-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-args-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['echo']
    args: ['This is my custom argument']
  restartPolicy: Never

>kubectl create -f my-args-pod.yml
>kubectl get pods
NAME             READY   STATUS      RESTARTS   AGE
busybox          0/1     Completed   0          40h
my-args-pod      0/1     Completed   0          19s
my-command-pod   0/1     Completed   0          3m40s
shell-demo       1/1     Running     0          41h

#containerPod
>vi my-containerport-pod-yml
apiVersion: v1
kind: Pod
metadata:
  name: my-containerport-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: nginx
    ports:
    - containerPort: 80

>kubectl create -f my-containerport-pod-yml
>kubectl get pods
NAME                   READY   STATUS      RESTARTS   AGE
busybox                0/1     Completed   0          40h
my-args-pod            0/1     Completed   0          6m5s
my-command-pod         0/1     Completed   0          9m26s
my-containerport-pod   1/1     Running     0          18s
shell-demo             1/1     Running     0          41h
