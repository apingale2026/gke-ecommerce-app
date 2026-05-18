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

variable "vpc_name" {
  description = "VPC network name (from vpc module output)"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name (from vpc module output)"
  type        = string
}

variable "master_cidr" {
  description = "CIDR for GKE control plane — must be /28 and not overlap anything"
  type        = string
}

variable "node_count" {
  description = "Initial number of nodes"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "GCE machine type for nodes"
  type        = string
  default     = "e2-medium"
}

variable "min_nodes" {
  description = "Minimum nodes for autoscaling"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum nodes for autoscaling"
  type        = number
  default     = 3
}
