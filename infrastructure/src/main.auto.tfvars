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
