>kubectl get pods
NAME                                        READY   STATUS    RESTARTS   AGE
customer-data-deployment-75666b856f-nj64q   1/1     Running   0          102m
customer-data-deployment-75666b856f-qr7g7   1/1     Running   0          102m
inventory-deployment-596bbfffdb-4rm2c       1/1     Running   0          102m
inventory-deployment-596bbfffdb-6fqgp       1/1     Running   0          102m
web-gateway                                 1/1     Running   0          102m

#get network policies
>kubectl get networkpolicy
NAME                   POD-SELECTOR        AGE
customer-data-policy   app=customer-data   91m
inventory-policy       app=inventory       91m

#examine inventory-policy
>kubectl describe networkpolicy inventory-policy
Name:         inventory-policy
Namespace:    default
Created on:   2020-06-15 16:40:17 +0000 UTC
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"networking.k8s.io/v1","kind":"NetworkPolicy","metadata":{"annotations":{},"name":"inventory-policy","namespace":"default"},...
Spec:
  PodSelector:     app=inventory
  Allowing ingress traffic:
    To Port: 80/TCP
    From:
      PodSelector: inventory-access=true
  Allowing egress traffic:
    To Port: 80/TCP
    To:
      PodSelector: inventory-access=true
  Policy Types: Ingress, Egress

#modify web-gateway pop and add label inventory-access=true
>kubectl edit pod web-gateway
#inventory-access: "true"

#test access
>kubectl exec web-gateway -- curl -m 3 inventory-svc
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0  14689      0 --:--:-- --:--:-- --:--:-- 23538
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

#examine customer-data-policy
>kubectl describe networkpolicy customer-data-policy
Name:         customer-data-policy
Namespace:    default
Created on:   2020-06-15 16:40:17 +0000 UTC
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"networking.k8s.io/v1","kind":"NetworkPolicy","metadata":{"annotations":{},"name":"customer-data-policy","namespace":"defaul..."
Spec:
  PodSelector:     app=customer-data
  Allowing ingress traffic:
    To Port: 80/TCP
    From:
      PodSelector: customer-data-access=true
  Allowing egress traffic:
    To Port: 80/TCP
    To:
      PodSelector: customer-data-access=true
  Policy Types: Ingress, Egress

#modify web-gateway
>kubectl edit pod web-gateway
#add customer-data-access: "true"

#test access to the customer-data-svc
>kubectl exec web-gateway -- curl -m 3 customer-data-svc
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:-100   612  100   612    0     0   6623      0 --:--:-- --:--:-- --:--:--  199k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
