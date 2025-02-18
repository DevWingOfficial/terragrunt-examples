locals {
  # Load environment-specific variables from environment.hcl
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  # Extracts the name of the current directory where Terragrunt is executed, 
  # assuming it represent the service name ("cluster").
  service_name = basename(get_terragrunt_dir())

  # Constructs the EKS cluster name by combining the environment and service name (e.g., "dev-cluster").
  cluster_name = "${local.environment}-${local.service_name}"
}
