#!/bin/bash

echo "Creating cluster lab named dev..."
# Apenas especificar o caminho parece não ter persistido o volume. Vou exportar os dados do postgress em um arquivo .sql e importar ao criar outro cluster.
k3d cluster create dev --volume=$HOME/dev/k3d-data/data:/mnt/data

# Roda a parte de deploy do cluster ./deploy-dev.sh
./dev-deploy.sh

# Salva o id do pod
export POD_ID=$(kubectl get pods -o jsonpath='{.items[0].metadata.name}' | grep postgres)

# Add variables to the shell (WARNING: This shouldn't be used at cloud services)
DB_HOST=localhost
DB_USER=postgres
DB_NAME=database

# Injeta os dados no banco de dados
kubectl exec -it $POD_ID -- mkdir /tmp/postgres
kubectl cp ../backup.sql $POD_ID:/tmp/postgres/backup.sql
kubectl exec -it $POD_ID -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -f /tmp/postgres/backup.sql

# Valida se deu certo a adição de canis ao banco de dados
kubectl exec -it $POD_ID -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -c "select count (*) from kennels;"

read -p "Press any key to delete the cluster... " -n1 -s

# Exporta o banco de dados
kubectl exec -it $POD_ID -- pg_dump -U $DB_USER $DB_NAME > ../backup.sql

echo 
echo "exiting..."

k3d cluster delete dev