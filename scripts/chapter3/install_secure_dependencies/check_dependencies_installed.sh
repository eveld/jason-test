#!/bin/bash
set -e

# Check if node_modules exists and is non-empty
if [ -d /root/lab/app/node_modules ] && [ "$(ls -A /root/lab/app/node_modules)" ]; then
  exit 0
fi

exit 1
