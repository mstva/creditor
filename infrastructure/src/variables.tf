variable "digitalocean" {
  type    = map(string)
  default = {
    token             = "",
    spaces_access_id  = "",
    spaces_secret_key = ""
  }
}

variable "cloudamqp" {
  type    = map(string)
  default = {
    api_key = "",
  }
}

variable "circleci" {
  type    = map(string)
  default = {
    api_token    = ""
    vcs_type     = ""
    organization = ""
  }
}

variable "project_name" {
  type = string
  default = "crewtech"
}

variable "environment" {
  type    = map(string)
  default = {
    common = "common",
    base = "base",
    development = "development",
    staging     = "staging",
    production  = "production"
  }
}

variable "common" {
  type    = map(string)
  default = {
    region = ""
  }
}

variable "droplet" {
  type    = map(string)
  default = {
    image  = "",
    size   = "",
  }
}

variable "database" {
  type    = map(string)
  default = {
    engine     = "",
    version    = "",
    size       = ""
    node_count = ""
    name       = ""
    user       = ""
  }
}

variable "kubernetes" {
  type    = map(string)
  default = {
    version    = ""
    node_size  = ""
    node_count = ""
  }
}

variable "rabbitmq" {
  type    = map(string)
  default = {
    plan   = ""
    region = ""
  }
}

variable "common_env" {
  type = map(any)
}

variable "base_env" {
  type = map(any)
}

variable "development_env" {
  type = map(any)
}

variable "staging_env" {
  type = map(any)
}

variable "production_env" {
  type = map(any)
}

