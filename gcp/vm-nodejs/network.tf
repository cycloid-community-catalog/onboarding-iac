resource "google_compute_firewall" "webapp" {
  name    = "${var.customer}-${var.project}-${var.env}-webapp"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}