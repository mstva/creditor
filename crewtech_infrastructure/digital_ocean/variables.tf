variable "digitalocean" {
  type    = map(string)
  default = {
    token             = "",
    spaces_access_id  = "",
    spaces_secret_key = ""
  }
}

variable "project_name" {
  type = string
  default = "crewtech"
}

variable "environment" {
  type    = map(string)
  default = {
    development = "development",
    staging     = "staging",
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



