output "gke_cluster_name" {
    value = module.gke.cluster_name
}
output "db_private_ip" {
    value = module.cloudsql.db_private_ip
}
output "app_sa_email" {
    value = module.iam.app_sa_email
}
output "registry_url" {
    value = module.registry.repository_url
}