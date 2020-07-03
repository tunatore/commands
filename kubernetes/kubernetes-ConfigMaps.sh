https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/

>vi my-config-map.yml
apiVersion: v1
kind: ConfigMap
metadata:
   name: my-config-map
data:
   myKey: myValue
   anotherKey: anotherValue

>kubectl apply -f my-config-map.yml

>vi my-config-map-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-configmap-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo $(MY_VAR) && sleep 3600"]
    env:
    - name: MY_VAR
      valueFrom:
        configMapKeyRef:
          name: my-config-map
          key: myKey

>kubectl apply -f my-config-map-pod.yml
>kubectl get pods
NAME                   READY   STATUS      RESTARTS   AGE
busybox                0/1     Completed   0          41h
my-args-pod            0/1     Completed   0          53m
my-command-pod         0/1     Completed   0          56m
my-configmap-pod       1/1     Running     0          22s
my-containerport-pod   1/1     Running     0          47m
shell-demo             1/1     Running     0          42h

>kubectl logs my-configmap-pod
myValue

>vi my-configmap-volume-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-configmap-volume-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "echo $(cat /etc/config/myKey) && sleep 3600"]
    volumeMounts:
      - name: config-volume
        mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
    name: my-config-map

>kubectl apply -f my-configmap-volume-pod.yml
>kubectl get pods
NAME                      READY   STATUS      RESTARTS   AGE
busybox                   0/1     Completed   0          41h
my-args-pod               0/1     Completed   0          60m
my-command-pod            0/1     Completed   0          64m
my-configmap-pod          1/1     Running     0          7m51s
my-configmap-volume-pod   1/1     Running     0          36s
my-containerport-pod      1/1     Running     0          55m
shell-demo                1/1     Running     0          42h

>kubectl logs my-configmap-volume-pod
myValue

>kubectl exec my-configmap-volume-pod -- ls /etc/config
anotherKey
myKey
>kubectl exec my-configmap-volume-pod -- cat /etc/config/myKey
myValue
>kubectl exec my-configmap-volume-pod -- cat /etc/config/anotherKey
anotherValue

