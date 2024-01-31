# DevOps-DreamPuppy
 Kubernetes devops

psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "
  INSERT INTO kennels (id, name, created_at, phone, instagram, address, city, uf, cep)
  VALUES
    (2, 'Kennel 2', '2024-01-30 12:00:00', '323121', 'kennel2_instagram', '456 Oak St', 'Town', 'UF', '54321'),
    (3, 'Kennel 3', '2024-02-01 12:00:00', '321312321312321', 'kennel3_instagram', '789 Pine St', 'Village', 'UF', '67890'),
    (4, 'Kennel 4', '2024-02-02 12:00:00', '312312312321', 'kennel4_instagram', '101 Maple St', 'Hamlet', 'UF', '11223'),
    (5, 'Kennel 5', '2024-02-03 12:00:00', '321312312312312321231', 'kennel5_instagram', '202 Birch St', 'Cityville', 'UF', '44556'),
    (6, 'Kennel 6', '2024-02-04 12:00:00', '3232312131', 'kennel6_instagram', '303 Cedar St', 'Rural', 'UF', '77889'),
    (7, 'Kennel 7', '2024-02-05 12:00:00', '3232321121221', 'kennel7_instagram', '404 Pine St', 'Suburbia', 'UF', '12345'),
    (8, 'Kennel 8', '2024-02-06 12:00:00', '32321232132', 'kennel8_instagram', '505 Oak St', 'Metropolis', 'UF', '54321'),
    (9, 'Kennel 9', '2024-02-07 12:00:00', '332434341', 'kennel9_instagram', '606 Elm St', 'Villagetown', 'UF', '67890'),
    (10, 'Kennel 10', '2024-02-08 12:00:00', '422', 'kennel10_instagram', '707 Pine St', 'Hamletville', 'UF', '11223');
"

# Exportar dados para um arquivo de backup local
> kubectl exec -it $pod_id -- pg_dump -U $DB_USER $DB_NAME > ../backup.sql


# Importar dados de um arquivo 
> kubectl exec -it $pod_id -- mkdir /tmp/postgres
> kubectl cp ../backup.sql $pod_id:/tmp/postgres/backup.sql
> kubectl exec -it $pod_id -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -f /tmp/postgres/backup.sql


# Listar canis
> kubectl exec -it $pod_id -- psql -U $DB_USER -d $DB_NAME -h $DB_HOST -c "SELECT * FROM kennels;"