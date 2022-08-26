region = "southamerica-east1"

network_name       = "vpc-sandbox"
front_end_cidr     = "10.0.0.0/24"
back_end_cidr      = "10.0.1.0/24"
service_networking = "10.100.0.0" #/24
vpc_connector_cidr = "10.100.16.0/28"

resource_labels = {
  terraform = "true"
  app       = "cloud-foundation"
  purpose   = "test"
  env       = "sandbox"
}
