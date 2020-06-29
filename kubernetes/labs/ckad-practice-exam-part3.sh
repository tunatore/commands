>sudo -i

>kubectl describe service oauth-provider -n gem
Name:                     oauth-provider
Namespace:                gem
Labels:                   <none>
Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                            {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"oauth-provider","namespace":"gem"},"spec":{"ports":[{"nodePort":3...
Selector:                 role=oauth
Type:                     NodePort
IP:                       10.109.152.153
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

>kubectl get pods --all-namespaces --show-labels
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE    LABELS
gem           bowline                                 0/1     ImagePullBackOff   0          107m   role=oauth
gem           hitch                                   0/1     ImagePullBackOff   0          107m   role=ws
kube-system   coredns-54ff9cd656-hfcfh                1/1     Running            0          107m   k8s-app=kube-dns,pod-template-hash=54ff9cd656
kube-system   coredns-54ff9cd656-zmr74                1/1     Running            0          107m   k8s-app=kube-dns,pod-template-hash=54ff9cd656
kube-system   etcd-ip-10-0-1-101                      1/1     Running            0          106m   component=etcd,tier=control-plane
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running            0          106m   component=kube-apiserver,tier=control-plane
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running            0          106m   component=kube-controller-manager,tier=control-plane
kube-system   kube-flannel-ds-amd64-5v7nw             1/1     Running            0          107m   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-flannel-ds-amd64-mspl5             1/1     Running            0          107m   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-flannel-ds-amd64-xsv8v             1/1     Running            0          107m   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-proxy-58gs9                        1/1     Running            0          107m   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-proxy-5dvb9                        1/1     Running            0          107m   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-proxy-snjz7                        1/1     Running            0          107m   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running            0          106m   component=kube-scheduler,tier=control-plane
pebble        square                                  1/1     Running            0          107m   role=db

>vi /usr/ckad/broken-object-name.txt

>kubectl get pod bowline -n gem -o json > /usr/ckad/broken-object.json
Last login: Sun Jun 28 11:45:24 on ttys002
[oh-my-zsh] Random theme 'skaro' loaded
893 ~  » ssh cloud_user@35.172.222.71
The authenticity of host '35.172.222.71 (35.172.222.71)' can't be established.
ECDSA key fingerprint is SHA256:DDnbug+eE0TYHHrpTZCk72eVpQcdviCE+F9vkcirTLc.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '35.172.222.71' (ECDSA) to the list of known hosts.
Password:
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.15.0-1065-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Jun 28 09:45:50 UTC 2020

  System load:  0.07               Processes:              121
  Usage of /:   19.7% of 19.32GB   Users logged in:        0
  Memory usage: 19%                IP address for ens5:    10.0.1.101
  Swap usage:   0%                 IP address for docker0: 172.17.0.1

 * "If you've been waiting for the perfect Kubernetes dev solution for
   macOS, the wait is over. Learn how to install Microk8s on macOS."

   https://www.techrepublic.com/article/how-to-install-microk8s-on-macos/

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

33 packages can be updated.
0 updates are security updates.


*** System restart required ***

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

cloud_user@ip-10-0-1-101:~$ sudo -i
[sudo] password for cloud_user:
root@ip-10-0-1-101:~# kubectl describe service oauth-provider -n gem
Name:                     oauth-provider
Namespace:                gem
Labels:                   <none>
Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                            {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"oauth-provider","namespace":"gem"},"spec":{"ports":[{"nodePort":3...
Selector:                 role=oauth
Type:                     NodePort
IP:                       10.109.152.153
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
root@ip-10-0-1-101:~# kubectl get pods --all-namespaces --show-labels
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE    LABELS
gem           bowline                                 0/1     ImagePullBackOff   0          107m   role=oauth
gem           hitch                                   0/1     ImagePullBackOff   0          107m   role=ws
kube-system   coredns-54ff9cd656-hfcfh                1/1     Running            0          107m   k8s-app=kube-dns,pod-template-hash=54ff9cd656
kube-system   coredns-54ff9cd656-zmr74                1/1     Running            0          107m   k8s-app=kube-dns,pod-template-hash=54ff9cd656
kube-system   etcd-ip-10-0-1-101                      1/1     Running            0          106m   component=etcd,tier=control-plane
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running            0          106m   component=kube-apiserver,tier=control-plane
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running            0          106m   component=kube-controller-manager,tier=control-plane
kube-system   kube-flannel-ds-amd64-5v7nw             1/1     Running            0          107m   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-flannel-ds-amd64-mspl5             1/1     Running            0          107m   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-flannel-ds-amd64-xsv8v             1/1     Running            0          107m   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-proxy-58gs9                        1/1     Running            0          107m   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-proxy-5dvb9                        1/1     Running            0          107m   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-proxy-snjz7                        1/1     Running            0          107m   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running            0          106m   component=kube-scheduler,tier=control-plane
pebble        square                                  1/1     Running            0          107m   role=db
root@ip-10-0-1-101:~# vi /usr/ckad/broken-object-name.txt
root@ip-10-0-1-101:~# kubectl get pod bowline -n gem -o json > /usr/ckad/broken-object.json
root@ip-10-0-1-101:~# vi /usr/ckad/broken-object.json

                "lastTransitionTime": "2020-06-28T08:03:30Z",
                "message": "containers with unready status: [nginx]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2020-06-28T08:03:31Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "image": "ninx:1.15.9",
                "imageID": "",
                "lastState": {},
                "name": "nginx",
                "ready": false,
                "restartCount": 0,
                "state": {
                    "waiting": {
                        "message": "Back-off pulling image \"ninx:1.15.9\"",
                        "reason": "ImagePullBackOff"
                    }
                }
            }
        ],
        "hostIP": "10.0.1.102",
        "phase": "Pending",
        "podIP": "10.244.1.6",
        "qosClass": "BestEffort",
        "startTime": "2020-06-28T08:03:30Z"
    }

>kubectl describe pod bowline -n gem

>kubectl edit pod bowline -n gem

>kubectl get pod bowline -n gem
NAME      READY   STATUS    RESTARTS   AGE
bowline   1/1     Running   0          111m

>curl localhost:30080
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
