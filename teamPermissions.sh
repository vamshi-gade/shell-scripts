#! /bin/bash

# If the repository is private, you must have at least read permission for that repository 
# your token must have the repo or admin:org scope.Otherwise, you will receive a 404 Not Found response status.
REPO= repo_name
ORG= org_name
TEAM= team_name

function permissions {  
    curl -s -u "${USERNAME}:${TOKEN}" https://api.github.com/orgs/$ORG/teams/$TEAM/repos/OWNER/$REPO 
}


checkaccess= "$(permissions | jq -r '.[] | select(.permissions.pull == true) | .login')"

if [[ -z "$checkaccess" ]]; then
    
    echo "The Team has no permissions for ${REPO_NAME}."

else
    echo "The Team has permissions for ${REPO_NAME}:"
    echo "$collaborators"
fi
