locals {
  # Extracts the name of the current directory where Terragrunt is executed, 
  # assuming it represents the team name ("devops").
  team_name = basename(get_terragrunt_dir())
}
