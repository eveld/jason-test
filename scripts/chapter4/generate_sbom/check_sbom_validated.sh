#!/bin/bash
set -e

# Find SBOM file
SBOM_FILE=""
if [ -f /root/lab/reports/sbom.spdx.json ]; then
  SBOM_FILE="/root/lab/reports/sbom.spdx.json"
elif [ -f /root/lab/reports/sbom.cdx.json ]; then
  SBOM_FILE="/root/lab/reports/sbom.cdx.json"
elif [ -f /root/lab/reports/sbom.json ]; then
  SBOM_FILE="/root/lab/reports/sbom.json"
else
  exit 1
fi

# Validate JSON structure - check for basic SBOM properties
if jq -e '.packages // .components' "$SBOM_FILE" &> /dev/null; then
  exit 0
fi

exit 1
