
resource "cloudamqp_instance" "staging_rabbitmq" {
  name = var.rabbitmq_name
  plan = var.rabbitmq_plan
  region = var.rabbitmq_region
}
