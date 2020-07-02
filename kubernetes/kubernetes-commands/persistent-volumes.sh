-create a persistent volume
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/pv.yaml

-create a persistent volume claim
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/pvc.yaml

-get persistent volume claim
kubectl get pvc
NAME      STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS    AGE
my-pvc    Bound    my-pv    1Gi        RWO            local-storage   24d
myclaim   Bound    pv0001   5Gi        RWO            standard        25s

-create a deployment that uses persistent volume claim
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/pv/deploy.yaml

-get pods
kubectl get po
NAME                         READY   STATUS    RESTARTS   AGE
pv-deploy-6bd44744c4-drl26   1/1     Running   0          28s

-exec into pod and store data in persistent volume - /tmp/persistent/
kubectl exec -it pv-deploy-6bd44744c4-drl26 -- bash
[root@pv-deploy-6bd44744c4-drl26 /]# touch /tmp/persistent/data
[root@pv-deploy-6bd44744c4-drl26 /]# ls /tmp/persistent/
data

--delete the pod and create another one
kubectl delete po pv-deploy-6bd44744c4-drl26

-get pods
kubectl get po
NAME                         READY   STATUS    RESTARTS   AGE
pv-deploy-6bd44744c4-xsjk9   1/1     Running   0          34s

-exec command in pod
kubectl exec -it pv-deploy-6bd44744c4-xsjk9 -- bash
[root@pv-deploy-6bd44744c4-xsjk9 /]# ls /tmp/persistent/
data

-delete persistent volume claim
kubectl delete pvc myclaim
