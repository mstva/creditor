provider "circleci" {
  api_token    = var.circleci.api_token
  vcs_type     = var.circleci.vcs_type
  organization = var.circleci.organization
}

module "circleci" {
  for_each     = var.circleci_contexts
  source       = "./modules/circleci"
  context_env  = each.value
  context_name = "${var.project_name}-${each.key}-context"
}

variable "circleci" {
  type    = map(string)
  default = {
    api_token    = ""
    vcs_type     = ""
    organization = ""
  }
}

variable "circleci_contexts" {
  type    = map(map(string))
  default = {
    common      = {}
    base        = {}
    development = {}
    staging     = {}
    production  = {}
  }
}
