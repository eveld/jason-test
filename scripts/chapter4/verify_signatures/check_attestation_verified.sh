#!/bin/bash
set -e

# Check for attestation verification status
if [ -f /root/lab/reports/attestation-verified.txt ] || [ -f /root/lab/reports/attestation-verification.txt ]; then
  exit 0
fi

exit 1
