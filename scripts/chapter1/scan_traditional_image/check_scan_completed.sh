#!/bin/bash
set -e

# Check if scan report exists
if [ ! -f /root/lab/reports/legacy-scan.json ]; then
  exit 1
fi

# Validate JSON structure with jq
if jq '.matches' /root/lab/reports/legacy-scan.json &> /dev/null; then
  exit 0
else
  exit 1
fi
