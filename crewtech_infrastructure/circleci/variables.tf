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

variable "context" {
  type    = map(string)
  default = {
    common = "common_context",
    development = "development_context",
    staging = "staging_context",
    production = "production_context"
  }
}

variable "common_env" {
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

