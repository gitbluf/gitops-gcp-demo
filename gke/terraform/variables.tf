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
  default     = "project-id"
}

variable "region" {
  description = "region"
  default     = "europe-west4"
}

variable "labels" {
  description = "Node group labels"
  default     = {}
}
