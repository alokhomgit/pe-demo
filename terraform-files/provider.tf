locals {
    kube_config = yamldecode(file("~/.kube/gke_config"))
}

provider "kubernetes" {
    load_config_file = false

    host = local.kube_config.clusters[1].cluster.server
    cluster_ca_certificate = base64decode(local.kube_config.clusters[1].cluster.certificate-authority-data)
    client_certificate = base64decode(local.kube_config.users[1].user.client-certificate-data)
    client_key = base64decode(local.kube_config.users[1].user.client-key-data)
}

provider "helm" {
  kubernetes {
    load_config_file = false

    host = local.kube_config.clusters[1].cluster.server
    cluster_ca_certificate = base64decode(local.kube_config.clusters[1].cluster.certificate-authority-data)
    client_certificate = base64decode(local.kube_config.users[1].user.client-certificate-data)
    client_key = base64decode(local.kube_config.users[1].user.client-key-data)
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