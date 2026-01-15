#!/bin/bash
set -e

# Check for dependency scan results
if [ -f /root/lab/reports/dependency-scan.json ] || [ -f /root/lab/reports/dependencies-scan.json ]; then
  exit 0
fi

exit 1
