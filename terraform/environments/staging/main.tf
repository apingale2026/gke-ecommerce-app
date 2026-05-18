terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
   backend "gcs" {
     bucket = "tf-state-remote-gcp"
     prefix = "gke-project/prod/state"
   }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}
#Enable APIs
resource "google_project_service" "apis" {
  for_each = toset([
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "artifactregistry.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
  ])
  service            = each.key
  disable_on_destroy = false
}

module "vpc" {
  source = "../modules/vpc"  
  
  project_id = var.project_id
  env = "prod"
  region = var.region
  subnet_cidr = "10.10.0.0/24"
  pod_cidr = "10.11.0.0/16"
  services_cidr = "10.12.0.0/16"
  depends_on = [ google_project_service.apis ]
}

module "gke" {
  source = "../modules/gke"  
  
  project_id = var.project_id
  env = "prod"
  region = var.region
  vpc_name = module.vpc.vpc_name
  subnet_name = module.vpc.subnet_name
  master_cidr = "172.16.1.0/28"
  node_count = 1
  machine_type = "e2-medium"
  min_nodes = "2"
  max_nodes = "4"
  depends_on = [ module.vpc ]
}

module "iam" {
  source = "../modules/iam"  
  
  project_id = var.project_id
  env = "prod"
  k8s_namespace = "backend"
  k8s_sa_name = "app-sa"
  depends_on = [ module.gke ]
}

module "registry" {
  source = "../modules/registry"
  project_id = var.project_id
  env = "prod"
  region = var.region

}
module "cloudsql" {
  source = "../modules/cloudsql"
  project_id = var.project_id
  env = "prod"
  region = var.region
  vpc_id = module.vpc.vpc_id
  db_tier = "db-f1-micro"
  db_name = "ecommerce"
  db_user = "appuser"
  db_password = var.db_password
  

}

