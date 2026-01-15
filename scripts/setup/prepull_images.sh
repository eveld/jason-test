#!/bin/bash
set -e

echo "Pre-pulling Docker images (this may take a few minutes)..."

# Note: Chainguard's base images (like node) are publicly available on cgr.dev
# No authentication required for this lab

# Pull images in parallel for speed
docker pull node:18 &
docker pull cgr.dev/chainguard/node:latest &
docker pull cgr.dev/chainguard/node:latest-dev &

# Wait for all pulls to complete
wait

echo "Images pre-pulled successfully!"
docker images
