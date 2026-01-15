# Exploring the Attack Surface

You've seen that the `node:18` image contains hundreds of vulnerabilities. But what exactly is inside this image? Let's dig into the contents to understand why the vulnerability count is so high.

## Understanding Attack Surface

The **attack surface** of a container image consists of all the software components that could potentially be exploited by an attacker. The larger the attack surface, the more opportunities exist for security breaches.

Every package, library, and binary in your image is a potential entry point for attackers—even if your application never uses it.

## List Packages in the Image

Let's extract a complete list of all packages installed in the `node:18` image:

```bash
docker run --rm node:18 dpkg -l > /root/lab/reports/node18-packages.txt
```

This command runs a temporary container and uses `dpkg` (Debian's package manager) to list all installed packages. The output is saved to a file for analysis.

## Count the Packages

Now let's see just how many packages are included:

```bash
# Count lines (excluding header)
tail -n +6 /root/lab/reports/node18-packages.txt | wc -l > /root/lab/reports/package-count.txt

# Display the count
cat /root/lab/reports/package-count.txt
```

A typical `node:18` image contains **over 400 packages**. That's 400+ packages that need to be maintained, patched, and secured—even though your Node.js application only needs a handful of them.

## Analyze the Contents

Let's examine what some of these packages are:

```bash
# Show a sample of installed packages
tail -n +6 /root/lab/reports/node18-packages.txt | head -20
```

You'll see packages like:

- **gcc-12-base**: GNU Compiler Collection (why is a compiler in a production image?)
- **libc-bin**: C library binaries (required, but brings dependencies)
- **libssl3**: OpenSSL library (frequently has vulnerabilities)
- **perl-base**: Perl interpreter (rarely needed for Node.js apps)
- **binutils**: Binary utilities for development (definitely not needed in production)

Each of these packages—and the hundreds of others—can contain security vulnerabilities. Even packages you never directly use can be exploited if an attacker gains access to your container.

## The Key Problem

Here's the fundamental issue with traditional base images:

> **They're optimized for developer convenience, not production security.**

Traditional images include everything you might possibly need during development: shells for debugging, package managers for installing dependencies, compilers for building native modules, and system utilities for troubleshooting.

But in production, these tools become liabilities. They increase:
- **Attack surface**: More code means more vulnerabilities
- **Image size**: Longer pull times and higher storage costs
- **Maintenance burden**: More packages to track and patch

<instruqt-task id="explore_image_contents"></instruqt-task>

## Next Steps

Now that you understand why traditional images have so many vulnerabilities, you're ready to see the solution. In Chapter 2, we'll switch to Chainguard's minimal base images and watch the vulnerability count drop to **zero**.
