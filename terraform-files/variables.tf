variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-d"
}

variable "project_name" {
  description = "project name"
  default = "alokproject"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "~/.gcloud/Terraform.json"
}

variable "git_token" {
  description = "Git PAT"
  sensitive   = true
  type        = string
  default     = ""
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
  default     = ""
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
  default     = ""
}

variable "github_app_pem" {
  description = "The contents of the GitHub App private key PEM file"
  sensitive   = true
  type        = string
  default     = ""
}

variable "git_url" {
  description = "Git repository URL"
  type        = string
  default     = "https://github.com/alokhom/pe-demo"
}

variable "git_path" {
  description = "Path to the cluster manifests in the Git repository"
  type        = string
  default     = "clusters/dev"
}

variable "git_ref" {
  description = "Git branch or tag in the format refs/heads/main or refs/tags/v1.0.0"
  type        = string
  default     = "refs/heads/main"
}

variable "flux_version" {
  description = "Flux version semver range"
  type        = string
  default     = "2.x"
}

variable "flux_registry" {
  description = "Flux distribution registry"
  type        = string
  default     = "ghcr.io/fluxcd"
}

variable "docker_username" {
  description = "The ghcr.io docker username"
  type        = string
  default     = "alokhom"
}

variable "docker_password" {
  description = "The ghcr.io dockerpass"
  type        = string
  default     = "alokhom"
  sensitive   = true
}

variable "registry_username" {
  description = "The ghcr.io docker username"
  type        = string
  default     = "alokhom"
}

variable "registry_password" {
  description = "The ghcr.io docker password"
  type        = string
  default     = "alokhom"
  sensitive   = true
}

variable "registry_email" {
  description = "The ghcr.io docker username"
  type        = string
  default     = "alok.hom@gmail.com"
}

variable "registry_server" {
  description = "The ghcr.io"
  type        = string
  default     = "ghcr.io"
}
