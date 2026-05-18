variable "project_id" { 
   type = string 
   description = "Project_ID"
}
variable "region" {
  description = "GCP region"
  type        = string
}

variable "db_password" {
  description = "Cloud SQL password"
  type        = string
  sensitive   = true
}
variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
variable "project_name" {
  description = "Short name prefix for resources"
  type        = string
}

