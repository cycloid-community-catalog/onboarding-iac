resource "google_compute_instance" "webapp" {
  name           = "${var.customer}-${var.project}-${var.env}-webapp"
  machine_type   = var.vm_machine_type
  can_ip_forward = false

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = var.vm_disk_size
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = var.network_name

    access_config {
      // Ephemeral public IP
      network_tier = "STANDARD"
    }
  }

  metadata_startup_script = templatefile(
    "${path.module}/userdata.sh.tpl",
    {
      git_app_url = var.git_app_url
    }
  )

  labels = merge(local.merged_tags, {
    role       = "webapp"
  })
}