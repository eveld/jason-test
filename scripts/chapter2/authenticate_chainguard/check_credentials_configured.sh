#!/bin/bash
set -e

# Check if Docker config contains cgr.dev auth
if [ -f ~/.docker/config.json ]; then
  if grep -q "cgr.dev" ~/.docker/config.json &> /dev/null; then
    exit 0
  fi
fi

exit 1
