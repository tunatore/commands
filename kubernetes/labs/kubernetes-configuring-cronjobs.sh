>vi ~/cleanup-cronjob.yml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: cleanup-cronjob
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: data-cleanup
            image: linuxacademycontent/data-cleanup:1
          restartPolicy: OnFailure

>kubectl apply -f ~/cleanup-cronjob.yml

>kubectl get cronjob cleanup-cronjob
NAME              SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
cleanup-cronjob   */1 * * * *   False     0        <none>          25s

#active: 1 means cronjob is running
>kubectl get cronjob cleanup-cronjob
NAME              SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
cleanup-cronjob   */1 * * * *   False     1        11s             109s
