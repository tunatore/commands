https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container

>vi my-resource-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-resource-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"

>kubectl apply -f my-resource-pod.yml
>kubectl get pods
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          45h
my-args-pod               0/1     Completed          0          5h2m
my-command-pod            0/1     Completed          0          5h6m
my-configmap-pod          1/1     Running            2          4h10m
my-configmap-volume-pod   1/1     Running            1          4h2m
my-containerport-pod      1/1     Running            0          4h57m
my-resource-pod           1/1     Running            0          5s
my-securitycontext-pod    0/1     CrashLoopBackOff   10         97m
shell-demo                1/1     Running            0          46h

>kubectl describe pod my-resource-pod

