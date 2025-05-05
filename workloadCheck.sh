#!/usr/bin/env bash
## This Script evaluates the status of workloads in the cluster
## Please login to the required cluster before running the script

#Colours
RED='\033[0;31m'   
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'

resources=("deployments" "statefulsets")

for resource in ${resources[@]}
do 
   echo  "${BLUE}""***checking $resource***"
   total=$(kubectl get $resource -A --no-headers| wc-l)
   echo  "${BLUE}""total $resource : $total "
   deploy=$(kubectl get $resource -A --no-headers| awk '{split($3,a,"/")}a[1]!=a[2]')

   if [[ -n "${deploy}" ]]
   then 
     echo  "${RED}""unhealthy $resource: \n${deploy}\n"
   else 
      echo -e "${GREEN}""All $resources are good \n"  
done 

echo "${BLUE}""***checking deamonsets***\n"

total=$(kubectl get daemonsets -A --no-headers| wc-l)
unhealthy=$(kubectl get daemonsets -A --no-headers| awk '$3!=$5')

echo "${BLUE}""total daemonsets: $total \n"
if [[ -n "${unhealthy}" ]]
then
   echo  "${RED}""unhealty daemonsets:\n${unhealthy}"
else 
   echo  "${GREEN}""All daemonsets are good"
fi      