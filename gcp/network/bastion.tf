module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"
  version = "6.0.0"

  project = var.gcp_project
  network = google_compute_network.vpc.self_link
  subnet = google_compute_subnetwork.compute_public_subnetwork.self_link
  
  tags = [ "ssh", "http", "https" ]
}