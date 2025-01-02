#!/usr/bin/env bash

set -e # fail on any error

shopt -s expand_aliases
# shellcheck disable=SC1091
source _env > /dev/null || exit 1

TABLE=accounts

# prompt user to confirm deletion if -f flag is not set
if [[ $1 != "-f" ]]; then
    # shellcheck disable=SC2162
    read -p "Are you sure you want to delete the table '$TABLE'? (y/n): " confirm

    if [[ $confirm != "y" ]]; then
        echo "Table deletion aborted!"
        exit 0
    fi
fi

dynamodb delete-table --table-name $TABLE > table_delete_$TABLE.json
