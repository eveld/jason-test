#!/bin/bash
set -e

# Check if Dockerfile contains cgr.dev/chainguard reference
if grep -q "cgr.dev/chainguard" /root/lab/app/Dockerfile &> /dev/null; then
  exit 0
fi

exit 1
