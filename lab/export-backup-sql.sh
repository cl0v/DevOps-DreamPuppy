#!/bin/bash

# Required var-envs
POD_ID=$(kubectl get pods -o name | grep postgres | cut -d'/' -f2)
DB_USER=postgres
DB_NAME=database

echo "> Exportando dados de backup"
# Exporta o banco de dados
kubectl exec -i $POD_ID -- pg_dump -U $DB_USER $DB_NAME > ../backup.sql
