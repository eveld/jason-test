# Terminal tab
resource "terminal" "shell" {
  target            = resource.container.workstation
  shell             = "/bin/bash"
  working_directory = "/root/lab"
  user              = "root"
  theme             = "dracula"

  # Custom prompt
  prompt = "\\[\\033[01;32m\\]chainguard-lab\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ "
}

# Code editor tab
resource "editor" "code" {
  workspace "lab_workspace" {
    target    = resource.container.workstation
    directory = "/root/lab"
  }
}
