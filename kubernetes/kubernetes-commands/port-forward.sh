-create a service
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pf/app.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: sise-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sise
  template:
    metadata:
      labels:
        app: sise
    spec:
      containers:
      - name: sise
        image: quay.io/openshiftlabs/simpleservice:0.5.0
        ports:
        - containerPort: 9876

---
apiVersion: v1
kind: Service
metadata:
  name: simpleservice
spec:
  ports:
    - port: 80
      targetPort: 9876
  selector:
    app: sise


-forward port
kubectl port-forward service/simpleservice 8080:80
Forwarding from 127.0.0.1:8080 -> 9876
Forwarding from [::1]:8080 -> 9876
Handling connection for 8080

-invoke service
curl localhost:8080/info
{"host": "localhost:8080", "version": "0.5.0", "from": "127.0.0.1"}

-port forwarding is not meant for production but for development environment

-remove service
kubectl delete service/simpleservice
kubectl delete deployment sise-deploy
