#!/usr/bin/env bash

set -e # fail on any error

shopt -s expand_aliases
# shellcheck disable=SC1091
source _env > /dev/null || exit 1

TABLE=accounts

dynamodb create-table \
    --table-name $TABLE \
    --attribute-definitions AttributeName=account_id,AttributeType=S \
    --key-schema AttributeName=account_id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 > table_create_$TABLE.json
  