provider "kubernetes" {
  config_path = "~/.kube/gke_config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/gke_config"
  }
}