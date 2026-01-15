#!/bin/bash
set -e

# Check docker images for cgr.dev/chainguard/node
if docker images --format "{{.Repository}}" | grep -q "cgr.dev/chainguard/node" &> /dev/null; then
  exit 0
fi

exit 1
