>vi pizza-deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pizza-deployment
  namespace: pizza
spec:
  replicas: 3
  selector:
    matchLabels:
      app: pizza
  template:
    metadata:
      labels:
        app: pizza
    spec:
      containers:
      - name: pizza
        image: linuxacademycontent/pizza-service:1.14.6
        command: ["nginx"]
        args: ["-g", "daemon off;"]
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
        readinessProbe:
          httpGet:
            path: /
            port: 80

>kubectl apply -f pizza-deployment.yml

>vi pizza-service.yml
apiVersion: v1
kind: Service
metadata:
  name: pizza-service
  namespace: pizza
spec:
  type: NodePort
  selector:
    app: pizza
  ports:
  - protocol: TCP
    port: 80
    nodePort: 30080

>kubectl apply -f pizza-service.yml

>kubectl get deploy -n pizza
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
pizza-deployment   3/3     3            3           7m54s

>kubectl get svc -n pizza
NAME            TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
pizza-service   NodePort   10.104.252.134   <none>        80:30080/TCP   7m39s

>kubectl get ep pizza-service -n pizza
NAME            ENDPOINTS                                   AGE
pizza-service   10.244.1.4:80,10.244.2.2:80,10.244.2.3:80   9m27s

>curl localhost:30080
{
  "description": "A list of pizza toppings.",
  "pizzaToppings": [
    "anchovies",
    "artichoke",
    "bacon",
    "breakfast bacon",
    "Canadian bacon",
    "cheese",
    "chicken",
    "chili peppers",
    "feta",
    "garlic",
    "green peppers",
    "grilled onions",
    "ground beef",
    "ham",
    "hot sauce",
    "meatballs",
    "mushrooms",
    "olives",
    "onions",
    "pepperoni",
    "pineapple",
    "sausage",
    "spinach",
    "sun-dried tomato",
    "tomatoes"
  ]
}
