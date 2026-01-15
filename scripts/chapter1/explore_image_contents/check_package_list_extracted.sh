#!/bin/bash
set -e

# Check if package list file exists
if [ ! -f /root/lab/reports/node18-packages.txt ]; then
  exit 1
fi

# Verify file is non-empty
if [ -s /root/lab/reports/node18-packages.txt ]; then
  exit 0
else
  exit 1
fi
