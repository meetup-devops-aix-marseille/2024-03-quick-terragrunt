locals {
  global        = yamldecode(file(find_in_parent_folders("global.yaml")))
  env           = yamldecode(file("env.yaml"))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.env.aws.region}"
}
EOF
}
