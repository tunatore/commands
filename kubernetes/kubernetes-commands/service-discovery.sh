-create services
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/rc.yaml

apiVersion: v1
kind: ReplicationController
metadata:
  name: rcsise
spec:
  replicas: 2
  selector:
    app: sise
  template:
    metadata:
      name: somename
      labels:
        app: sise
    spec:
      containers:
      - name: sise
        image: quay.io/openshiftlabs/simpleservice:0.5.0
        ports:
        - containerPort: 9876

kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/svc.yaml

apiVersion: v1
kind: Service
metadata:
  name: thesvc
spec:
  ports:
    - port: 80
      targetPort: 9876
  selector:
    app: sise

-create another pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/jumpod.yaml

apiVersion:   v1
kind:         Pod
metadata:
  name:       jumpod
spec:
  containers:
  - name:     shell
    image:    centos:7
    command:
      - "bin/bash"
      - "-c"
      - "sleep 10000"

-test if you can connect service
kubectl exec -it jumpod -c shell -- ping thesvc.default.svc.cluster.local

-add namespaces
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-ns.yaml

apiVersion: v1
kind: Namespace
metadata:
  name: other

kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-rc.yaml

apiVersion: v1
kind: ReplicationController
metadata:
  name: rcsise
  namespace: other
spec:
  replicas: 2
  selector:
    app: sise
  template:
    metadata:
      name: somename
      labels:
        app: sise
    spec:
      containers:
      - name: sise
        image: quay.io/openshiftlabs/simpleservice:0.5.0
        ports:
        - containerPort: 9876

kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-svc.yaml

apiVersion: v1
kind: Service
metadata:
  name: thesvc
  namespace: other
spec:
  ports:
    - port: 80
      targetPort: 9876
  selector:
    app: sise

-consume a service using jumpod
kubectl exec -it jumpod -c shell -- curl http://thesvc.other/info

-delete resources
kubectl delete pods jumpod
kubectl delete svc thesvc
kubectl delete rc rcsise
-if you delete a namespace, it will destroy all the resources in namespace
kubectl delete ns other
