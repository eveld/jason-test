#!/bin/bash
set -e

# Check if provenance was examined
if [ -f /root/lab/reports/provenance-inspection.txt ] || [ -f /root/lab/reports/provenance-details.txt ]; then
  exit 0
fi

exit 1
