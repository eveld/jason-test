#!/bin/bash
set -e

# Check if grype command exists
if command -v grype &> /dev/null; then
  exit 0
else
  exit 1
fi
