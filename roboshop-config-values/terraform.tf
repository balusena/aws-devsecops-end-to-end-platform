provider "vault" {
  address = "http://vault-internal.robobal.store:8200"
  token   = var.token
}

terraform {
  backend "s3" {
    bucket = "terraform-b85"
    key    = "roboshop-config-values/terraform.tfstate"
    region = "us-east-1"
  }
}
