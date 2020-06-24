source <(kubectl completion bash)

echo "source <(kubectl completion bash)" >> ~/.bashrc

https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete

>kubectl get pods -n kube-system
>kubectl get pod -n kube-system

>kubectl get pods -n kube-system kube-controller-manager-minikube

-do it with root user sudo -
-pay attention to which kubernetes cluster you are using
-kubetcl config use-context nk8s (you should use this to switch clusters)
