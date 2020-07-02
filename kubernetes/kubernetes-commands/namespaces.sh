-get namespaces
kubectl get ns
NAME                   STATUS        AGE
default                Active        50d
kube-node-lease        Active        50d
kube-public            Active        50d
kube-system            Active        50d
kubernetes-dashboard   Active        31d
my-ns                  Terminating   26d
nginx-ns               Active        20d

-describe a namespace
kubectl describe ns default
Name:         default
Labels:       <none>
Annotations:  <none>
Status:       Active

No resource quota.

No LimitRange resource.

-create a new namespace
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ns/ns.yaml

apiVersion: v1
kind: Namespace
metadata:
  name: test

-kubectl get ns
NAME                   STATUS        AGE
default                Active        50d
kube-node-lease        Active        50d
kube-public            Active        50d
kube-system            Active        50d
kubernetes-dashboard   Active        31d
my-ns                  Terminating   26d
nginx-ns               Active        20d

-create a namespace
kubectl create namespace test

-get namespaces
kubectl get ns
NAME                   STATUS        AGE
default                Active        50d
kube-node-lease        Active        50d
kube-public            Active        50d
kube-system            Active        50d
kubernetes-dashboard   Active        31d
my-ns                  Terminating   26d
nginx-ns               Active        20d
test                   Active        4s

-create a pod in a namespace
kubectl apply --namespace=test -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ns/pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: podintest
spec:
  containers:
  - name: sise
    image: quay.io/openshiftlabs/simpleservice:0.5.0
    ports:
    - containerPort: 9876

-get pods in a namespace
kubectl get pods --namespace=test
NAME        READY   STATUS    RESTARTS   AGE
podintest   1/1     Running   0          62s

-delete a namespace
kubectl delete ns test
