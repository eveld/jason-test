# Configuring Chainguard Libraries

Now that you understand the dependency security problem, let's solve it with Chainguard Libraries—a registry of hardened, verified npm packages.

## What Are Chainguard Libraries?

Chainguard Libraries provide:
- **Hardened packages**: Rebuilt with security patches applied
- **Zero-CVE guarantee**: All packages scanned and verified
- **Provenance attestations**: Cryptographic proof of build integrity
- **Regular updates**: Automated rebuilds when vulnerabilities are discovered

Libraries are compatible with standard package managers (npm, yarn, pnpm) and serve as a drop-in replacement for public registries.

## Configure Your Package Manager

To use Chainguard Libraries, you need to configure npm to pull packages from the Chainguard registry. This is typically done in a `.npmrc` file.

Create or update `/root/lab/app/.npmrc` to point to the Chainguard registry:

```
registry=https://cgr.dev/chainguard/npm/
```

For authentication (if required by your Chainguard subscription), you would also add an auth token. For this lab, we're using publicly available packages.

**Hint**: Check the Chainguard documentation for the exact registry URL and authentication method for your setup.

<instruqt-task id="configure_package_manager"></instruqt-task>

## Install Secure Dependencies

Once configured, reinstall your dependencies from the Chainguard registry:

```bash
cd /root/lab/app
rm -rf node_modules package-lock.json
npm install
```

The packages will now come from Chainguard's hardened registry instead of the public npm registry.

## Verify Provenance

Chainguard packages include provenance attestations that prove:
- Where the package was built
- What source code was used
- When it was built
- That it hasn't been tampered with

You can verify provenance using tools like `cosign` (which we'll explore more in Chapter 4). For now, check that your installation completed without warnings about unsigned or unverified packages.

<instruqt-task id="install_secure_dependencies"></instruqt-task>

## What's Next?

With hardened dependencies installed, let's rebuild your application and verify that the final image has minimal vulnerabilities across both the base image **and** dependencies.
