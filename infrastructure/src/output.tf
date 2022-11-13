output "development" {
  value = module.development
  sensitive = true
}

output "staging" {
  value = module.staging
  sensitive = true
}

output "production" {
  value = module.production
  sensitive = true
}
