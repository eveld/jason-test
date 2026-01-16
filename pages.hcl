# ============================================================================
# Chapter 1: Understanding Supply Chain Vulnerabilities
# ============================================================================

resource "page" "scan_traditional" {
  title = "Scanning a Traditional Container Image"
  file  = "instructions/01_vulnerabilities/scan_traditional.md"

  activities = {
    "scan_traditional_image" = resource.task.scan_traditional_image
  }
}

resource "page" "explore_attack_surface" {
  title = "Understanding the Attack Surface"
  file  = "instructions/01_vulnerabilities/explore_attack_surface.md"

  activities = {
    "explore_image_contents" = resource.task.explore_image_contents
  }
}

# ============================================================================
# Chapter 2: Switching to Chainguard Images
# ============================================================================

resource "page" "scan_chainguard" {
  title = "Pulling and Scanning a Chainguard Image"
  file  = "instructions/02_chainguard_images/scan_chainguard.md"

  activities = {
    "authenticate_chainguard" = resource.task.authenticate_chainguard
    "scan_chainguard_image"   = resource.task.scan_chainguard_image
  }
}

resource "page" "switch_application" {
  title = "Switching Your Application"
  file  = "instructions/02_chainguard_images/switch_application.md"

  activities = {
    "update_dockerfile"  = resource.task.update_dockerfile
    "build_secure_image" = resource.task.build_secure_image
  }
}

# ============================================================================
# Chapter 3: Securing Language Dependencies
# ============================================================================

resource "page" "scan_dependencies" {
  title = "Scanning Application Dependencies"
  file  = "instructions/03_secure_dependencies/scan_dependencies.md"

  activities = {
    "scan_dependencies" = resource.task.scan_dependencies
  }
}

resource "page" "configure_libraries" {
  title = "Configuring Chainguard Libraries"
  file  = "instructions/03_secure_dependencies/configure_libraries.md"

  activities = {
    "configure_package_manager"   = resource.task.configure_package_manager
    "install_secure_dependencies" = resource.task.install_secure_dependencies
  }
}

resource "page" "rebuild_secure" {
  title = "Rebuilding with Secure Dependencies"
  file  = "instructions/03_secure_dependencies/rebuild_secure.md"

  activities = {
    "rebuild_application" = resource.task.rebuild_application
  }
}

# ============================================================================
# Chapter 4: Compliance and Attestation
# ============================================================================

resource "page" "generate_sbom" {
  title = "Generating an SBOM"
  file  = "instructions/04_compliance/generate_sbom.md"

  activities = {
    "generate_sbom" = resource.task.generate_sbom
    "inspect_sbom"  = resource.task.inspect_sbom
  }
}

resource "page" "verify_signatures" {
  title = "Verifying Signatures and Attestations"
  file  = "instructions/04_compliance/verify_signatures.md"

  activities = {
    "verify_image_signature" = resource.task.verify_image_signature
    "verify_attestations"    = resource.task.verify_attestations
  }
}
