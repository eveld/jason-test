# Scanning Application Dependencies

You've secured your base image, eliminating hundreds of OS-level vulnerabilities. But there's another major source of risk: **your application's dependencies**.

Modern applications rely on dozens or hundreds of third-party packages. Each one can introduce vulnerabilities—and traditional package registries offer no security guarantees.

## The Dependency Problem

When you run `npm install`, you're downloading code from thousands of maintainers across the internet. That code:

- May contain known vulnerabilities
- May be compromised or backdoored
- May have no provenance information
- May pull in vulnerable transitive dependencies

Let's see how many vulnerabilities exist in a typical application's dependencies.

## Scan Your Dependencies

First, make sure you have a `package.json` manifest:

```bash
cat /root/lab/app/package.json
```

Now scan the dependencies for known vulnerabilities. There are several ways to do this:

1. **Using Grype on the full application directory**:
   ```bash
   grype dir:/root/lab/app -o json > /root/lab/reports/dependency-scan.json
   ```

2. **Using npm audit** (if available):
   ```bash
   cd /root/lab/app
   npm audit --json > /root/lab/reports/npm-audit.json
   ```

Run at least one of these scans and examine the results. How many vulnerabilities exist in your dependencies?

<instruqt-task id="scan_dependencies"></instruqt-task>

## Understanding the Results

Even a simple Express.js application can have:
- **50+ direct and transitive dependencies**
- **Multiple known CVEs** in popular packages
- **No verification** of package authenticity

Traditional npm packages are built and published by individual maintainers with varying security practices. There's no guarantee of:
- Regular security updates
- Vulnerability scanning
- Build reproducibility
- Supply chain integrity

## What's Next?

Chainguard Libraries solve this problem by providing **hardened, verified packages** with:
- Zero known CVEs at publication
- Cryptographic signatures
- Provenance attestations
- Regular automated rebuilds

In the next section, we'll configure your project to use Chainguard Libraries.
