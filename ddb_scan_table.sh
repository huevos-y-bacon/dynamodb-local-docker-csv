#!/usr/bin/env bash

set -e # fail on any error

shopt -s expand_aliases
# shellcheck disable=SC1091
source _env > /dev/null || exit 1

TABLE=accounts
OUTPUT_JSON="accounts_formatted.json"
OUTPUT_DDB_JSON="accounts_ddb.json"

# Scan the DynamoDB table and save the raw output
dynamodb scan --table-name "$TABLE" --output json > "$OUTPUT_DDB_JSON"
echo "DynamoDB JSON output saved to: $OUTPUT_DDB_JSON"

# Process the raw output to create a formatted JSON file
jq '{
  Items: [.Items[] | 
    with_entries(if .value.S then .value = .value.S else . end)
  ]
}' "$OUTPUT_DDB_JSON" > "$OUTPUT_JSON"
echo "Formatted JSON output saved to: $OUTPUT_JSON"
