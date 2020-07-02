-create a pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: logme
spec:
  containers:
  - name: gen
    image: centos:7
    command:
      - "bin/bash"
      - "-c"
      - "while true; do echo $(date) | tee /dev/stderr; sleep 1; done"

-get pods
kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
logme   1/1     Running   0          42s

-get logs for logme pod and gen container
kubectl logs --tail=5 logme -c gen
Thu Jul 2 15:02:13 UTC 2020
Thu Jul 2 15:02:14 UTC 2020
Thu Jul 2 15:02:14 UTC 2020
Thu Jul 2 15:02:15 UTC 2020
Thu Jul 2 15:02:15 UTC 2020

-stream logs like tail -f
kubectl logs -f --since=10s logme -c gen
Thu Jul 2 15:03:10 UTC 2020
Thu Jul 2 15:03:10 UTC 2020
Thu Jul 2 15:03:11 UTC 2020
Thu Jul 2 15:03:11 UTC 2020
Thu Jul 2 15:03:12 UTC 2020
Thu Jul 2 15:03:12 UTC 2020
Thu Jul 2 15:03:13 UTC 2020
Thu Jul 2 15:03:13 UTC 2020
Thu Jul 2 15:03:14 UTC 2020
Thu Jul 2 15:03:14 UTC 2020
Thu Jul 2 15:03:15 UTC 2020
Thu Jul 2 15:03:15 UTC 2020

-create another pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/logging/oneshotpod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: oneshot
spec:
  containers:
  - name: gen
    image: centos:7
    command:
      - "bin/bash"
      - "-c"
      - "for i in 9 8 7 6 5 4 3 2 1 ; do echo $i ; done"

-get previous log of a container
kubectl logs -p oneshot -c gen
9
8
7
6
5
4
3
2
1

-remove the created pods
kubectl delete pod/logme pod/oneshot
