-create a pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/envs/pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: envs
spec:
  containers:
  - name: sise
    image: quay.io/openshiftlabs/simpleservice:0.5.0
    ports:
    - containerPort: 9876
    env:
    - name: SIMPLE_SERVICE_VERSION
      value: "1.0"

-get pods
NAME   READY   STATUS    RESTARTS   AGE
envs   1/1     Running   0          18s

-get ip of the pod
kubectl describe pod envs | grep IP:
IP:           172.17.0.2
  IP:  172.17.0.2

-get env variables
curl 172.17.0.2:9876/env

-or using kubectl exec get envrionment variables
kubectl exec envs -- printenv
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=envs
SIMPLE_SERVICE_VERSION=1.0
THESVC_PORT_80_TCP=tcp://10.96.131.150:80
THESVC_PORT_80_TCP_ADDR=10.96.131.150
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
MY_SERVICE_PORT_8080_TCP_PORT=8080
THESVC_SERVICE_PORT=80
THESVC_SERVICE_HOST=10.96.131.150
THESVC_PORT=tcp://10.96.131.150:80
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
MY_SERVICE_SERVICE_HOST=10.102.152.99
MY_SERVICE_PORT_8080_TCP_ADDR=10.102.152.99
KUBERNETES_PORT=tcp://10.96.0.1:443
MY_SERVICE_SERVICE_PORT=8080
MY_SERVICE_PORT_8080_TCP=tcp://10.102.152.99:8080
MY_SERVICE_PORT_8080_TCP_PROTO=tcp
THESVC_PORT_80_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
MY_SERVICE_PORT=tcp://10.102.152.99:8080
THESVC_PORT_80_TCP_PORT=80
LANG=C.UTF-8
GPG_KEY=C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF
PYTHON_VERSION=2.7.13
PYTHON_PIP_VERSION=9.0.1
REFRESHED_AT=2017-04-24T13:50
HOME=/root

-destroy pods
kubectl delete pod/envs
