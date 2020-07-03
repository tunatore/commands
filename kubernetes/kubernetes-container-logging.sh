https://kubernetes.io/docs/concepts/cluster-administration/logging/

>vi counter.yml
apiVersion: v1
kind: Pod
metadata:
  name: counter
spec:
  containers:
  - name: count
    image: busybox
    args: [/bin/sh, -c, 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']

>kubectl apply -f counter.yml
>kubectl get pods

>kubectl logs counter

#multi container pod
>kubectl logs <pod-name> -c <container-name>
>kubectl logs counter -c count
>kubectl logs counter > counter.log
