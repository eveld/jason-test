# Rebuilding with Secure Components

You've secured both your base image and your dependencies. Now let's rebuild your application and verify the complete security improvement.

## Rebuild the Application

With Chainguard Images as your base and Chainguard Libraries as your dependencies, rebuild your container:

```bash
cd /root/lab/app
docker build -t secure-app:v2 .
```

This image now has:
- **Minimal base image**: Chainguard Node.js runtime
- **Hardened dependencies**: Verified packages from Chainguard Libraries
- **Reduced attack surface**: Only essential components

## Verify the Final Result

Let's scan the complete application image:

```bash
grype secure-app:v2 -o json > /root/lab/reports/final-scan.json
jq '.matches | length' /root/lab/reports/final-scan.json
```

Compare this to your original scan results. You should see:
- **Base image vulnerabilities**: Reduced from 400-600 to 0-5
- **Dependency vulnerabilities**: Significantly reduced or eliminated
- **Total risk**: Minimized across the entire stack

<instruqt-task id="rebuild_application"></instruqt-task>

## The Complete Security Stack

You've now implemented defense in depth:

| Layer | Before | After |
|-------|--------|-------|
| Base OS | 400-600 CVEs | 0-5 CVEs |
| Runtime | Included in base | Minimal, hardened |
| Dependencies | 10-50 CVEs | 0-5 CVEs |
| **Total** | **~500 CVEs** | **~0-10 CVEs** |

That's over a **98% reduction** in security vulnerabilities—with minimal changes to your development workflow.

## What's Next?

Security isn't just about reducing vulnerabilities—it's also about **compliance and verification**. In Chapter 4, we'll generate Software Bill of Materials (SBOMs) and verify cryptographic signatures to prove the security of your supply chain.
