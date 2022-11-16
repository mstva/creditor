terraform {
  required_providers {
    cloudamqp = {
      source = "cloudamqp/cloudamqp"
    }
  }
}

resource "cloudamqp_instance" "instance" {
  name = var.name
  plan = var.plan
  region = var.region
}

output "RABBITMQ_URL" {
  value = cloudamqp_instance.instance.url
}

variable "name" {
  type = string
}

variable "plan" {
  type = string
}

variable "region" {
  type = string
}


