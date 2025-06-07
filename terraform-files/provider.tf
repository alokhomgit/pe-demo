provider "kubernetes" {
  config_path = jsondecode(file(var.credentials_file))
}

provider "helm" {
  kubernetes {
    config_path = jsondecode(file(var.credentials_file))
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address    = "ghcr.io"
    username   = var.docker_username
    password   = var.docker_password
  }
}