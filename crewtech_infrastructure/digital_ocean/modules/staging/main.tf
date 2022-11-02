terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
    cloudamqp = {
      source = "cloudamqp/cloudamqp"
    }
  }
}

resource "digitalocean_droplet" "staging_droplet" {
  name     = var.droplet_name
  image    = var.droplet_image
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = var.droplet_ssh_keys

  provisioner "remote-exec" {

    connection {
      type = "ssh"
      user = "root"
      host = self.ipv4_address
      private_key = var.droplet_private_ssh_key
    }

    scripts = var.droplet_scripts
  }
}

resource "digitalocean_database_cluster" "staging_database" {
  name       = var.database_label
  engine     = var.database_engine
  version    = var.database_version
  size       = var.database_size
  region     = var.database_region
  node_count = var.database_node_count
}

resource "digitalocean_database_db" "staging_database_name" {
  cluster_id = digitalocean_database_cluster.staging_database.id
  name       = var.database_name
}

resource "digitalocean_database_user" "staging_database_user" {
  cluster_id = digitalocean_database_cluster.staging_database.id
  name       = var.database_user
}

resource "digitalocean_spaces_bucket" "staging_bucket" {
  name   = var.bucket_name
  region = var.bucket_region
}

resource "digitalocean_project_resources" "project" {
  project = var.project
  resources = [
    digitalocean_droplet.staging_droplet.urn,
    digitalocean_database_cluster.staging_database.urn,
    digitalocean_spaces_bucket.staging_bucket.urn
  ]
}

resource "cloudamqp_instance" "staging_rabbitmq" {
  name = var.rabbitmq_name
  plan = var.rabbitmq_plan
  region = var.rabbitmq_region
}
