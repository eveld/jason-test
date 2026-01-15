#!/bin/bash
set -e

# Check if cosign command exists
if command -v cosign &> /dev/null; then
  exit 0
fi

exit 1
