#!/bin/bash
set -e

echo "Waiting for Docker daemon to be ready..."

# Wait for Docker daemon (should be started by dind entrypoint)
timeout=60
counter=0
until docker info &> /dev/null; do
    if [ $counter -ge $timeout ]; then
        echo "Error: Docker daemon not available within ${timeout} seconds"
        exit 1
    fi
    sleep 2
    counter=$((counter + 2))
done

echo "Docker daemon is ready!"

echo "Pre-pulling Docker images (this may take a few minutes)..."

# Note: Chainguard's base images (like node) are publicly available on cgr.dev
# No authentication required for this lab

# Pull images sequentially to avoid issues
echo "Pulling node:18..."
docker pull node:18

echo "Pulling cgr.dev/chainguard/node:latest..."
docker pull cgr.dev/chainguard/node:latest

echo "Pulling cgr.dev/chainguard/node:latest-dev..."
docker pull cgr.dev/chainguard/node:latest-dev

echo "Images pre-pulled successfully!"
docker images
echo "Setup complete!"
