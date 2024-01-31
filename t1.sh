#!/bin/bash

kubectl get pods -o name | grep postgres | cut -d'/' -f2

# echo "t 1 i"

# (./t2.sh ; ./t3.sh) &

# echo "t 1 e"

# # ls
# echo "digita"
# aa="2kkkkkk"
# echo $aa

# ./lab/t2.sh