>vi my-nginx-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: my-nginx-pod
  namespace: web
spec:
  containers:
  - name: my-nginx-container
    image: nginx
    command: ["nginx"]
    args: ["-g", "daemon off;", "-q"]
    ports:
    - containerPort: 80

>kubectl create -f my-nginx-pod.yml
>kubectl get pods -n web
>kubectl delete pod my-nginx-pod -n web
>kubectl logs my-nginx-pod -n web
>kubectl describe pod nginx -n web
>kubectl get namespaces
