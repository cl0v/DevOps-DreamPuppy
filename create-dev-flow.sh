#!/bin/bash

# This script will do the main flow that is required to only focus
# on running the production example locally with k3d. 

# Steps:
#1. Create Cluster.
#2. Docker login.
#3. Apply kube files.
#4. Import backup.sql &
#5. Create Ingress & [1]
#6. Port forward localhost:8080 & [1]


./lab/create-cluster.sh
./lab/docker-login-secret.sh
./lab/apply-kube-files.sh
# (./lab/import-backup-sql.sh) & 
# (./lab/install-ingress-controller.sh ; ./lab/port-forward.sh) &


echo "Pressione alguma tecla para cancelar"
read -p "> <"
echo ""

exit
