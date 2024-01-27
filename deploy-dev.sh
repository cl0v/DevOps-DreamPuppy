#!/bin/bash

# Deploy Pods
kubectl apply -f cluster/pods/deployments/

# Serve Pods (Export)
kubectl apply -f cluster/services/

# Add variables to the shell (WARNING: This shouldn't be used at cloud services)
export DOCKER_REGISTRY_SERVER=https://index.docker.io/v1/
export DOCKER_USER=vianagallery
export DOCKER_PASSWORD=dckr_pat_5eGuYnTjta7PWebXtmh5wjwl450
export DOCKER_EMAIL=marcelo.ita.boss@gmail.com

# Create the regcred secret (WARNING: This shouldn't be used at cloud services)
kubectl create secret docker-registry regcred --docker-server=$DOCKER_REGISTRY_SERVER --docker-username=$DOCKER_USER --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL

# Install Ingress-controller-nginx [https://kubernetes.github.io/ingress-nginx/deploy/#rancher-desktop]
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# Interval to inject commands after setup
sleep 10

# Wait for the Ingress controller to be ready
echo "Waiting for Ingress controller to be ready..."
while ! kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=300s; do
    echo "Ingress controller is not ready yet. Retrying in 10 seconds..."
    sleep 10
done

echo "Ingress controller is now ready."

# Cria um recurso ingress
kubectl apply -f cluster/ingress.yaml

# Direciona a porta para localhost:8080 [WARNING: Port-forwarding is not for a production environment use-case]
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80

# Verfica conexão com o pod
echo "Validando conexão: "
curl --resolve dev.dreampuppy.com:8080:127.0.0.1 http://dev.dreampuppy.com:8080

