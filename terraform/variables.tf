
variable "gke_min_nodes" {
  default     = 1
  description = "Min number of gke nodes"
}

variable "gke_max_nodes" {
  default     = 3
  description = "Max number of nodes"
}

variable "project_id" {
  description = "project id"
  default     = "bux-assignment-mpetrovic"
}

variable "region" {
  description = "region"
  default     = "europe-west4"
}
