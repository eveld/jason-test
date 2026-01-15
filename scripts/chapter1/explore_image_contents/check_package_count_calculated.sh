#!/bin/bash
set -e

# Check if package count file exists
if [ ! -f /root/lab/reports/package-count.txt ]; then
  exit 1
fi

# Verify file contains a number
if grep -qE '^[0-9]+$' /root/lab/reports/package-count.txt 2>/dev/null; then
  exit 0
else
  exit 1
fi
