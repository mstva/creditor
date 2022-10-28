variable "droplet_name" {
  type = string
}

variable "droplet_image" {
  type = string
}

variable "droplet_region" {
  type = string
}

variable "droplet_size" {
  type = string
}

variable "droplet_ssh_keys" {
  type = list(any)
}

variable "droplet_private_ssh_key" {
  type = any
}

variable "droplet_scripts" {
  type = list(string)
}

variable "database_label" {
  type = string
}

variable "database_engine" {
  type = string
}

variable "database_version" {
  type = string
}

variable "database_size" {
  type = string
}

variable "database_region" {
  type = string
}

variable "database_node_count" {
  type = number
}

variable "database_name" {
  type = string
}

variable "database_user" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_region" {
  type = string
}

variable "project" {
  type = string
}


