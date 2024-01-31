#!/bin/bash

echo "> Creating secrets to download private registries"
# Add variables to the shell (WARNING: This shouldn't be used at cloud services)
DOCKER_REGISTRY_SERVER=https://index.docker.io/v1/
DOCKER_USER=vianagallery
DOCKER_PASSWORD=dckr_pat_5eGuYnTjta7PWebXtmh5wjwl450
DOCKER_EMAIL=marcelo.ita.boss@gmail.com

# Create the regcred secret (WARNING: This shouldn't be used at cloud services)
kubectl create secret docker-registry regcred --docker-server=$DOCKER_REGISTRY_SERVER --docker-username=$DOCKER_USER --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL

