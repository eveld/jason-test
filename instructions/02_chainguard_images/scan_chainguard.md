# Scanning Chainguard Images

You've seen that traditional Node.js images contain hundreds of vulnerabilities. Now let's see what happens when we switch to a minimal, security-focused base image.

Chainguard Images are built with a "distroless" approach—they contain only what's absolutely necessary to run your application. No package managers, no shells, no unnecessary system utilities.

## What Are Chainguard Images?

Chainguard provides hardened, minimal container images with:

- **Zero known CVEs** at time of publication
- **Minimal attack surface**: Only essential runtime dependencies
- **Regular updates**: Automated rebuilds when vulnerabilities are discovered
- **Signed and attested**: Cryptographic verification of provenance

Most Chainguard images are **publicly available** at `cgr.dev/chainguard/` without authentication.

## Authentication (Optional)

For this lab, we're using publicly available Chainguard images that don't require authentication. However, if you're using enterprise Chainguard images, you would authenticate with:

```bash
docker login cgr.dev
```

You can skip this step for now since we're using public images.

<instruqt-task id="authenticate_chainguard"></instruqt-task>

## Pull the Chainguard Node Image

Let's pull the Chainguard equivalent of `node:18`:

```bash
docker pull cgr.dev/chainguard/node:latest
```

This image provides the same Node.js runtime, but with a radically reduced footprint.

## Scan the Chainguard Image

Now let's scan this image using the same Grype scanner:

```bash
grype cgr.dev/chainguard/node:latest -o json > /root/lab/reports/chainguard-scan.json
```

## Compare the Results

Let's see the difference. You can use the helper script we've provided:

```bash
bash /root/lab/scripts/compare-scans.sh /root/lab/reports/legacy-scan.json /root/lab/reports/chainguard-scan.json
```

Or manually compare the counts:

```bash
echo "Legacy image vulnerabilities:"
jq '.matches | length' /root/lab/reports/legacy-scan.json

echo "Chainguard image vulnerabilities:"
jq '.matches | length' /root/lab/reports/chainguard-scan.json
```

### The Results

The difference is dramatic:

- **Traditional `node:18`**: ~400-600 vulnerabilities
- **Chainguard `node:latest`**: **0-5 vulnerabilities** (often zero)

That's a **99%+ reduction** in known security risks—with zero changes to your application code.

## Why Such a Dramatic Improvement?

Chainguard Images achieve this by:

1. **Removing unnecessary packages**: No compilers, build tools, or package managers
2. **Using minimal base layers**: Built from scratch rather than full OS distributions
3. **Including only runtime dependencies**: Just what Node.js needs to execute code
4. **Continuous rebuilds**: Images are automatically updated when vulnerabilities are patched

<instruqt-task id="scan_chainguard_image"></instruqt-task>

## What's Next?

Now that you've seen the security improvement, let's make it real. In the next section, we'll update your application's Dockerfile to use the Chainguard image and see how easy the migration is.
