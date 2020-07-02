-create services
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/rc.yaml
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/svc.yaml

-create another pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/jumpod.yaml

-test if you can connect service
kubectl exec -it jumpod -c shell -- ping thesvc.default.svc.cluster.local

-add namespaces
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-ns.yaml
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-rc.yaml
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/sd/other-svc.yaml

-consume a service using jumpod
kubectl exec -it jumpod -c shell -- curl http://thesvc.other/info

-delete resources
kubectl delete pods jumpod
kubectl delete svc thesvc
kubectl delete rc rcsise
-if you delete a namespace, it will destroy all the resources in namespace
kubectl delete ns other
