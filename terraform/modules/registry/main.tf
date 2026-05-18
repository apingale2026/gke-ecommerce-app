resource "google_artifact_registry_repository" "my_repo" {
  location      = var.region
  repository_id = "${var.project_id}-${var.env}-repo"
  description   = "Artifact Registry Repository"
  format        = "DOCKER"
}