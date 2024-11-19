resource "google_artifact_registry_repository" "gatling_images" {
  name     = "gatling-images"
  format   = "DOCKER"
  location = "europe-west3"
}

resource "google_project_iam_binding" "artifact_registry_reader" {
  project = var.project_id

  role = "roles/artifactregistry.reader"

  members = [
    "serviceAccount:${var.github_actions_service_account_email}"
  ]
}
