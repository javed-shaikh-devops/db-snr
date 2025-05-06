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
<<<<<<< HEAD
  credentials = file(var.credentials_file)
=======
  credentials = var.credentials_json
>>>>>>> f72e42a6fc05a36898c9371458b6f906e6a7e6e8
}

resource "google_container_cluster" "gke_autopilot_cluster" {
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  network    = "default"
  subnetwork = "default"
}
