#VPC
resource "google_compute_network" "vpc" {
  project                 = "${var.project_id}"
  name                    = "${var.project_id}-${var.env}-vpc"
  auto_create_subnetworks = false
  
}
#Subnet
resource "google_compute_subnetwork" "subnet" {
  name                    = "${var.project_id}-${var.env}-subnet"
  region                  = var.region
  network                 = google_compute_network.vpc.id
  ip_cidr_range           = var.subnet_cidr

  secondary_ip_range {
    range_name              = "pods"
    ip_cidr_range           = var.pod_cidr
  }
  secondary_ip_range {
    range_name              = "services"
    ip_cidr_range           = var.services_cidr
  }
}
#Router
resource "google_compute_router" "example_router" {
  name    = "${var.project_id}-${var.env}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}
#NAT
resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_id}-${var.env}-nat"
  router                             = google_compute_router.example_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}
#Firewall
resource "google_compute_firewall" "firewall_internal" {
  name    = "${var.project_id}-${var.env}-firewall-internal"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = [var.subnet_cidr, var.pod_cidr, var.services_cidr]

}
# Reserve IP range for Google services
resource "google_compute_global_address" "private_ip_range" {
  name          = "${var.project_id}-${var.env}-sql-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

# Create private connection to Google services
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}