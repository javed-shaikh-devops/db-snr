terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

resource "google_storage_bucket" "example_bucket" {
  name          = "${var.project_id}-example-bucket-${random_id.bucket_suffix.hex}"
  location      = var.region
  force_destroy = true
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
