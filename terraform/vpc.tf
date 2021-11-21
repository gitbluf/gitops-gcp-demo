module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 4.0.1"
  project_id   = var.project_id
  network_name = "${var.project_id}-vpc"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = "192.168.1.0/24"
      subnet_region = var.region
    }
  ]
}

resource "google_compute_router" "router" {
  project = var.project_id
  name    = "${var.project_id}-nat-router"
  network = module.vpc.network_name
  region  = var.region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 2.0.0"
  project_id                         = var.project_id
  region                             = var.region
  router                             = google_compute_router.router.name
  name                               = "${var.project_id}-nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
