resource "lab" "chainguard_security" {
  title       = "Securing Your Supply Chain with Chainguard"
  description = file("description.md")
  tags        = ["security", "containers", "supply-chain", "chainguard", "docker"]

  settings {
    timelimit {
      duration    = 45
      extend      = 15
      show_timer  = true
    }

    idle {
      enabled      = true
      timeout      = 30
      show_warning = true
    }

    controls {
      show_stop = true
    }
  }

  # Use split-screen layout for all pages
  layout = resource.layout.split_terminal_instructions

  content {
    chapter "understanding_vulnerabilities" {
      title = "Understanding Supply Chain Vulnerabilities"

      page "scan_traditional" {
        title     = "Scanning a Traditional Container Image"
        reference = resource.page.scan_traditional
      }

      page "explore_attack_surface" {
        title     = "Understanding the Attack Surface"
        reference = resource.page.explore_attack_surface
      }
    }

    chapter "chainguard_images" {
      title = "Switching to Chainguard Images"

      page "scan_chainguard" {
        title     = "Pulling and Scanning a Chainguard Image"
        reference = resource.page.scan_chainguard
      }

      page "switch_application" {
        title     = "Switching Your Application"
        reference = resource.page.switch_application
      }
    }

    chapter "secure_dependencies" {
      title = "Securing Language Dependencies"

      page "scan_dependencies" {
        title     = "Scanning Application Dependencies"
        reference = resource.page.scan_dependencies
      }

      page "configure_libraries" {
        title     = "Configuring Chainguard Libraries"
        reference = resource.page.configure_libraries
      }

      page "rebuild_secure" {
        title     = "Rebuilding with Secure Dependencies"
        reference = resource.page.rebuild_secure
      }
    }

    chapter "compliance_attestation" {
      title = "Compliance and Attestation"

      page "generate_sbom" {
        title     = "Generating an SBOM"
        reference = resource.page.generate_sbom
      }

      page "verify_signatures" {
        title     = "Verifying Signatures and Attestations"
        reference = resource.page.verify_signatures
      }
    }
  }
}
