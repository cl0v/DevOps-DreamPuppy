#!/bin/bash

echo "> Creating cluster lab named dev..."
# Apenas especificar o caminho parece não ter persistido o volume. Vou exportar os dados do postgress em um arquivo .sql e importar ao criar outro cluster.
k3d cluster create dev --config ~/k3d/config.yaml #--volume=$HOME/dev/k3d-data/data:/mnt/data
