#!/bin/bash
set -e

# Check if container from secure-app is running
if docker ps --filter "ancestor=secure-app" --format "{{.Image}}" | grep -q "secure-app" &> /dev/null; then
  exit 0
fi

# Also check for app-secure variant
if docker ps --filter "ancestor=app-secure" --format "{{.Image}}" | grep -q "app-secure" &> /dev/null; then
  exit 0
fi

exit 1
