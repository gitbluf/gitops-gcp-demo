terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
  }

  required_version = "~> 1.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}
