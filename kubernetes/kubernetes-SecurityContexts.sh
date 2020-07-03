https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

#linux
sudo useradd -u 2000 container-user-0
sudo groupadd -g 3000 container-group-0
sudo useradd -u 2001 container-user-1
sudo groupadd -g 3001 container-group-1
sudo mkdir -p /etc/message/
echo "Hello, World!" | sudo tee -a /etc/message/message.txt
sudo chown 2000:3000 /etc/message/message.txt
sudo chmod 640 /etc/message/message.txt

#mac
dscl . -create /Groups/groupName
dscl . -create /Groups/groupName name groupName
dscl . -create /Groups/groupName passwd "*"
dscl . -create /Groups/groupName gid 33
dscl . -create /Groups/groupName GroupMembership shortusername

dscl . list /users
dscl . list /groups
dscl . readall /users
dscl . list /Groups
dscl . readall /groups
dscl -plist . readall /users
dscl -plist . readall /groups
sudo dscl . -delete /Users/testuser

sudo dscl . -create /Users/container-user-1 UniqueID 2001
sudo dscl . -create /Users/container-user-0 UniqueID 2000
sudo dscl . -create /Groups/container-group-1 gid 3001
sudo dscl . -create /Groups/container-group-0 gid 3000
sudo mkdir -p /etc/message/
echo "Hello, World" | sudo tee -a /etc/message/message.txt
sudo chown 2000:3000 /etc/message/message.txt
sudo chmod 640 /etc/message/message.txt

>vi my-securitycontext-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-securitycontext-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "cat /message/message.txt && sleep 3600"]
    volumeMounts:
    - name: message-volume
      mountPath: /message
  volumes:
  - name: message-volume
    hostPath:
      path: /etc/message

>kubectl apply -f my-securitycontext-pod.yml
>kubetcl get pods
kubectl get pods                                             [16:46:00]
NAME                      READY   STATUS             RESTARTS   AGE
busybox                   0/1     Completed          0          43h
my-args-pod               0/1     Completed          0          3h16m
my-command-pod            0/1     Completed          0          3h19m
my-configmap-pod          1/1     Running            1          143m
my-configmap-volume-pod   1/1     Running            1          135m
my-containerport-pod      1/1     Running            0          3h10m
my-securitycontext-pod    0/1     CrashLoopBackOff   2          47s
shell-demo                1/1     Running            0          44h
tuna➜~» vi my-securitycontext-pod.yml                                [16:46:01]
tuna➜~» kubectl logs my-securitycontext-pod                          [16:46:40]
cat: can't open '/message/message.txt': No such file or directory

>kubectl delete pod my-securitycontext-pod
>kubectl delete pod my-securitycontext-pod --now

>vi my-securitycontext-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-securitycontext-pod
spec:
  securityContext:
    runAsUser: 2001
    fsGroup: 3001
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "cat /message/message.txt && sleep 3600"]
    volumeMounts:
    - name: message-volume
      mountPath: /message
  volumes:
  - name: message-volume
    hostPath:
      path: /etc/message
