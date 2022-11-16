terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
}

resource "digitalocean_droplet" "droplet" {
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

resource "digitalocean_database_cluster" "database" {
  name       = var.database_label
  engine     = var.database_engine
  version    = var.database_version
  size       = var.database_size
  region     = var.database_region
  node_count = var.database_node_count
}

resource "digitalocean_database_db" "database_name" {
  cluster_id = digitalocean_database_cluster.database.id
  name       = var.database_name
}

resource "digitalocean_database_user" "database_user" {
  cluster_id = digitalocean_database_cluster.database.id
  name       = var.database_user
}

resource "digitalocean_spaces_bucket" "bucket" {
  name   = var.bucket_name
  region = var.bucket_region
}

resource "digitalocean_kubernetes_cluster" "kubernetes" {
  name    = var.kubernetes_name
  region  = var.kubernetes_region
  version = var.kubernetes_version
  node_pool {
    name       = var.kubernetes_node_name
    size       = var.kubernetes_node_size
    node_count = var.kubernetes_node_count
  }
}

resource "digitalocean_project_resources" "project" {
  project = var.project
  resources = [
    digitalocean_droplet.droplet.urn,
    digitalocean_database_cluster.database.urn,
    digitalocean_spaces_bucket.bucket.urn,
    digitalocean_kubernetes_cluster.kubernetes.urn,
  ]
}
