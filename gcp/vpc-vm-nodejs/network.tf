resource "google_compute_network" "webapp" {
  name = "${var.customer}-${var.project}-${var.env}-webapp"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "webapp" {
  name          = "${var.customer}-${var.project}-${var.env}-webapp"
  ip_cidr_range = "10.222.0.0/16"
  network       = google_compute_network.webapp.id
}