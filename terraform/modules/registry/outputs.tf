output "repository_id" {
  description = "The ID of the Artifact Registry repository"
  value       = google_artifact_registry_repository.my_repo.id
}

output "repository_url" {
  description = "Full URL to push Docker images"
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${var.project_id}-${var.env}-repo"
}