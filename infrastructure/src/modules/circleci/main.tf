terraform {
  required_providers {
    circleci = {
      source  = "mrolla/circleci"
    }
  }
}

resource "circleci_context" "context" {
  name = var.context_name
}

resource "circleci_context_environment_variable" "environment_variable" {
  for_each   = var.context_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.context.id
}

variable "context_name" {
  type = string
}

variable "context_env" {
  type = map(any)
}
