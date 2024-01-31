#!/bin/bash

echo "> Applying Kubes"

# Deploy Pods
kubectl apply -f cluster/pods/deployments/

# Deploy PV and PVCS
kubectl apply -f cluster/pods/storages/

# Serve Pods (Export)
kubectl apply -f cluster/services/

# Deploy ingress controller with nginx [https://kubernetes.github.io/ingress-nginx/deploy/#rancher-desktop]
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

