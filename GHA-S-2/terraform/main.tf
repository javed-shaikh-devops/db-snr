terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.75.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.credentials_json
}

resource "google_container_cluster" "gke_autopilot_cluster" {
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  network    = "default"
  subnetwork = "default"
}
