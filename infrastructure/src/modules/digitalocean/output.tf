output "SERVER_IP" {
  value = digitalocean_droplet.droplet.ipv4_address
}

output "POSTGRES_DB" {
  value = digitalocean_database_cluster.database.database
}

output "POSTGRES_USER" {
  value = digitalocean_database_cluster.database.user
}

output "POSTGRES_PASSWORD" {
  value = digitalocean_database_cluster.database.password
  sensitive = true
}

output "POSTGRES_HOST" {
  value = digitalocean_database_cluster.database.host
}

output "POSTGRES_PORT" {
  value = digitalocean_database_cluster.database.port
}

output "SPACE_NAME" {
  value = digitalocean_spaces_bucket.bucket.name
}

output "SPACE_ENDPOINT_URL" {
  value = replace(
    digitalocean_spaces_bucket.bucket.bucket_domain_name,
    "${digitalocean_spaces_bucket.bucket.name}.",
    "https://"
  )
}

output "SPACE_LOCATION_URL" {
  value = "https://${digitalocean_spaces_bucket.bucket.bucket_domain_name}"
}

output "SPACE_ACCESS_KEY" {
  value = var.bucket_access_id
}

output "SPACE_SECRET_KEY" {
  value = var.bucket_secret_key
}

