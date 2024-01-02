module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"
  version = "6.0.0"

  project = var.gcp_project
  network = google_compute_network.vpc.id
  subnet = google_compute_subnetwork.compute_public_subnetwork.id
  
  tags = [ "ssh", "http", "https" ]
}