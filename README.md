# DevOps-DreamPuppy
 Kubernetes devops

# Exportar dados para um arquivo de backup local
> kubectl exec -it $pod_id -- pg_dump -U $DB_USER $DB_NAME > ../backup.sql

# Importar dados de um arquivo 
> kubectl exec -it $pod_id -- mkdir /tmp/postgres
> kubectl cp ../backup.sql $pod_id:/tmp/postgres/backup.sql
> kubectl exec -it $pod_id -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -f /tmp/postgres/backup.sql

# Listar canis
> kubectl exec -it $pod_id -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -c "SELECT * FROM kennels;"