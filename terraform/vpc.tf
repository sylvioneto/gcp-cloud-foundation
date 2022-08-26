module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 5.0"
  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "${var.network_name}-fe-${var.region}"
      subnet_ip             = var.front_end_cidr
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "${var.network_name}-be-${var.region}"
      subnet_ip             = var.back_end_cidr
      subnet_region         = var.region
      subnet_private_access = true
    },
  ]
}

resource "google_compute_global_address" "service_range" {
  name          = "service-networking"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = var.service_networking
  prefix_length = 24
  network       = module.vpc.network_name
}

resource "google_service_networking_connection" "private_service_connection" {
  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.service_range.name]
}

resource "google_vpc_access_connector" "connector" {
  name          = "${module.vpc.network_name}-connector"
  ip_cidr_range = var.vpc_connector_cidr
  network       = module.vpc.network_self_link
}
