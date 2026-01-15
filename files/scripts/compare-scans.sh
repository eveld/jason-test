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
