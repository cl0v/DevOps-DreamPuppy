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

