variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "project_name" {
  description = "Short name prefix for resources"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "Cloud SQL password"
  type        = string
  sensitive   = true
}