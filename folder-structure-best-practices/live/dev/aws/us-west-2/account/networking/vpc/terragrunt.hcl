terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.7.1"
}

include "datacenter" {
  path = find_in_parent_folders("datacenter.hcl")
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
  environment      = local.environment_vars.environment

  service_name = basename(get_terragrunt_dir()) # Return Folder Name ex: vpc

  vpc_name = "${local.environment}-${local.service_name}"
}

inputs = {
  vpc_name             = local.vpc_name

  cidr_block           = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true
}