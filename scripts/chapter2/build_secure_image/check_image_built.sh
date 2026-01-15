#!/bin/bash
set -e

# Check for secure-app image or similar tag
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -E "(secure-app|app-secure)" &> /dev/null; then
  exit 0
fi

exit 1
