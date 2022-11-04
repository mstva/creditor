
resource "circleci_context" "development_context" {
  name = var.context_name
}

resource "circleci_context_environment_variable" "development_env_variables" {
  for_each   = var.context_env
  variable   = each.key
  value      = each.value
  context_id = circleci_context.development_context.id
}
