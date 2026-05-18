variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "env" {
  description = "Environment: dev, staging, prod"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}