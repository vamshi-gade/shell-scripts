#!/usr/bin/env bash
## this Script evaluates the status of workloads in the cluster
## Please login to the required cluster before running the script

resources=("deployments" "statefulsets")

for resource in ${resources[@]}
do 
   echo "***checking $resource***"
   total=$(kubectl get $resource -A --no-headers| wc-l)
   echo "total $resource : $total "
   deploy=$(kubectl get $resource -A --no-headers| awk '{split($3,a,"/")}a[1]!=a[2]')

   if [(-n "${deploy}")]
   then 
     echo "unhealthy $resource: \n${deploy}\n"
   else 
      echo "All $resources are good \n"  
done 

echo "***checking deamonsets***\n"

total=$(kubectl get daemonsets -A --no-headers| wc-l)
unhealthy=$(kubectl get daemonsets -A --no-headers| awk '$3!=$5')

echo "total daemonsets: $total \n"
if [( -n "${unhealthy}" )]
then
   echo "unhealty daemonsets:\n${unhealthy}"
else 
   echo "All daemonsets are good"
fi      