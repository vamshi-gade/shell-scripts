#!/bin/bash

# Retrieve all namespaces and save them in an array
namespaces=($(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'))

# Loop through each namespace
for ns in "${namespaces[@]}"
do
    echo "Restarting deployments in $ns..."

    # Get the list of deployments in the namespace
    deployments=$(kubectl get deployment -n $ns --no-headers=true | awk '{print $1}')

    # Loop through each service and restart it
    for deploy in $deployments
    do
        echo "Restarting deployment $deploy in $ns..."
        kubectl rollout restart deployment $deploy -n $ns
    done

    echo "All deployments restarted in namespace $ns."
done

echo "All deployment restarted in all namespaces."  