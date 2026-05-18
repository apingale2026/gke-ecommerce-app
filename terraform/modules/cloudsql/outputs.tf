output "db_instance_name" {
    value = google_sql_database_instance.postgres.name
}
output "db_private_ip" {
    value = google_sql_database_instance.postgres.private_ip_address
}
output "db_connection" {
    value = google_sql_database_instance.postgres.connection_name
}