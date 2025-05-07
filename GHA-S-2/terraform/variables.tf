variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region where the cluster will be created"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name for the GKE cluster"
  type        = string
  default     = "dynamic-cluster"
}

variable "credentials_file" {
  description = "GCP Service Account Key JSON"
  type        = string
}
