resource "google_compute_firewall" "allow_rdp" {
  name    = "${module.vpc.network_name}-allow-rdp-from-iap"
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = [
    "35.235.240.0/20"
  ]

  target_tags = [
    "allow-rdp"
  ]
}

resource "google_compute_firewall" "allow_front_to_back" {
  name    = "${module.vpc.network_name}-allow-front-to-back"
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
    ports    = ["8080", "80", "433"]
  }

  source_tags = [
    "front-end"
  ]

  target_tags = [
    "back-end"
  ]
}

resource "google_compute_firewall" "allow_hc" {
  name    = "${module.vpc.network_name}-allow-health-checks"
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]

  target_tags = [
    "allow-hc"
  ]
}
