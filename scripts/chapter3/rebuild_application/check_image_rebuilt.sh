#!/bin/bash
set -e

# Check for rebuilt image tag (secure-app-v2, app-final, or similar)
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -E "(secure-app-v2|app-final|secure-app:latest)" &> /dev/null; then
  exit 0
fi

exit 1
