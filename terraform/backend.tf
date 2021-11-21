# default from docs for test
terraform {
  backend "gcs" {
    bucket = "terraform-bux-demo-bucket"
    prefix = "terraform/state"
  }
}
