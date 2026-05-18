variable "project_id" {
  type        = string
  description = "Name of project"
}
variable "env" {
  type        = string
  description = "Environment name-dev,staging,prod"
}
variable "region" {
  type        = string
  description = "GCP region"
}
variable "subnet_cidr" {
  type        = string
  description = "CIDR for subnet"
}
variable "pod_cidr" {
  type        = string
  description = "CIDR for pods"
}
variable "services_cidr" {
  type        = string
  description = "CIDR for services"
}