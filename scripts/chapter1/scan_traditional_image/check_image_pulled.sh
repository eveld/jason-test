#!/bin/bash
set -e

# Check if node:18 image is present in docker images
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "^node:18$" 2>/dev/null; then
  exit 0
else
  exit 1
fi
