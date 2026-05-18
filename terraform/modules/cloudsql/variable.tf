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
variable "vpc_id" {
  description = "VPC self_link for private IP"
  type        = string
}

variable "db_tier" {
  description = "Cloud SQL machine tier"
  type        = string
  default     = "db-f1-micro"   # Free-tier friendly
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "ecommerce"
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
