#To see the environment inside the pods
kubectl exec -it gokubernetes-d8d4f998f-sqcnc -- printenv

#To get the Config Maps
kubectl get cm

#To get the pod shell
kubectl exec -it gokubernetes-5b49c96b7c-qq457 -- sh
