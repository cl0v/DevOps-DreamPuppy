# del-cluster:
# 	k3d cluster delete dev

# new-cluster:
# 	k3d cluster create dev

# config-cluster:
# 	./lab/docker-login-secret.sh 

# apply:
# 	./lab/apply-kube-files.sh

delete-pod:
	kubectl delete po ${pod}

get-pods:
	kubectl get pods

output-dep:
	kubectl get deployment ${dep} --output=yaml

describe-pod:
	kubectl describe po ${pod} 
log-pod:
	kubectl logs ${pod} 