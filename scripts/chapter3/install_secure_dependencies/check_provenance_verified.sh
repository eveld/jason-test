#!/bin/bash
set -e

# Check for provenance attestation file or verification output
if [ -f /root/lab/reports/provenance.json ] || [ -f /root/lab/reports/provenance-verified.txt ]; then
  exit 0
fi

exit 1
