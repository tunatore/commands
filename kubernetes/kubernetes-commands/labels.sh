-run a container using yaml
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/labels/pod.yaml
kubectl get pods --show-labels
NAME                                 READY   STATUS    RESTARTS   AGE
labelex                              1/1     Running   0          9s
nginx-deployment-5bf87f5f59-5cjrx    1/1     Running   0          16m
nginx-deployment-5bf87f5f59-n9tch    1/1     Running   0          16m
nginx-deployment-5bf87f5f59-zxsgz    1/1     Running   0          16m
rolling-deployment-7f76fc567-265s7   1/1     Running   0          16m
rolling-deployment-7f76fc567-kncwc   1/1     Running   0          16m
rolling-deployment-7f76fc567-ppthv   1/1     Running   0          16m

-display pods with labels
kubectl get pods --show-labels
NAME                                 READY   STATUS    RESTARTS   AGE   LABELS
labelex                              1/1     Running   0          65s   env=development
nginx-deployment-5bf87f5f59-5cjrx    1/1     Running   0          17m   app=nginx,pod-template-hash=5bf87f5f59
nginx-deployment-5bf87f5f59-n9tch    1/1     Running   0          17m   app=nginx,pod-template-hash=5bf87f5f59
nginx-deployment-5bf87f5f59-zxsgz    1/1     Running   0          17m   app=nginx,pod-template-hash=5bf87f5f59
rolling-deployment-7f76fc567-265s7   1/1     Running   0          17m   app=nginx,pod-template-hash=7f76fc567
rolling-deployment-7f76fc567-kncwc   1/1     Running   0          17m   app=nginx,pod-template-hash=7f76fc567
rolling-deployment-7f76fc567-ppthv   1/1     Running   0          17m   app=nginx,pod-template-hash=7f76fc567

-add a label to the pod
kubectl label pods labelex owner=michael

-get pods all labels
kubectl get pods --show-label
NAME                                 READY   STATUS    RESTARTS   AGE   LABELS
labelex                              1/1     Running   0          98s   env=development,owner=michael
nginx-deployment-5bf87f5f59-5cjrx    1/1     Running   0          18m   app=nginx,pod-template-hash=5bf87f5f59
nginx-deployment-5bf87f5f59-n9tch    1/1     Running   0          18m   app=nginx,pod-template-hash=5bf87f5f59
nginx-deployment-5bf87f5f59-zxsgz    1/1     Running   0          18m   app=nginx,pod-template-hash=5bf87f5f59
rolling-deployment-7f76fc567-265s7   1/1     Running   0          18m   app=nginx,pod-template-hash=7f76fc567
rolling-deployment-7f76fc567-kncwc   1/1     Running   0          18m   app=nginx,pod-template-hash=7f76fc567
rolling-deployment-7f76fc567-ppthv   1/1     Running   0          18m   app=nginx,pod-template-hash=7f76fc567

-label filtering use either --selector or -l
kubectl get pods --selector owner=michael
NAME      READY   STATUS    RESTARTS   AGE
labelex   1/1     Running   0          2m57s

kubectl get pods -l env=development
NAME      READY   STATUS    RESTARTS   AGE
labelex   1/1     Running   0          3m12s

-launch another pod
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/labels/anotherpod.yaml

-get pods
kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
labelex                              1/1     Running   0          5m50s
labelexother                         1/1     Running   0          6s
nginx-deployment-5bf87f5f59-5cjrx    1/1     Running   0          22m
nginx-deployment-5bf87f5f59-n9tch    1/1     Running   0          22m
nginx-deployment-5bf87f5f59-zxsgz    1/1     Running   0          22m
rolling-deployment-7f76fc567-265s7   1/1     Running   0          22m
rolling-deployment-7f76fc567-kncwc   1/1     Running   0          22m
rolling-deployment-7f76fc567-ppthv   1/1     Running   0          22m

-get labels
kubectl get pods --show-labels
NAME                                 READY   STATUS    RESTARTS   AGE     LABELS
labelex                              1/1     Running   0          6m59s   env=development,owner=michael
labelexother                         1/1     Running   0          75s     env=production,owner=michael
nginx-deployment-5bf87f5f59-5cjrx    1/1     Running   0          23m     app=nginx,pod-template-hash=5bf87f5f59
nginx-deployment-5bf87f5f59-n9tch    1/1     Running   0          23m     app=nginx,pod-template-hash=5bf87f5f59
nginx-deployment-5bf87f5f59-zxsgz    1/1     Running   0          23m     app=nginx,pod-template-hash=5bf87f5f59
rolling-deployment-7f76fc567-265s7   1/1     Running   0          23m     app=nginx,pod-template-hash=7f76fc567
rolling-deployment-7f76fc567-kncwc   1/1     Running   0          23m     app=nginx,pod-template-hash=7f76fc567
rolling-deployment-7f76fc567-ppthv   1/1     Running   0          23m     app=nginx,pod-template-hash=7f76fc567

-set based selector
kubectl get pods -l 'env in (production, development)'
NAME           READY   STATUS    RESTARTS   AGE
labelex        1/1     Running   0          7m18s
labelexother   1/1     Running   0          94s

-delete pods with label production and development
kubectl delete pods -l 'env in (production, development)'

-or you can delete them via their name
kubectl delete pods labelex
kubectl delete pods labelexother
