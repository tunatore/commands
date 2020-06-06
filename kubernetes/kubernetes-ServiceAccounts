https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/
https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

>kubectl create serviceaccount my-serviceaccount

>kubectl describe serviceaccounts my-serviceaccount
Name:                my-serviceaccount
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   my-serviceaccount-token-v2px7
Tokens:              my-serviceaccount-token-v2px7
Events:              <none>

>vi my-serviceaccount-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-serviceaccount-pod
spec:
  serviceAccountName: my-serviceaccount
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo Hello, Kubernetes! && sleep 3600"]

>kubectl apply -f my-serviceaccount-pod.yml
>kubectl get pods
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          46h
my-args-pod               0/1     Completed          0          5h53m
my-command-pod            0/1     Completed          0          5h57m
my-configmap-pod          1/1     Running            2          5h
my-configmap-volume-pod   1/1     Running            2          4h53m
my-containerport-pod      1/1     Running            0          5h48m
my-resource-pod           1/1     Running            0          50m
my-secret-pod             1/1     Running            0          37m
my-securitycontext-pod    0/1     CrashLoopBackOff   19         148m
my-serviceaccount-pod     1/1     Running            0          18s
shell-demo                1/1     Running            0          47h
