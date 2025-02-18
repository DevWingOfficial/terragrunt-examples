terraform {
  # Specifies the Terraform module source from the Terraform Registry using version 5.7.1
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.7.1"
}

include "datacenter" {
  # Finds and includes the datacenter.hcl configuration from a parent directory
  path = find_in_parent_folders("datacenter.hcl")
}

locals {
  # Load environment-specific variables from environment.hcl
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  # Extracts the name of the current directory where Terragrunt is executed,
  # assuming it represents the service name ("vpc").
  service_name = basename(get_terragrunt_dir())

  # Constructs the VPC name by combining the environment and service name (e.g., "dev-vpc").
  vpc_name = "${local.environment}-${local.service_name}"
}

inputs = {
  # Name of the VPC
  name = local.vpc_name

  # CIDR block for the VPC
  cidr_block = "10.0.0.0/16"

  # Enable DNS support and hostnames in the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true
}
