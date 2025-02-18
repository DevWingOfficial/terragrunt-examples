locals {
  # Extracts the name of the current directory where Terragrunt is executed, 
  # assuming it represents the AWS region ("us-west-2").
  region = basename(get_terragrunt_dir())
}
