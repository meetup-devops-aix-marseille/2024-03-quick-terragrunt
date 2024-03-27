locals {
  global = yamldecode(file(find_in_parent_folders("global.yaml")))
  env    = yamldecode(file(find_in_parent_folders("env.yaml")))
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/hoverkraft-tech/terraform-modules//aws/s3-bucket?ref=1.2.0"
}

dependency "bucket-1" {
  config_path                             = "../../bucket-1/bucket"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    id = "test-bucket-id"
  }
}

inputs = {
  name        = "bucket-2.${local.env.name}.${local.global.customer.domain}"
  customer    = local.global.customer.name
  environment = local.env.name
  tags        = local.env.tags
}
