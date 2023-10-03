#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the instance"
  value       = google_compute_instance.webapp.network_interface.0.access_config.0.nat_ip
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = "admin"
}