#!/bin/bash
set -e

# Check .npmrc for Chainguard registry
if [ -f /root/lab/app/.npmrc ] || [ -f ~/.npmrc ]; then
  # Check either location for registry config
  if grep -q "cgr.dev" /root/lab/app/.npmrc ~/.npmrc 2>/dev/null; then
    exit 0
  fi
fi

exit 1
