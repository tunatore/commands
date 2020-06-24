>vi candy-service-config.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: candy-service-config
data:
  candy.cfg: |-
    candy.peppermint.power=100000000
    candy.nougat-armor.strength=10

#candy.fg is the name of the file under folder.

>kubectl apply -f candy-service-config.yml

>vi db-password-secret.yml
apiVersion: v1
kind: Secret
metadata:
  name: db-password
stringData:
  password: Kub3rn3t3sRul3s!

>kubectl apply -f db-password-secret.yml

>vi candy-service-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: candy-service
spec:
  securityContext:
    fsGroup: 2000
  serviceAccountName: candy-svc
  containers:
  - name: candy-service
    image: linuxacademycontent/candy-service:1
    volumeMounts:
      - name: config-volume
        mountPath: /etc/candy-service
    env:
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-password
          key: password
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
  volumes:
  - name: config-volume
    configMap:
      name: candy-service-config

>kubectl apply -f candy-service-pod.yml

>kubectl get pod candy-service
