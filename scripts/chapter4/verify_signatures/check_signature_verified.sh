#!/bin/bash
set -e

# Check for signature verification output
if [ -f /root/lab/reports/signature-verification.txt ] || [ -f /root/lab/reports/signature-verified.txt ]; then
  exit 0
fi

exit 1
