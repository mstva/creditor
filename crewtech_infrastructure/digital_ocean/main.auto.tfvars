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
