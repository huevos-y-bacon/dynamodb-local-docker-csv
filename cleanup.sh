#!/usr/bin/env bash

set -e # fail on any error

BOLD=$(tput bold)$(tput setaf 1)
NORMAL=$(tput sgr0)

echo -n "${BOLD}Cleanup all JSON files... ${NORMAL}"
rm -f ./*.json
echo "Done"
