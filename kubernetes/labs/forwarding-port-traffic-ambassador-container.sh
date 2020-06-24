>fruit-service-ambassador-config.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fruit-service-ambassador-config
data:
  haproxy.cfg: |-
    global
        daemon
        maxconn 256

    defaults
        mode http
        timeout connect 5000ms
        timeout client 50000ms
        timeout server 50000ms

    listen http-in
        bind *:80
        server server1 127.0.0.1:8775 maxconn 32

>kubectl apply -f fruit-service-ambassador-config.yml

>vi fruit-service.yml
apiVersion: v1
kind: Pod
metadata:
  name: fruit-service
spec:
  containers:
  - name: legacy-fruit-service
    image: linuxacademycontent/legacy-fruit-service:1
  - name: haproxy-ambassador
    image: haproxy:1.7
    ports:
    - containerPort: 80
    volumeMounts:
    - name: config-volume
      mountPath: /usr/local/etc/haproxy
  volumes:
  - name: config-volume
    configMap:
      name: fruit-service-ambassador-config

>kubectl apply -f fruit-service.yml

>kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
fruit-service   2/2     Running   0          21s

>vi busybox.yml
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - name: myapp-container
    image: radial/busyboxplus:curl
    command: ['sh', '-c', 'while true; do sleep 3600; done']

>kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
busybox         1/1     Running   0          10s
fruit-service   2/2     Running   0          2m23s

>kubectl exec busybox -- curl $(kubectl get pod fruit-service -o=custom-columns=IP:.status.podIP --no-headers):80
{
  "description": "A list of fruits.",
  "fruits": [
    "apple",
    "apricot",
    "avocado",
    "banana",
    "bell pepper",
    "bilberry",
    "blackberry",
    "blackcurrant",
    "blood orange",
    "blueberry",
    "boysenberry",
    "breadfruit",
    "canary melon",
    "cantaloupe",
    "cherimoya",
    "cherry",
    "chili pepper",
    "clementine",
    "cloudberry",
    "coconut",
    "cranberry",
    "cucumber",
    "currant",
    "damson",
    "date",
    "dragonfruit",
    "durian",
    "eggplant",
    "elderberry",
    "feijoa",
    "fig",
    "goji berry",
    "gooseberry",
    "grape",
    "grapefruit",
    "guava",
    "honeydew",
    "huckleberry",
    "jackfruit",
    "jambul",
    "jujube",
    "kiwi fruit",
    "kumquat",
    "lemon",
    "lime",
    "loquat",
    "lychee",
    "mandarine",
    "mango",
    "mulberry",
    "nectarine",
    "nut",
    "olive",
    "orange",
    "pamelo",
    "papaya",
    "passionfruit",
    "peach",
    "pear",
    "persimmon",
    "physalis",
    "pineapple",
    "plum",
    "pomegranate",
    "pomelo",
    "purple mangosteen",
    "quince",
    "raisin",
    "rambutan",
    "raspberry",
    "redcurrant",
    "rock melon",
    "salal berry",
    "satsuma",
    "star fruit",
    "strawberry",
    "tamarillo",
    "tangerine",
    "tomato",
    "ugli fruit",
    "watermelon"
  ]
}
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1360  100  1360    0     0   370k      0 --:--:-- --:--:-- --:--:--  442k
