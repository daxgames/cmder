#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_branch>:<dest_branch> <source_org>:<dest_org>"
    exit 1
fi

branches=$1
orgs=$2

source_branch=$(echo ${branches} | awk -F: '{print $1}')
dest_branch=$(echo ${branches} | awk -F: '{print $2}')

source_org=$(echo ${orgs} | awk -F: '{print $1}')
dest_org=$(echo ${orgs} | awk -F: '{print $2}')

sed -i "s/${source_branch}/${dest_branch}/g;s/${source_org}/${dest_org}/g;s/, \"development\"//;s/^\s\+- development//" $(grep -R "${source_branch}\|${source_org}\|development" ./.github | awk -F: '{print $1}' | grep -v workflows/branches.yml)
