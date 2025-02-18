locals {
  # Load environment-specific variables from environment.hcl
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  # AWS Account ID (Replace "your-account-id" with the actual account ID)
  account_id = "your-account-id"

  # Extracts the name of the current directory where Terragrunt is executed, 
  # assuming it represents the AWS account name ("sandbox").
  account_name = basename(get_terragrunt_dir())

  # Constructs an AWS profile name using the environment and account name ("dev-account").
  profile = "${local.environment}-${local.account_name}"
}
