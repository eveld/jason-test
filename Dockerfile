FROM docker:dind

# Install base utilities
RUN apk add --no-cache \
    bash \
    curl \
    wget \
    jq \
    bc \
    ca-certificates \
    git

# Install Grype vulnerability scanner
RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin && \
    grype db update

# Install Cosign for signature verification
RUN COSIGN_VERSION=$(curl -s https://api.github.com/repos/sigstore/cosign/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -sSfL "https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-amd64" \
      -o /usr/local/bin/cosign && \
    chmod +x /usr/local/bin/cosign

# Install Syft SBOM generator
RUN curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

# Install Node.js 20 LTS
RUN apk add --no-cache nodejs npm

# Verify installations
RUN docker --version && \
    grype version && \
    cosign version && \
    syft version && \
    node --version && \
    npm --version

# Set working directory
WORKDIR /root

# Keep the dind entrypoint to start dockerd
# The docker:dind image has dockerd-entrypoint.sh which starts dockerd
# We just set bash as the default shell for interactive use
SHELL ["/bin/bash", "-c"]
