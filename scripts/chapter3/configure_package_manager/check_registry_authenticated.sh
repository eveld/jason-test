#!/bin/bash
set -e

# Check for auth token in .npmrc
if [ -f /root/lab/app/.npmrc ] || [ -f ~/.npmrc ]; then
  # Check for _authToken or similar auth config
  if grep -qE "(_authToken|_auth|authToken)" /root/lab/app/.npmrc ~/.npmrc 2>/dev/null; then
    exit 0
  fi
fi

exit 1
