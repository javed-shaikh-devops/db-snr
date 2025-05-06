output "gke_cluster_name" {
  description = "Name of the created GKE cluster"
  value       = google_container_cluster.gke_autopilot_cluster.name
}

output "gke_cluster_region" {
  description = "Region of the GKE cluster"
  value       = google_container_cluster.gke_autopilot_cluster.location
}

output "project_id" {
  description = "GCP Project ID"
  value       = var.project_id
}
