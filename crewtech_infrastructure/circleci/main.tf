terraform {
  required_providers {
    circleci = {
      source  = "mrolla/circleci"
      version = "0.6.1"
    }
  }
  backend "s3" {}
}

provider "circleci" {
  api_token    = var.circleci.api_token
  vcs_type     = var.circleci.vcs_type
  organization = var.circleci.organization
}

locals {
  common = "${var.project_name}_${var.context.common}"
  development = "${var.project_name}_${var.context.development}"
  staging     = "${var.project_name}_${var.context.staging}"
  production  = "${var.project_name}_${var.context.production}"
}

resource "circleci_context" "common_context" {
  name = local.common
}

resource "circleci_context" "development_context" {
  name = local.development
}

resource "circleci_context" "staging_context" {
  name = local.staging
}

resource "circleci_context" "production_context" {
  name = local.production
}

resource "circleci_context_environment_variable" "common_env_variables" {
  for_each   = var.common_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.development_context.id
}

resource "circleci_context_environment_variable" "development_env_variables" {
  for_each   = var.development_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.development_context.id
}

resource "circleci_context_environment_variable" "staging_env_variables" {
  for_each   = var.staging_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.staging_context.id
}

resource "circleci_context_environment_variable" "production_env_variables" {
  for_each   = var.production_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.production_context.id
}
