# Switching Your Application to Chainguard Images

You've proven that Chainguard Images dramatically reduce vulnerabilities. Now let's see just how easy it is to migrate your application to use them.

Spoiler: It's a **one-line change**.

## The Original Dockerfile

Let's look at the sample application's Dockerfile. It currently uses the traditional `node:18` image:

```bash
cat /root/lab/app/Dockerfile
```

You'll see something like:

```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["node", "src/server.js"]
```

This is a standard Node.js Dockerfile pattern. It works, but it brings all those vulnerabilities we discovered earlier.

## Update the Base Image

Here's all you need to do: change the `FROM` line to use the Chainguard image.

**Before:**
```dockerfile
FROM node:18
```

**After:**
```dockerfile
FROM cgr.dev/chainguard/node:latest-dev
```

Note we're using the `:latest-dev` variant, which includes npm and yarn for installing dependencies. Chainguard also offers a `:latest` variant (even more minimal) for production after dependencies are installed.

Edit the Dockerfile now:

```bash
nano /root/lab/app/Dockerfile
# Or use your preferred editor: vim, vi, etc.
```

Make the one-line change and save the file.

<instruqt-task id="update_dockerfile"></instruqt-task>

## Build the Secure Image

Now let's build a new container image using the Chainguard base:

```bash
cd /root/lab/app
docker build -t secure-app:latest .
```

The build process should complete successfully. Chainguard Images are drop-in replacements for standard images—your application code doesn't need any modifications.

## Run the Application

Let's verify the application works correctly:

```bash
docker run -d -p 3000:3000 --name secure-app secure-app:latest
```

Test that the application responds:

```bash
curl http://localhost:3000/health
```

You should see a JSON response confirming the application is running.

<instruqt-task id="build_secure_image"></instruqt-task>

## The Key Insight

You just reduced your application's attack surface by 99%+ with a **single line change**. No code refactoring, no dependency updates, no configuration changes.

This is the power of secure base images:
- **Immediate impact**: Massive vulnerability reduction
- **Zero disruption**: Drop-in replacement for existing workflows
- **Ongoing protection**: Automatic updates as new vulnerabilities are discovered

## Optional: Scan the New Image

Want to verify the improvement? Scan your newly built image:

```bash
grype secure-app:latest -o json > /root/lab/reports/secure-app-scan.json
jq '.matches | length' /root/lab/reports/secure-app-scan.json
```

You should see the same low vulnerability count we observed with the base Chainguard image.

## What's Next?

Base images are just the beginning. In Chapter 3, we'll tackle the other major source of vulnerabilities: **your application's dependencies**. We'll show you how to secure your npm packages using Chainguard Libraries.
