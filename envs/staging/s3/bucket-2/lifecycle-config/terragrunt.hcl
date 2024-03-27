locals {
  global = yamldecode(file(find_in_parent_folders("global.yaml")))
  env    = yamldecode(file(find_in_parent_folders("env.yaml")))
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/hoverkraft-tech/terraform-modules//aws/s3-bucket-lifecycle-config?ref=1.2.0"
}

dependency "bucket" {
  config_path                             = "../bucket"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    id = "test-bucket-id"
  }
}

inputs = {
  name        = "bucket-1-${local.env.name}"
  customer    = local.global.customer.name
  environment = local.env.name
  tags        = merge(local.env.tags)
  bucket_id   = dependency.bucket.outputs.id
  rules = [
    {
      name   = "Default"
      status = "Enabled"
      expiration = {
        days = 30
      }
    },
  ]
}
