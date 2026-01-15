#!/bin/bash
set -e

# Check if SBOM components were extracted/listed
if [ -f /root/lab/reports/sbom-components.txt ] || [ -f /root/lab/reports/components.txt ]; then
  # Verify file is non-empty
  if [ -s /root/lab/reports/sbom-components.txt ] || [ -s /root/lab/reports/components.txt ]; then
    exit 0
  fi
fi

exit 1
