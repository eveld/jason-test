#!/bin/bash
set -e

# Check if comparison output exists
if [ -f /root/lab/reports/comparison.txt ] || [ -f /root/lab/reports/comparison.json ]; then
  exit 0
fi

exit 1
