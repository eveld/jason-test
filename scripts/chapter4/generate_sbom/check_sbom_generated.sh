#!/bin/bash
set -e

# Check for SBOM file (SPDX or CycloneDX format)
if [ -f /root/lab/reports/sbom.spdx.json ] || [ -f /root/lab/reports/sbom.cdx.json ] || [ -f /root/lab/reports/sbom.json ]; then
  exit 0
fi

exit 1
