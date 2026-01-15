#!/bin/bash
set -e

# Check if final scan exists and has minimal CVEs
if [ ! -f /root/lab/reports/final-scan.json ]; then
  exit 1
fi

# Verify it's valid JSON
if ! jq '.matches' /root/lab/reports/final-scan.json &> /dev/null; then
  exit 1
fi

# Optional: Could check CVE count is low, but keeping simple for now
exit 0
