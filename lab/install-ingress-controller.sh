#!/bin/bash

# Waiting for Ingress controller to be ready...
echo "> Waiting for Ingress controller to be ready..."
sleep 10

while ! kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s; do
    echo "Ingress controller is not ready yet. Retrying ..."
done

echo "Ingress controller is now ready."

# Cria um recurso ingress
kubectl apply -f cluster/ingress.yaml
