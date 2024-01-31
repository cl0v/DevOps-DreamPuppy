#!/bin/bash

echo "> Iniciando backup de dados"
sleep 10

# Salva o id do pod
POD_ID=$(kubectl get pods -o name | grep postgres | cut -d'/' -f2)


# Add variables to the shell (WARNING: This shouldn't be used at cloud services)
DB_HOST=localhost
DB_USER=postgres
DB_NAME=database

echo Aguardando $POD_ID estar pronto
while ! kubectl wait --for=condition=ready pod $POD_ID --timeout=15s; do
    echo "Postgress pod not available yet, retrying"
done

echo "> Importando dados de backup"
# Injeta os dados no banco de dados
kubectl exec $POD_ID -- mkdir /tmp/postgres
kubectl cp ../backup.sql $POD_ID:/tmp/postgres/backup.sql
kubectl exec $POD_ID -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -f /tmp/postgres/backup.sql

# Test with:
# kubectl exec -it $POD_ID -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -c "select * from kennels LIMIT 10;"