#!/bin/bash

echo "> Iniciando backup de dados"

# Salva o id do pod
POD_ID=$(kubectl get pods -o name | grep postgres | cut -d'/' -f2)


# Add variables to the shell (WARNING: This shouldn't be used at cloud services)
DB_HOST=localhost
DB_USER=postgres
DB_NAME=database

echo Waiting for pod to be ready: $POD_ID
while ! kubectl wait --for=condition=ready pod $POD_ID --timeout=15s; do
    echo Postgress pod not available yet, retrying
done

echo "> Importando dados de backup pt 1"
# Injeta os dados no banco de dados
kubectl exec $POD_ID -- mkdir /tmp/postgres
echo "> Importando dados de backup pt 2"
kubectl cp ../backup.sql $POD_ID:/tmp/postgres/backup.sql

#Copiar o arquivo para o pod leva um tempo. (Esse tempo difere da conexão no cloud e o tamanho do arquivo)
sleep 3

echo "> Importando dados de backup pt 3"
kubectl exec $POD_ID -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -f /tmp/postgres/backup.sql

# Test with:
# kubectl exec -it $POD_ID -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -c "select * from kennels LIMIT 10;"