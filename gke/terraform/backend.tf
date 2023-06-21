# default from docs for test
terraform {
  backend "gcs" {
    bucket = "terraform-demo-bucket"
    prefix = "terraform/state"
  }
}
