https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/

>vi my-production-label-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-production-label-pod
  labels:
    app: my-app
    environment: production
spec:
  containers:
  - name: nginx
    image: nginx

>kubectl apply -f my-production-label-pod.yml
>kubectl get pods
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          3d19h
multi-container-pod       2/2     Running            0          19h
my-args-pod               0/1     Completed          0          2d2h
my-command-pod            0/1     Completed          0          2d2h
my-configmap-pod          1/1     Running            13         2d1h
my-configmap-volume-pod   1/1     Running            13         2d1h
my-containerport-pod      1/1     Running            0          2d2h
my-production-label-pod   1/1     Running            0          15s
my-pvc-pod                1/1     Running            0          20h
my-resource-pod           1/1     Running            11         45h
my-secret-pod             1/1     Running            11         45h
my-securitycontext-pod    0/1     CrashLoopBackOff   147        47h
my-serviceaccount-pod     1/1     Running            10         44h
shell-demo                1/1     Running            0          3d20h
volume-pod                1/1     Running            0          29h

>kubectl get pods --show-labels
NAME                      READY   STATUS             RESTARTS   AGE     LABELS
busybox                   0/1     Completed          0          3d19h   run=busybox
multi-container-pod       2/2     Running            0          19h     <none>
my-args-pod               0/1     Completed          0          2d2h    app=myapp
my-command-pod            0/1     Completed          0          2d2h    app=myapp
my-configmap-pod          1/1     Running            13         2d1h    <none>
my-configmap-volume-pod   1/1     Running            13         2d1h    <none>
my-containerport-pod      1/1     Running            0          2d2h    app=myapp
my-production-label-pod   1/1     Running            0          62s     app=my-app,environment=production
my-pvc-pod                1/1     Running            0          20h     <none>
my-resource-pod           1/1     Running            11         45h     <none>
my-secret-pod             1/1     Running            11         45h     <none>
my-securitycontext-pod    0/1     CrashLoopBackOff   147        47h     <none>
my-serviceaccount-pod     1/1     Running            10         44h     <none>
shell-demo                1/1     Running            0          3d20h   <none>
volume-pod                1/1     Running            0          29h     <none>

>kubectl describe pod my-production-label-pod

>vi my-development-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-development-label-pod
  labels:
    app: my-app
    environment: development
spec:
  containers:
  - name: nginx
    image: nginx

>kubectl apply -f my-development-pod.yml

>kubectl get pods -l app=my-app
NAME                       READY   STATUS    RESTARTS   AGE
my-development-label-pod   1/1     Running   0          86s
my-production-label-pod    1/1     Running   0          4m43s

>kubectl get pod -l environment=production
NAME                      READY   STATUS    RESTARTS   AGE
my-production-label-pod   1/1     Running   0          6m

>kubectl get pod -l environment=development
NAME                       READY   STATUS    RESTARTS   AGE
my-development-label-pod   1/1     Running   0          3m40s

>kubectl get pod -l environment!=production
NAME                       READY   STATUS             RESTARTS   AGE
busybox                    0/1     Completed          0          3d19h
multi-container-pod        2/2     Running            0          19h
my-args-pod                0/1     Completed          0          2d2h
my-command-pod             0/1     Completed          0          2d3h
my-configmap-pod           1/1     Running            13         2d2h
my-configmap-volume-pod    1/1     Running            13         2d1h
my-containerport-pod       1/1     Running            0          2d2h
my-development-label-pod   1/1     Running            0          4m26s
my-pvc-pod                 1/1     Running            0          20h
my-resource-pod            1/1     Running            11         45h
my-secret-pod              1/1     Running            11         45h
my-securitycontext-pod     0/1     CrashLoopBackOff   148        47h
my-serviceaccount-pod      1/1     Running            10         45h
shell-demo                 1/1     Running            0          3d20h
volume-pod                 1/1     Running            0          30h

>kubectl get pods -l 'environment in (production, development)'
NAME                       READY   STATUS    RESTARTS   AGE
my-development-label-pod   1/1     Running   0          5m41s
my-production-label-pod    1/1     Running   0          8m58s

>kubectl get pods -l app=my-app,environment=production
NAME                      READY   STATUS    RESTARTS   AGE
my-production-label-pod   1/1     Running   0          10m

#annotation cannot be used as selector
#automation purposes can be used.

>vi my-annotation-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-annotation-pod
  annotations:
    owner: terry@linuxacademy.com
    git-commit: bdab0c6
spec:
  containers:
  - name: nginx
    image: nginx

>kubectl describe pod my-annotation-pod
