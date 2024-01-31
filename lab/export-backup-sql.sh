#!/bin/bash

# Required var-envs
POD_ID=$(kubectl get pods -o jsonpath='{.items[0].metadata.name}' | grep postgres)
DB_USER=postgres
DB_NAME=database

# Exporta o banco de dados
kubectl exec -i $POD_ID -- pg_dump -U $DB_USER $DB_NAME > ../backup.sql
