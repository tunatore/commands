https://kubernetes.io/docs/concepts/configuration/secret/

>vi my-secret.yml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
stringData:
  myKey: myPassword

>kubectl apply -f my-secret.yml

>vi my-secret-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-secret-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo Hello, Kubernetes! && sleep 3600"]
    env:
    - name: MY_PASSWORD
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: myKey

>kubectl apply -f my-secret-pod.yml
>kubectl get pods
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          45h
my-args-pod               0/1     Completed          0          5h16m
my-command-pod            0/1     Completed          0          5h19m
my-configmap-pod          1/1     Running            2          4h23m
my-configmap-volume-pod   1/1     Running            2          4h15m
my-containerport-pod      1/1     Running            0          5h10m
my-resource-pod           1/1     Running            0          13m
my-secret-pod             1/1     Running            0          7s
my-securitycontext-pod    0/1     CrashLoopBackOff   12         111m
shell-demo                1/1     Running            0          46h

>kubectl exec my-secret-pod -- env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=my-secret-pod
MY_PASSWORD=myPassword
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
HOME=/root
