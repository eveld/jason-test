# ============================================================================
# Chapter 1: Understanding Supply Chain Vulnerabilities
# ============================================================================

resource "task" "scan_traditional_image" {
  description = "Scan a traditional container image for vulnerabilities"

  config {
    target = resource.container.workstation
  }

  condition "scanner_installed" {
    description = "Vulnerability scanner is available"

    check {
      script          = "scripts/chapter1/scan_traditional_image/check_scanner_installed.sh"
      failure_message = "The scanner isn't installed yet. Did you run the installation command?"
    }
  }

  condition "image_pulled" {
    description = "Traditional base image is pulled locally"

    check {
      script          = "scripts/chapter1/scan_traditional_image/check_image_pulled.sh"
      failure_message = "The base image isn't available yet. Have you pulled it?"
    }
  }

  condition "scan_completed" {
    description = "Vulnerability scan has been executed"

    check {
      script          = "scripts/chapter1/scan_traditional_image/check_scan_completed.sh"
      failure_message = "No scan results found. Have you run the scanner against the image?"
    }
  }
}

resource "task" "explore_image_contents" {
  description = "Examine what's inside a traditional base image"

  config {
    target = resource.container.workstation
  }

  condition "package_list_extracted" {
    description = "Base image package list has been extracted"

    check {
      script          = "scripts/chapter1/explore_image_contents/check_package_list_extracted.sh"
      failure_message = "Package list not found. Have you listed the image contents?"
    }
  }

  condition "package_count_calculated" {
    description = "Total package count has been determined"

    check {
      script          = "scripts/chapter1/explore_image_contents/check_package_count_calculated.sh"
      failure_message = "Package count not calculated. How many packages are installed?"
    }
  }
}

# ============================================================================
# Chapter 2: Switching to Chainguard Images
# ============================================================================

resource "task" "authenticate_chainguard" {
  description = "Authenticate with Chainguard registry"

  config {
    target = resource.container.workstation
  }

  condition "credentials_configured" {
    description = "Docker credentials for Chainguard registry are configured"

    check {
      script          = "scripts/chapter2/authenticate_chainguard/check_credentials_configured.sh"
      failure_message = "Registry authentication not configured. Have you logged in to cgr.dev?"
    }
  }
}

resource "task" "scan_chainguard_image" {
  description = "Pull and scan a Chainguard image"

  config {
    target = resource.container.workstation
  }

  condition "chainguard_image_pulled" {
    description = "Chainguard node image is pulled locally"

    check {
      script          = "scripts/chapter2/scan_chainguard_image/check_chainguard_image_pulled.sh"
      failure_message = "Chainguard image not found. Have you pulled cgr.dev/chainguard/node?"
    }
  }

  condition "chainguard_scan_completed" {
    description = "Vulnerability scan has been run on Chainguard image"

    check {
      script          = "scripts/chapter2/scan_chainguard_image/check_chainguard_scan_completed.sh"
      failure_message = "Chainguard image hasn't been scanned yet. What do you find when you scan it?"
    }
  }

  condition "comparison_documented" {
    description = "CVE counts have been compared between images"

    check {
      script          = "scripts/chapter2/scan_chainguard_image/check_comparison_documented.sh"
      failure_message = "Comparison not documented. How many CVEs did each image have?"
    }
  }
}

resource "task" "update_dockerfile" {
  description = "Update Dockerfile to use Chainguard base image"

  config {
    target = resource.container.workstation
  }

  condition "dockerfile_modified" {
    description = "Dockerfile FROM line references Chainguard image"

    check {
      script          = "scripts/chapter2/update_dockerfile/check_dockerfile_modified.sh"
      failure_message = "Dockerfile hasn't been updated yet. Have you changed the FROM line?"
    }
  }
}

resource "task" "build_secure_image" {
  description = "Build application image with Chainguard base"

  config {
    target = resource.container.workstation
  }

  condition "image_built" {
    description = "Application image has been built successfully"

    check {
      script          = "scripts/chapter2/build_secure_image/check_image_built.sh"
      failure_message = "Image hasn't been built yet. Have you run docker build?"
    }
  }

  condition "application_runs" {
    description = "Application container starts and responds"

    check {
      script          = "scripts/chapter2/build_secure_image/check_application_runs.sh"
      failure_message = "Application isn't running yet. Did the container start successfully?"
    }
  }
}

# ============================================================================
# Chapter 3: Securing Language Dependencies
# ============================================================================

resource "task" "scan_dependencies" {
  description = "Scan application dependencies for vulnerabilities"

  config {
    target = resource.container.workstation
  }

  condition "package_manifest_exists" {
    description = "Package manifest file (package.json, requirements.txt, pom.xml) exists"

    check {
      script          = "scripts/chapter3/scan_dependencies/check_package_manifest_exists.sh"
      failure_message = "Package manifest not found. Is this a valid project?"
    }
  }

  condition "dependency_scan_completed" {
    description = "Dependencies have been scanned for CVEs"

    check {
      script          = "scripts/chapter3/scan_dependencies/check_dependency_scan_completed.sh"
      failure_message = "Dependencies haven't been scanned. Have you run the scanner?"
    }
  }
}

resource "task" "configure_package_manager" {
  description = "Configure package manager to use Chainguard Libraries"

  config {
    target = resource.container.workstation
  }

  condition "registry_configured" {
    description = "Package manager is configured to use Chainguard registry"

    check {
      script          = "scripts/chapter3/configure_package_manager/check_registry_configured.sh"
      failure_message = "Package manager configuration hasn't been updated. Have you added the Chainguard registry?"
    }
  }

  condition "registry_authenticated" {
    description = "Authentication credentials for Chainguard Libraries are configured"

    check {
      script          = "scripts/chapter3/configure_package_manager/check_registry_authenticated.sh"
      failure_message = "Registry authentication not configured. Have you set up your access token?"
    }
  }
}

resource "task" "install_secure_dependencies" {
  description = "Install dependencies from Chainguard Libraries"

  config {
    target = resource.container.workstation
  }

  condition "dependencies_installed" {
    description = "Application dependencies have been installed"

    check {
      script          = "scripts/chapter3/install_secure_dependencies/check_dependencies_installed.sh"
      failure_message = "Dependencies haven't been installed. Have you run the install command?"
    }
  }

  condition "provenance_verified" {
    description = "Package provenance has been verified"

    check {
      script          = "scripts/chapter3/install_secure_dependencies/check_provenance_verified.sh"
      failure_message = "Provenance not verified. Have you checked the SLSA attestations?"
    }
  }
}

resource "task" "rebuild_application" {
  description = "Rebuild application with Chainguard base and dependencies"

  config {
    target = resource.container.workstation
  }

  condition "image_rebuilt" {
    description = "Application image has been rebuilt with secure components"

    check {
      script          = "scripts/chapter3/rebuild_application/check_image_rebuilt.sh"
      failure_message = "Application hasn't been rebuilt. Have you run docker build again?"
    }
  }

  condition "final_scan_clean" {
    description = "Final vulnerability scan shows minimal CVEs"

    check {
      script          = "scripts/chapter3/rebuild_application/check_final_scan_clean.sh"
      failure_message = "Final scan shows vulnerabilities. Have you used both Chainguard images and libraries?"
    }
  }
}

# ============================================================================
# Chapter 4: Compliance and Attestation
# ============================================================================

resource "task" "generate_sbom" {
  description = "Generate a Software Bill of Materials for your image"

  config {
    target = resource.container.workstation
  }

  condition "sbom_generated" {
    description = "SBOM file has been generated in SPDX or CycloneDX format"

    check {
      script          = "scripts/chapter4/generate_sbom/check_sbom_generated.sh"
      failure_message = "SBOM not generated. Have you run the SBOM generation tool?"
    }
  }

  condition "sbom_validated" {
    description = "SBOM format is valid and complete"

    check {
      script          = "scripts/chapter4/generate_sbom/check_sbom_validated.sh"
      failure_message = "SBOM validation failed. Is the format correct?"
    }
  }
}

resource "task" "inspect_sbom" {
  description = "Examine SBOM contents"

  config {
    target = resource.container.workstation
  }

  condition "components_listed" {
    description = "SBOM lists all software components"

    check {
      script          = "scripts/chapter4/inspect_sbom/check_components_listed.sh"
      failure_message = "SBOM doesn't show components. Have you opened and reviewed it?"
    }
  }
}

resource "task" "verify_image_signature" {
  description = "Verify Chainguard image signature"

  config {
    target = resource.container.workstation
  }

  condition "cosign_installed" {
    description = "Cosign tool is available for signature verification"

    check {
      script          = "scripts/chapter4/verify_signatures/check_cosign_installed.sh"
      failure_message = "Cosign not available. Have you installed it?"
    }
  }

  condition "signature_verified" {
    description = "Image signature has been verified successfully"

    check {
      script          = "scripts/chapter4/verify_signatures/check_signature_verified.sh"
      failure_message = "Signature verification failed or hasn't been attempted. Have you run cosign verify?"
    }
  }
}

resource "task" "verify_attestations" {
  description = "Verify SLSA provenance attestations"

  config {
    target = resource.container.workstation
  }

  condition "attestation_downloaded" {
    description = "SLSA attestation has been retrieved"

    check {
      script          = "scripts/chapter4/verify_signatures/check_attestation_downloaded.sh"
      failure_message = "Attestation not retrieved. Have you downloaded it from the registry?"
    }
  }

  condition "attestation_verified" {
    description = "Attestation signature is valid"

    check {
      script          = "scripts/chapter4/verify_signatures/check_attestation_verified.sh"
      failure_message = "Attestation verification failed. Have you verified the signature?"
    }
  }

  condition "provenance_inspected" {
    description = "Provenance data has been examined"

    check {
      script          = "scripts/chapter4/verify_signatures/check_provenance_inspected.sh"
      failure_message = "Provenance not inspected. What does the attestation tell you about how this was built?"
    }
  }
}
