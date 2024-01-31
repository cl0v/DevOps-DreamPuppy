#!/bin/bash

# Delete the cluster saving the data

# Steps:
#. Export backup.sql
#. Delete lab-cluster

./lab/export-backup-sql.sh
./lab/delete-cluster.sh

exit & exit