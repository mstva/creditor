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

provider "digitalocean" {
  token             = var.digitalocean.token
  spaces_access_id  = var.digitalocean.spaces_access_id
  spaces_secret_key = var.digitalocean.spaces_secret_key
}

provider "cloudamqp" {
  apikey = var.cloudamqp.api_key
}

provider "circleci" {
  api_token    = var.circleci.api_token
  vcs_type     = var.circleci.vcs_type
  organization = var.circleci.organization
}

locals {
  common = "${var.project_name}-${var.environment.common}"
  development = "${var.project_name}-${var.environment.development}"
  staging = "${var.project_name}-${var.environment.staging}"
  production = "${var.project_name}-${var.environment.production}"
}

resource "digitalocean_project" "project" {
  name        = var.project_name
  is_default  = true
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = "${var.project_name}_ssh_key"
  public_key = file("${path.module}/.ssh/id_rsa.pub")
}

resource "circleci_context" "common_context" {
  name = "${local.common}-context"
}

resource "circleci_context_environment_variable" "common_env_variables" {
  for_each   = var.common_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.common_context.id
}

module "development" {
  source                  = "./modules/development"

  droplet_name            = "${local.development}-server"
  droplet_image           = var.droplet.image
  droplet_region          = var.common.region
  droplet_size            = var.droplet.size
  droplet_ssh_keys        = [digitalocean_ssh_key.ssh_key.fingerprint]
  droplet_private_ssh_key = file("${path.module}/.ssh/id_rsa")
  droplet_scripts         = ["./scripts/install_docker.sh"]

  database_label          = "${local.development}-database"
  database_engine         = var.database.engine
  database_version        = var.database.version
  database_size           = var.database.size
  database_region         = var.common.region
  database_node_count     = var.database.node_count
  database_name           = var.database.name
  database_user           = var.database.user

  bucket_name             = "${local.development}-bucket-new"
  bucket_region           = var.common.region
  bucket_access_id        = var.digitalocean.spaces_access_id
  bucket_secret_key       = var.digitalocean.spaces_secret_key

  project                 = digitalocean_project.project.id

  rabbitmq_name           = "${local.development}-rabbitmq"
  rabbitmq_plan           = var.rabbitmq.plan
  rabbitmq_region         = var.rabbitmq.region

  context_name            = "${local.development}-context"
  context_env             = var.development_env
}

module "staging" {
  source                  = "./modules/staging"

  droplet_name            = "${local.staging}-server"
  droplet_image           = var.droplet.image
  droplet_region          = var.common.region
  droplet_size            = var.droplet.size
  droplet_ssh_keys        = [digitalocean_ssh_key.ssh_key.fingerprint]
  droplet_private_ssh_key = file("${path.module}/.ssh/id_rsa")
  droplet_scripts         = ["./scripts/install_docker.sh"]

  database_label          = "${local.staging}-database"
  database_engine         = var.database.engine
  database_version        = var.database.version
  database_size           = var.database.size
  database_region         = var.common.region
  database_node_count     = var.database.node_count
  database_name           = var.database.name
  database_user           = var.database.user

  bucket_name             = "${local.staging}-bucket-new"
  bucket_region           = var.common.region
  bucket_access_id        = var.digitalocean.spaces_access_id
  bucket_secret_key       = var.digitalocean.spaces_secret_key

  project                 = digitalocean_project.project.id

  rabbitmq_name           = "${local.staging}-rabbitmq"
  rabbitmq_plan           = var.rabbitmq.plan
  rabbitmq_region         = var.rabbitmq.region

  context_name            = "${local.staging}-context"
  context_env             = var.staging_env
}

module "production" {
  source                  = "./modules/production"

  droplet_name            = "${local.production}-server"
  droplet_image           = var.droplet.image
  droplet_region          = var.common.region
  droplet_size            = var.droplet.size
  droplet_ssh_keys        = [digitalocean_ssh_key.ssh_key.fingerprint]
  droplet_private_ssh_key = file("${path.module}/.ssh/id_rsa")
  droplet_scripts         = ["./scripts/install_docker.sh"]

  database_label          = "${local.production}-database"
  database_engine         = var.database.engine
  database_version        = var.database.version
  database_size           = var.database.size
  database_region         = var.common.region
  database_node_count     = var.database.node_count
  database_name           = var.database.name
  database_user           = var.database.user

  bucket_name             = "${local.production}-bucket-new"
  bucket_region           = var.common.region
  bucket_access_id        = var.digitalocean.spaces_access_id
  bucket_secret_key       = var.digitalocean.spaces_secret_key

  project                 = digitalocean_project.project.id

  rabbitmq_name           = "${local.production}-rabbitmq"
  rabbitmq_plan           = var.rabbitmq.plan
  rabbitmq_region         = var.rabbitmq.region

  context_name            = "${local.production}-context"
  context_env             = var.production_env
}
