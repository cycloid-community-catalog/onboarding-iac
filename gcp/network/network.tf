resource "google_compute_network" "vpc" {
  name                    = "${var.customer}-${var.project}-${var.env}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "compute_public_subnetwork" {
  name                     = "${var.customer}-${var.project}-${var.env}-private"
  ip_cidr_range            = var.public_subnet_cidr
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "compute_private_subnetwork" {
  name                     = "${var.customer}-${var.project}-${var.env}-private"
  ip_cidr_range            = var.private_subnet_cidr
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

# NAT ROUTER
resource "google_compute_router" "compute_router" {
  name    = "${var.customer}-${var.project}-${var.env}"
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "compute_router_nat" {
  name                               = "${var.customer}-${var.project}-${var.env}"
  router                             = google_compute_router.compute_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                             = "${var.customer}-${var.project}-${var.env}-private"
    source_ip_ranges_to_nat          = ["ALL_IP_RANGES"]
  }
}