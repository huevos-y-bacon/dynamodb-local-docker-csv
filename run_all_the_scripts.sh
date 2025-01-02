#!/usr/bin/env bash

set -e # fail on any error

BOLD=$(tput bold)$(tput setaf 1)
NORMAL=$(tput sgr0)

echo -n "${BOLD}Cleanup all JSON files... ${NORMAL}"
rm -f ./*.json
echo "Done"

# run all the scripts in sequence
echo -n -e "${BOLD}Delete the table... ${NORMAL}"
./ddb_delete_table.sh -f
echo "Done"

echo -n -e "${BOLD}Create the table... ${NORMAL}"
./ddb_create_table.sh
echo "Done"

echo -e "${BOLD}Populate the table... ${NORMAL}"
./ddb_populate_table.sh
echo "Done"

echo -e "${BOLD}Scan the table... ${NORMAL}"
./ddb_scan_table.sh
echo "Done"
