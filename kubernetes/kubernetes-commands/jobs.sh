-create a job called countdown
kubectl apply -f https://raw.githubusercontent.com/openshift-evangelists/kbe/master/specs/jobs/job.yaml

apiVersion: batch/v1
kind: Job
metadata:
  name: countdown
spec:
  template:
    metadata:
      name: countdown
    spec:
      containers:
      - name: counter
        image: centos:7
        command:
         - "bin/bash"
         - "-c"
         - "for i in 9 8 7 6 5 4 3 2 1 ; do echo $i ; done"
      restartPolicy: Never

-get jobs
kubectl get jobs
NAME        COMPLETIONS   DURATION   AGE
countdown   1/1           1s         23s
pi          1/1           113s       20d

-get pods
kubectl get pods
NAME              READY   STATUS      RESTARTS   AGE
countdown-pbjkp   0/1     Completed   0          47s

-describe the status of job
Name:           countdown
Namespace:      default
Selector:       controller-uid=47a358d5-ebd5-4209-839e-afd0a10b414a
Labels:         controller-uid=47a358d5-ebd5-4209-839e-afd0a10b414a
                job-name=countdown
Annotations:    Parallelism:  1
Completions:    1
Start Time:     Thu, 02 Jul 2020 19:04:08 +0200
Completed At:   Thu, 02 Jul 2020 19:04:09 +0200
Duration:       1s
Pods Statuses:  0 Running / 1 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=47a358d5-ebd5-4209-839e-afd0a10b414a
           job-name=countdown
  Containers:
   counter:
    Image:      centos:7
    Port:       <none>
    Host Port:  <none>
    Command:
      bin/bash
      -c
      for i in 9 8 7 6 5 4 3 2 1 ; do echo $i ; done
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  76s   job-controller  Created pod: countdown-pbjkp
  Normal  Completed         75s   job-controller  Job completed

-get logs
kubectl logs countdown-pbjkp
9
8
7
6
5
4
3
2
1

-delete all job resources
kubectl delete job countdown
