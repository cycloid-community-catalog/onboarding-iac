resource "google_compute_firewall" "allow-internal" {
  name    = "${var.customer}-${var.project}-${var.env}-allow-internal"
  network = google_compute_network.vpc.id

  allow {
    protocol = "icmp"
  }
  
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  
  source_ranges = [
    var.public_subnet_cidr,
    var.private_subnet_cidr
  ]
}

resource "google_compute_firewall" "allow-http" {
  name    = "${var.customer}-${var.project}-${var.env}-allow-http"
  network = google_compute_network.vpc.id
  
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-https" {
  name    = "${var.customer}-${var.project}-${var.env}-allow-https"
  network = google_compute_network.vpc.id
  
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags = ["https"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-bastion" {
  name    = "${var.customer}-${var.project}-${var.env}-allow-bastion"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}