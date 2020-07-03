https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes
https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/

>vi my-liveness-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-liveness-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo Hello, Kubernetes! && sleep 3600"]
    livenessProbe:
      exec:
        command:
        - echo
        - testing
      initialDelaySeconds: 5
      periodSeconds: 5

>kubectl apply -f my-liveness-pod.yml
>kubectl get pods
NAME                       READY   STATUS             RESTARTS   AGE
busybox                    0/1     Completed          0          3d22h
my-annotation-pod          1/1     Running            0          167m
my-args-pod                0/1     Completed          0          2d6h
my-command-pod             0/1     Completed          0          2d6h
my-configmap-pod           1/1     Running            15         2d5h
my-configmap-volume-pod    1/1     Running            15         2d5h
my-containerport-pod       1/1     Running            0          2d5h
my-development-label-pod   1/1     Running            0          3h8m
my-liveness-pod            1/1     Running            0          105s
my-production-label-pod    1/1     Running            0          3h11m
my-pvc-pod                 1/1     Running            0          23h
my-resource-pod            1/1     Running            13         2d
my-secret-pod              1/1     Running            13         2d
my-securitycontext-pod     0/1     CrashLoopBackOff   176        2d2h
my-serviceaccount-pod      1/1     Running            12         2d

>vi my-readiness-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-readiness-pod
spec:
  containers:
  - name: myapp-container
    image: nginx
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5

>kubectl apply -f my-readiness-pod.yml
NAME                       READY   STATUS             RESTARTS   AGE
busybox                    0/1     Completed          0          3d22h
my-annotation-pod          1/1     Running            0          170m
my-args-pod                0/1     Completed          0          2d6h
my-command-pod             0/1     Completed          0          2d6h
my-configmap-pod           1/1     Running            15         2d5h
my-configmap-volume-pod    1/1     Running            15         2d5h
my-containerport-pod       1/1     Running            0          2d5h
my-development-label-pod   1/1     Running            0          3h10m
my-liveness-pod            1/1     Running            0          4m9s
my-production-label-pod    1/1     Running            0          3h14m
my-pvc-pod                 1/1     Running            0          23h
my-readiness-pod           1/1     Running            0          86s
my-resource-pod            1/1     Running            13         2d1h
my-secret-pod              1/1     Running            13         2d
my-securitycontext-pod     0/1     CrashLoopBackOff   177        2d2h
my-serviceaccount-pod      1/1     Running            12         2d
