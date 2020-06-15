>kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
candy-deployment   2/2     2            2           9m45s

#update the deployment to the new version
>kubectl set image deployment/candy-deployment candy-ws=linuxacademycontent/candy-service:3 --record

#check the progress of the rolling update to a new version
>kubectl rollout status deployment/candy-deployment
Waiting for deployment "candy-deployment" rollout to finish: 1 out of 2 new replicas have been updated...

#get a list og previous revisions
>kubectl rollout history deployment/candy-deployment
kubectl rollout history deployment/candy-deployment
deployment.extensions/candy-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl set image deployment/candy-deployment candy-ws=linuxacademycontent/candy-service:3 --record=true

#undo the last revision
>kubectl rollout undo deployment/candy-deployment

#check the status of the rollout
>kubectl rollout status deployment/candy-deployment
deployment "candy-deployment" successfully rolled out

>kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
candy-deployment-6d655874b4-5h94z   1/1     Running   0          8m38s
candy-deployment-6d655874b4-cqxb8   1/1     Running   0          8m38s
