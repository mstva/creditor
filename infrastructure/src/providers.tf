terraform {
  required_version = "1.3.1"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    cloudamqp = {
      source = "cloudamqp/cloudamqp"
      version = "1.20.0"
    }
    circleci = {
      source  = "mrolla/circleci"
      version = "0.6.1"
    }
  }
  backend "s3" {}
}

variable "project_name" {
  type = string
  default = "crewtech"
}
