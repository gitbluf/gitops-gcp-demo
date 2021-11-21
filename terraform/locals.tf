locals {
  subnet_name = "${var.project_id}-subnet"
  labels      = merge(var.labels, { env = var.project_id })
}
