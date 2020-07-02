-create init container
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/ic/deploy.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic
  template:
    metadata:
      labels:
        app: ic
    spec:
      initContainers:
      - name: msginit
        image: centos:7
        command:
        - "bin/bash"
        - "-c"
        - "echo INIT_DONE > /ic/this"
        volumeMounts:
        - mountPath: /ic
         name: msg
        containers:
        - name: main
          image: centos:7
          command:
          - "bin/bash"
          - "-c"
          - "while true; do cat /ic/this; sleep 5; done"
          volumeMounts:
          - mountPath: /ic
            name: msg
        volumes:
        - name: msg
          emptyDir: {}

-get deployment and pods
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ic-deploy   1/1     1            1           38s

NAME                            READY   STATUS    RESTARTS   AGE
pod/ic-deploy-5fbc98df8-77prr   1/1     Running   0          38s
pod/mehdb-0                     1/1     Running   0          44m
pod/mehdb-1                     1/1     Running   0          43m

-get logs
kubectl logs pod/ic-deploy-5fbc98df8-77prr
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
INIT_DONE
