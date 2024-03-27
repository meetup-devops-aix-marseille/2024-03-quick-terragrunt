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

inputs = {
  name        = "bucket-1.${local.env.name}.${local.global.customer.domain}"
  customer    = local.global.customer.name
  environment = local.env.name
  tags        = local.env.tags
}
