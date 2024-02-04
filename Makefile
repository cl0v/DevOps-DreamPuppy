del-cluster:
	k3d cluster delete dev

new-cluster:
	k3d cluster create dev

config-cluster:
	./lab/docker-login-secret.sh 

apply:
	./lab/apply-kube-files.sh
