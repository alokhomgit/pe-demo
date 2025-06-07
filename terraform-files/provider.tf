provider "kubernetes" {
  config_path = var.KUBERNETES_CONFIG
}

provider "helm" {
  kubernetes {
    config_path = var.KUBERNETES_CONFIG
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