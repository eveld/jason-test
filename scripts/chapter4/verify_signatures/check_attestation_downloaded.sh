#!/bin/bash
set -e

# Check for attestation file
if [ -f /root/lab/reports/attestation.json ] || [ -f /root/lab/reports/image-attestation.json ]; then
  exit 0
fi

exit 1
