>vi ~/candy-service-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: candy-service
spec:
  containers:
  - name: candy-service
    image: linuxacademycontent/candy-service:2
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8081
    readinessProbe:
      httpGet:
        path: /
        port: 80

>kubectl apply -f ~/candy-service-pod.yml
