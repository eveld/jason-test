# Verifying Signatures and Attestations

You've generated an SBOM, but how do you know it's authentic? And how can you trust that your base image hasn't been tampered with?

This is where **cryptographic signatures** and **attestations** provide verifiable proof of software integrity.

## What Are Signatures and Attestations?

**Signatures**: Cryptographic proofs that an artifact (image, SBOM, binary) was created by a specific entity and hasn't been modified.

**Attestations**: Signed statements about how software was built, including:
- Build environment details
- Source code provenance
- SBOM contents
- Vulnerability scan results

Together, they enable **supply chain verification**: you can prove exactly what's in your software and where it came from.

## Verify Chainguard Image Signatures

Chainguard Images are signed using Sigstore's Cosign tool. Let's verify the signature on the Chainguard Node.js image:

```bash
cosign verify cgr.dev/chainguard/node:latest \
  --certificate-identity-regexp=".*" \
  --certificate-oidc-issuer-regexp=".*"
```

This command verifies:
- The image was signed by Chainguard
- The image hasn't been modified since signing
- The signature is valid and trusted

<instruqt-task id="verify_image_signature"></instruqt-task>

## Download and Verify Attestations

Chainguard also publishes attestations about their images. Let's download and inspect them:

```bash
# Download attestations
cosign download attestation cgr.dev/chainguard/node:latest > /root/lab/reports/chainguard-attestation.json

# View the attestation
cat /root/lab/reports/chainguard-attestation.json | jq
```

<instruqt-task id="verify_attestations"></instruqt-task>

## Inspect Provenance Information

Attestations include provenance—proof of where and how the image was built:

```bash
# Extract provenance (if present in attestation)
jq '.payload' /root/lab/reports/chainguard-attestation.json | base64 -d | jq
```

Provenance includes:
- Git commit that triggered the build
- Build system identity
- Timestamp
- Build parameters

This creates an **auditable trail** from source code to production image.

## Why This Matters

Signature verification protects against:
- **Man-in-the-middle attacks**: Ensures you're pulling the real image
- **Registry compromise**: Detects tampering with images
- **Supply chain attacks**: Verifies legitimate provenance

For compliance, signatures provide **non-repudiable proof** of software authenticity.

## Summary

You've now completed the full supply chain security workflow:

1. ✅ **Identified vulnerabilities** in traditional images
2. ✅ **Switched to minimal base images** (99% CVE reduction)
3. ✅ **Secured dependencies** with hardened packages
4. ✅ **Generated SBOMs** for compliance
5. ✅ **Verified signatures** for authenticity

This is the foundation of **modern software supply chain security**—and you achieved it with minimal changes to your development workflow.

## Next Steps

- Apply these patterns to your production applications
- Explore Chainguard's enterprise features (FIPS images, custom packages, priority support)
- Integrate SBOM generation into your CI/CD pipeline
- Implement policy enforcement with signature verification

Thank you for completing the Chainguard Security Lab!
