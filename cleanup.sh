#!/usr/bin/env bash

set -e # fail on any error

# Prompt for confirmation
read -p "Are you sure you want to cleanup all the JSON files and stop+delete the local DynamoDB container? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Exiting without cleanup..."
    exit 0
fi

BOLD=$(tput bold)$(tput setaf 1)
NORMAL=$(tput sgr0)

echo -n "${BOLD}Cleanup all JSON files... ${NORMAL}"
rm -f ./*.json

echo "Stopping and removing the local DynamoDB container..."
docker compose down --volumes

# delete all containers from compose file
echo "Removing all unused container images..."
docker image prune -af

echo "Done"
