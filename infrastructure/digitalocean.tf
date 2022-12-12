provider "digitalocean" {
  token             = var.digitalocean.token
  spaces_access_id  = var.digitalocean.spaces_access_id
  spaces_secret_key = var.digitalocean.spaces_secret_key
}

resource "digitalocean_project" "project" {
  name        = var.project_name
  is_default  = true
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = "${var.project_name}_ssh_key"
  public_key = file("${path.module}/.ssh/id_rsa.pub")
}

module "digitalocean" {
  for_each                = var.digitalocean_instances
  source                  = "./modules/digitalocean"
  droplet_name            = "${var.project_name}-${each.key}-server"
  droplet_image           = var.digitalocean_common.droplet.image
  droplet_region          = var.digitalocean_common.common.region
  droplet_size            = var.digitalocean_common.droplet.size
  droplet_ssh_keys        = [digitalocean_ssh_key.ssh_key.fingerprint]
  droplet_private_ssh_key = file("${path.module}/.ssh/id_rsa")
  droplet_scripts         = ["./scripts/install_docker.sh"]
  database_label          = "${var.project_name}-${each.key}-database"
  database_engine         = var.digitalocean_common.database.engine
  database_version        = var.digitalocean_common.database.version
  database_size           = var.digitalocean_common.database.size
  database_region         = var.digitalocean_common.common.region
  database_node_count     = var.digitalocean_common.database.node_count
  database_name           = var.digitalocean_common.database.name
  database_user           = var.digitalocean_common.database.user
  bucket_name             = "${var.project_name}-${each.key}-bucket"
  bucket_region           = var.digitalocean_common.common.region
  bucket_access_id        = var.digitalocean.spaces_access_id
  bucket_secret_key       = var.digitalocean.spaces_secret_key
  kubernetes_name         = "${var.project_name}-${each.key}-kubernetes"
  kubernetes_region       = var.digitalocean_common.common.region
  kubernetes_version      = var.digitalocean_common.kubernetes.version
  kubernetes_node_name    = "${var.project_name}-${each.key}-kubernetes-node"
  kubernetes_node_size    = var.digitalocean_common.kubernetes.node_size
  kubernetes_node_count   = var.digitalocean_common.kubernetes.node_count
  project                 = digitalocean_project.project.id
}

output "digitalocean" {
  value = module.digitalocean
  sensitive = true
}

variable "digitalocean" {
  type    = map(string)
  default = {
    token             = "",
    spaces_access_id  = "",
    spaces_secret_key = ""
  }
}

variable "digitalocean_instances" {
  type    = map(map(string))
  default = {
    development = {}
    staging     = {}
    production  = {}
  }
}

variable "digitalocean_common" {
  type    = map(map(string))
  default = {

    common = {
      region = "fra1"
    }

    droplet = {
      image = "ubuntu-20-04-x64",
      size  = "s-1vcpu-1gb"
    }

    database = {
      engine     = "pg"
      version    = "14"
      size       = "db-s-1vcpu-1gb"
      node_count = "1"
      name       = "crewtech_db"
      user       = "crewtech_user"
    }

    kubernetes = {
      version    = "1.24.4-do.0"
      node_size  = "s-1vcpu-2gb"
      node_count = "2"
    }

  }
}
