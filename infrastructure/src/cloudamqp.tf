provider "cloudamqp" {
  apikey = var.cloudamqp.api_key
}

module "cloudamqp" {
  for_each = var.rabbitmq_instances
  source   = "./modules/cloudamqp"
  name     = "${var.project_name}-${each.key}-rabbitmq"
  plan     = var.rabbitmq_common.plan
  region   = var.rabbitmq_common.region
}

variable "cloudamqp" {
  type    = map(string)
  default = {
    api_key = ""
  }
}

variable "rabbitmq_instances" {
  type    = map(map(string))
  default = {
    development = {}
    staging = {}
    production = {}
  }
}

variable "rabbitmq_common" {
  type = map(string)
  default = {
    plan   = "lemur"
    region = "amazon-web-services::eu-central-1"
  }
}
