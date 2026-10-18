locals {
  name_suffix = "${var.project}-${var.environment}"

  tags = {
    env     = var.environment
    owner   = var.owner
    cost    = var.cost_center
    project = var.project
  }
}
