
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
   backend "gcs" {
     bucket = "tf-state-remote-gcp"
     prefix = "gke-project/state"
   }
}

provider "google" {
  project     = "gcp-devops-project-496602"
  region      = "asia-south1"
}