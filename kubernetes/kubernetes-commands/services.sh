-create services
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/services/rc.yaml
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/services/svc.yaml

-get pods
kubectl get pods -l app=sise
NAME           READY   STATUS    RESTARTS   AGE
rcsise-wmxfd   1/1     Running   0          68s

-describe pod and get the ip
kubectl describe pod rcsise-wmxfd

-test if you can access the pod using ip within cluster - ips assigned to pods might change
curl 172.17.0.5:9876/info

-get services
kubectl get svc
NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP    50d
my-service      ClusterIP   10.102.152.99    <none>        8080/TCP   19d
simpleservice   ClusterIP   10.106.180.116   <none>        80/TCP     79s
thesvc          ClusterIP   10.96.131.150    <none>        80/TCP     9m17s

-describe a service
kubectl describe svc simpleservice
Name:              simpleservice
Namespace:         default
Labels:            <none>
Annotations:       Selector:  app=sise
Type:              ClusterIP
IP:                10.106.180.116
Port:              <unset>  80/TCP
TargetPort:        9876/TCP
Endpoints:         172.17.0.5:9876
Session Affinity:  None
Events:            <none>

-access service
curl 172.17.0.5:80/info

-ip forwarding done through iptables
sudo iptables-save | grep simpleservice

-add a second pod and scale pod
kubectl scale --replicas=2 rc/rcsise

-get pods
kubectl get pods -l app=sise
NAME           READY   STATUS    RESTARTS   AGE
rcsise-hfl8z   1/1     Running   0          7s
rcsise-wmxfd   1/1     Running   0          3m16s

-check again ip tables
sudo iptables-save | grep simpleservice

-delete services
kubectl delete svc simpleservice
-delete replica set; if you delete a replicaset, it also deletes pods
kubectl delete rc rcsise
