# Postgres
resource "google_sql_database_instance" "postgres" {
  name             = "${var.project_id}-${var.env}-db"
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier              = var.db_tier
    availability_type = var.env == "prod" ? "REGIONAL" : "ZONAL"
    disk_size         = 10
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled = var.env == "prod" ? true : false
    }

    ip_configuration {
      ipv4_enabled    = false          # No public IP
      private_network = var.vpc_id
    }

    database_flags {
      name  = "max_connections"
      value = "100"
    }
  }

  deletion_protection = false          # Set true for real prod
}

# Database 
resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres.name
}

# DB User
resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres.name
  password = var.db_password
}
resource "google_secret_manager_secret" "db_password" {
  secret_id = "db-password"    # just creates the named slot
  replication { 
    auto {}
     }      # tells GCP which regions to store it
}

resource "google_secret_manager_secret_version" "db_password_value" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.db_password    
}