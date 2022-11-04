
resource "cloudamqp_instance" "development_rabbitmq" {
  name = var.rabbitmq_name
  plan = var.rabbitmq_plan
  region = var.rabbitmq_region
}
