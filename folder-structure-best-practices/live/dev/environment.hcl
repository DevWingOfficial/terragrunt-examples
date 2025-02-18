locals {
  # Extract the name of the current directory where Terragrunt is executed ("dev")
  environment = basename(get_terragrunt_dir())
}
