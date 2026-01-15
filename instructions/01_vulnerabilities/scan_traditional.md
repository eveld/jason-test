# Understanding Vulnerabilities in Traditional Images

Welcome to the Chainguard Security Lab! In this lab, you'll discover how traditional container images can harbor hundreds of security vulnerabilities—and learn how to eliminate them.

Let's start by examining a popular base image that millions of developers use every day: `node:18`. You might be surprised by what we find.

## Pull the Base Image

First, let's pull the official Node.js 18 image from Docker Hub:

```bash
docker pull node:18
```

This image is widely trusted and commonly used in production applications. But how secure is it really?

## Scan for Vulnerabilities

Now we'll use Grype, a vulnerability scanner, to examine what's inside this image. Grype checks every package against known vulnerability databases (CVEs).

Run the following command to scan the image and save the results:

```bash
grype node:18 -o json > /root/lab/reports/legacy-scan.json
```

The scan will take a moment. When it completes, you'll have a JSON file containing detailed vulnerability information.

## View the Results

Let's see how many vulnerabilities were found. We'll use `jq` to parse the JSON output:

```bash
# Count total vulnerabilities
jq '.matches | length' /root/lab/reports/legacy-scan.json

# Count by severity
jq '[.matches[].vulnerability.severity] | group_by(.) | map({severity: .[0], count: length})' /root/lab/reports/legacy-scan.json
```

The results might shock you. A typical `node:18` image contains **hundreds** of known vulnerabilities, including many marked as HIGH or CRITICAL severity.

## Why So Many Vulnerabilities?

Traditional base images are built for flexibility, not security. They include:

- **Full operating system packages**: Most images are based on Debian, Ubuntu, or Alpine, bringing along package managers, shells, and system utilities you'll never use
- **Build-time dependencies**: Compilers, headers, and development tools that should never exist in production
- **Legacy software**: Outdated libraries that remain for backward compatibility
- **Unnecessary binaries**: Utilities like curl, wget, and text editors that expand the attack surface

Each of these components can contain vulnerabilities. Even if your application code is perfect, these underlying packages create risk.

<instruqt-task id="scan_traditional_image"></instruqt-task>

## What's Next?

Now that you understand the problem, let's dig deeper into what's actually inside this image. In the next section, we'll explore the attack surface by examining package contents.
