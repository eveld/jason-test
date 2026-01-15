#!/bin/bash
set -e

echo "Starting Docker daemon..."

# Start dockerd in background
dockerd &

# Wait for Docker daemon to be ready
echo "Waiting for Docker daemon to be ready..."
timeout=60
counter=0
until docker info &> /dev/null; do
    if [ $counter -ge $timeout ]; then
        echo "Error: Docker daemon failed to start within ${timeout} seconds"
        exit 1
    fi
    echo "Waiting for Docker... ($counter/$timeout)"
    sleep 2
    counter=$((counter + 2))
done

echo "Docker daemon is ready!"

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
