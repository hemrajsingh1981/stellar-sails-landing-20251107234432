locals {
  project_id = var.gcp_project_id
  region       = var.gcp_region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project = local.project_id
  region  = local.region
}

resource "google_cloud_run_v2_service" "app" {
  name     = "stellar-sails-app"
  location = local.region
  project  = local.project_id

  template {
    containers {
      image = "gcr.io/${var.gcp_project_id}/stellar-sails:latest" # TODO: Replace with actual image name from CI/CD pipeline
      ports {
        container_port = 3000
      }
    }
    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
}

resource "google_cloud_run_v2_service_iam_binding" "app_iam" {
  location = google_cloud_run_v2_service.app.location
  name     = google_cloud_run_v2_service.app.name
  project  = google_cloud_run_v2_service.app.project
  role     = "roles/run.invoker"

  members = [
    "allUsers",
  ]
}

output "cloud_run_service_name" {
  description = "The name of the Cloud Run service."
  value       = google_cloud_run_v2_service.app.name
}

output "cloud_run_service_url" {
  description = "The URL of the Cloud Run service."
  value       = google_cloud_run_v2_service.app.uri
}
