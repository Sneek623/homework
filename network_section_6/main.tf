resource "google_compute_network" "auto-network-tf" {
name ="auto-network-tf"
auto_create_subnetworks = true
}

resource "google_compute_network" "custom-network-tf" {
    name = "custom-vpc-tf"
    auto_create_subnetworks = false
}

output "auto-network" {
    value = google_compute_network.auto-network-tf.name
}

output "custom-network" {
 value = google_compute_network.custom-network-tf.name
}

resource "google_compute_subnetwork" "custom-subnetwork-tf" {
  name = "custom-subnetwork"
  network = google_compute_network.custom-network-tf.name
  ip_cidr_range = "10.187.0.0/24"
  region = "us-central1"
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow-traffic" {
    name = "allow-traffic"
    network = google_compute_network.custom-network-tf.id
    source_ranges = ["0.0.0.0/0"]
    allow {
        ports = ["80", "443"]
        protocol = "tcp"
     }
}