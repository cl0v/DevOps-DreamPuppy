#!/bin/bash

echo "> Forwarding Port"

while ! kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=30s; do
    echo "Ingress controller is not ready yet. Retrying in 10 seconds..."
    sleep 8
done

# Direciona a porta para localhost:8080 [WARNING: Port-forwarding is not for a production environment use-case]
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80 
