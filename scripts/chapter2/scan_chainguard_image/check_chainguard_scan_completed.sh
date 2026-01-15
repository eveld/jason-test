#!/bin/bash
set -e

# Check if scan results exist
if [ ! -f /root/lab/reports/chainguard-scan.json ]; then
  exit 1
fi

# Validate JSON structure
if ! jq '.matches' /root/lab/reports/chainguard-scan.json &> /dev/null; then
  exit 1
fi

exit 0
