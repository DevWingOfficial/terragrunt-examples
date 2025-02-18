locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  account_id   = "your-account-id"
  account_name = basename(get_terragrunt_dir()) # Return Folder Name ex: account

  profile = "${local.environment}-${local.account_name}"
}
