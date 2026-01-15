#!/bin/bash
set -e

# Check for package.json in app directory
if [ -f /root/lab/app/package.json ]; then
  exit 0
fi

exit 1
