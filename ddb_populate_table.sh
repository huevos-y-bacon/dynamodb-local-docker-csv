#!/usr/bin/env bash

# Exit on any error
set -e

# Enable aliases and source the DynamoDB local aliases
shopt -s expand_aliases
source _env > /dev/null || exit 1

# Define the table name and file paths
TABLE=accounts
CSV_FILE="accounts.csv"
JSON_FILE="accounts.json"

# Check if the CSV file exists
if [[ ! -f $CSV_FILE ]]; then
    echo "Error: CSV file '$CSV_FILE' not found!"
    exit 1
fi

# Python script to convert CSV to DynamoDB JSON items
python3 - <<EOF
import csv
import json

# Input and output file paths
csv_file = "$CSV_FILE"
json_file = "$JSON_FILE"

# Read the CSV file and convert to DynamoDB JSON format
items = []
with open(csv_file, mode="r", newline="", encoding="utf-8") as file:
    reader = csv.DictReader(file)
    for row in reader:
        item = {key: {"S": value.strip()} for key, value in row.items()}
        items.append(item)

# Write items to JSON file
with open(json_file, mode="w", encoding="utf-8") as outfile:
    json.dump(items, outfile, indent=4)

print(f"Generated JSON file: {json_file}")
EOF

# Verify JSON file creation
if [[ ! -f $JSON_FILE ]]; then
    echo "Error: JSON file '$JSON_FILE' not created!"
    exit 1
fi

# Use the JSON file to populate DynamoDB
while IFS= read -r item; do
    echo "Writing item to DynamoDB: $item"
    dynamodb put-item \
        --table-name "$TABLE" \
        --item "$item"
done < <(jq -c '.[]' "$JSON_FILE")
