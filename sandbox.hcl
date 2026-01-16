# Network for container communication
resource "network" "main" {
  subnet = "10.0.10.0/24"
}

# Main workstation container with pre-baked tools
# Image built from Dockerfile in this directory with:
# - Docker-in-Docker
# - Grype vulnerability scanner
# - Cosign signature verification
# - Syft SBOM generator
# - Node.js 20 LTS
# - Utilities: bash, jq, bc, wget, curl
resource "container" "workstation" {
  image {
    # Custom image with pre-installed tools
    # Built from Dockerfile and pushed to Docker Hub
    name = "technics/chainguard:latest"
  }

  network {
    id = resource.network.main.meta.id
  }

  # Memory and CPU resources
  resources {
    memory = 4096 # 4 GB
    cpu    = 2000 # 2 vCPUs
  }

  # Enable privileged mode for Docker-in-Docker
  privileged = true

  # Mount lab files (app, scripts, reports directories)
  volume {
    source      = "files"
    destination = "/root/lab"
  }
}
