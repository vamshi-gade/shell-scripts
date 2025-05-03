#!/usr/bin/env bash
# This script creates the aliases for the commands.

alias k="kubectl"
alias kap="kubectl apply -f"
alias deploy="kubectl get deploy -A" 
alias pods="kubectl get pods -A" 
alias cm="kubectl get cm -A"
alias secrets="kubectl get secrets"
podIssues() {
       echo "\e[1m\e[39mPods not in Running or Completed state:\e[21m"
       kubectl get pods -A --feild-selector=status.phase!=Running | grep -v Completed
}       
