locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  cluster_name = "${local.environment}-cluster"
}