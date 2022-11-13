
resource "cloudamqp_instance" "production_rabbitmq" {
  name = var.rabbitmq_name
  plan = var.rabbitmq_plan
  region = var.rabbitmq_region
}
