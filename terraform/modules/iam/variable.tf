variable "project_id" { type = string }
variable "project_name" { type = string }
variable "env" { type = string }
variable "k8s_namespace" {
  description = "Kubernetes namespace where the app runs"
  type        = string
  default     = "backend"
}
variable "k8s_sa_name" {
  description = "Kubernetes service account name"
  type        = string
  default     = "app-sa"
}
