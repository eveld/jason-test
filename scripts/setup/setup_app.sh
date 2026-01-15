#!/bin/bash
set -e

echo "Setting up sample application..."

# Create directory structure
mkdir -p /root/lab/{app/src,reports,scripts}

# Set as working directory
cd /root/lab

# Create sample Node.js application
cat > app/src/server.js <<'EOF'
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to Chainguard Security Demo',
    status: 'healthy',
    timestamp: new Date().toISOString()
  });
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

# Create package.json
cat > app/package.json <<'EOF'
{
  "name": "chainguard-demo-app",
  "version": "1.0.0",
  "description": "Sample app for Chainguard security demo",
  "main": "src/server.js",
  "scripts": {
    "start": "node src/server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF

# Create legacy Dockerfile
cat > app/Dockerfile <<'EOF'
FROM node:18

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 3000
CMD ["npm", "start"]
EOF

# Create helper scripts
cat > scripts/compare-scans.sh <<'SCRIPT'
#!/bin/bash
set -e

LEGACY_SCAN="${1:-/root/lab/reports/legacy-scan.json}"
CHAINGUARD_SCAN="${2:-/root/lab/reports/chainguard-scan.json}"

if [[ ! -f "$LEGACY_SCAN" ]] || [[ ! -f "$CHAINGUARD_SCAN" ]]; then
  echo "Error: Scan result files not found"
  exit 1
fi

LEGACY_COUNT=$(jq '.matches | length' "$LEGACY_SCAN")
CHAINGUARD_COUNT=$(jq '.matches | length' "$CHAINGUARD_SCAN")
REDUCTION=$(echo "scale=1; 100 - ($CHAINGUARD_COUNT * 100 / $LEGACY_COUNT)" | bc)

echo "===================================="
echo "   Vulnerability Comparison"
echo "===================================="
echo ""
echo "Legacy Image:       $LEGACY_COUNT CVEs"
echo "Chainguard Image:   $CHAINGUARD_COUNT CVEs"
echo "Reduction:          ${REDUCTION}%"
echo ""
echo "===================================="
SCRIPT

chmod +x scripts/compare-scans.sh

# Create README
cat > README.md <<'EOF'
# Chainguard Security Lab

This lab demonstrates how to secure your containerized applications using Chainguard.

## Directory Structure

- `app/` - Sample Node.js application
- `reports/` - Vulnerability scan results
- `scripts/` - Helper utilities

## Getting Started

Follow the lab instructions to scan images, switch to Chainguard base images, and secure your dependencies.
EOF

echo "Sample application created successfully!"
ls -la /root/lab
