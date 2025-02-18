locals {
  # Load root-level variables from root.hcl
  root_vars    = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  organization = local.root_vars.organization

  # Load account-level variables from account.hcl
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  profile      = local.account_vars.profile

  # Load environment-specific variables from environment.hcl
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  # Load region-specific variables from region.hcl
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals
  region      = local.region_vars.region

  # Extract the name of the parent folder containing datacenter.hcl (e.g., "aws")
  datacenter = basename(dirname(find_in_parent_folders("datacenter.hcl")))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    # S3 bucket for storing Terraform state
    bucket  = "terragrunt-${local.organization}-${local.profile}"
    profile = "${local.profile}"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

generate "provider" {
  # Generate the AWS provider configuration file (e.g., aws_provider.tf)
  path      = "${local.datacenter}_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
provider "aws" {
  region  = "${local.region}"
  profile = "${local.profile}"
  
  default_tags {
    tags = {
      environment = "${local.environment}"
      region      = "${local.region}"
      managedBy   = "terraform"
    }
  }
}
EOF
}
