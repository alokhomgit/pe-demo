resource "local_file" "my_file" {
  content  = yamlencode(var.kubernetes_config)
  filename = "kubernetes_config.yaml"
}

provider "kubernetes" {
  config_path = "kubernetes_config.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "kubernetes_config.yaml"
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