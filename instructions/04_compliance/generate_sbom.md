# Generating Software Bills of Materials (SBOMs)

You've built a secure application, but how do you **prove** it to auditors, customers, or regulators? This is where Software Bills of Materials (SBOMs) come in.

## What Is an SBOM?

An SBOM is a complete inventory of all components in your software, including:
- Package names and versions
- Dependencies (direct and transitive)
- Licenses
- Supplier information
- Vulnerability associations

SBOMs are increasingly **required by regulations** like the US Executive Order on Cybersecurity and industry standards like NIST's Secure Software Development Framework.

## Why SBOMs Matter

SBOMs enable:
- **Compliance**: Meet regulatory and customer requirements
- **Vulnerability tracking**: Quickly identify if you're affected by newly discovered CVEs
- **License management**: Ensure you're not violating open-source licenses
- **Supply chain transparency**: Prove what's in your software

## Generate an SBOM

We'll use Syft, a tool from Anchore, to generate an SBOM for your secure application image.

Generate an SBOM in SPDX format (a standard format):

```bash
syft secure-app:v2 -o spdx-json > /root/lab/reports/secure-app.spdx.json
```

This creates a comprehensive inventory of everything in your image.

<instruqt-task id="generate_sbom"></instruqt-task>

## Inspect the SBOM

Let's examine what's in the SBOM:

```bash
# View the structure
jq 'keys' /root/lab/reports/secure-app.spdx.json

# Count components
jq '.packages | length' /root/lab/reports/secure-app.spdx.json

# List some packages
jq '.packages[:10] | .[] | {name: .name, version: .versionInfo}' /root/lab/reports/secure-app.spdx.json
```

The SBOM includes every component: the Node.js runtime, your application code, and all npm dependencies.

<instruqt-task id="inspect_sbom"></instruqt-task>

## Using SBOMs for Vulnerability Management

With an SBOM, you can:
- **Cross-reference with vulnerability databases**: Tools like Grype can scan SBOMs
- **Track components over time**: Compare SBOMs across versions
- **Respond to new CVEs**: Quickly determine if a newly announced vulnerability affects you

## What's Next?

SBOMs tell you **what** is in your software. But how do you prove the SBOM itself is authentic and hasn't been tampered with? In the next section, we'll verify cryptographic signatures and attestations.
