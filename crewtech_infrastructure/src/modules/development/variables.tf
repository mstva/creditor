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

variable "bucket_access_id" {
  type = string
}

variable "bucket_secret_key" {
  type = string
}

variable "kubernetes_name" {
  type = string
}

variable "kubernetes_region" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "kubernetes_node_name" {
  type = string
}

variable "kubernetes_node_size" {
  type = string
}

variable "kubernetes_node_count" {
  type = string
}

variable "project" {
  type = string
}

variable "rabbitmq_name" {
  type = string
}

variable "rabbitmq_plan" {
  type = string
}

variable "rabbitmq_region" {
  type = string
}

variable "context_name" {
  type = string
}

variable "context_env" {
  type = map(any)
}


