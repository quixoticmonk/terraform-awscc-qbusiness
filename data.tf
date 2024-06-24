data "aws_ssoadmin_instances" "this" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

locals {
  kms_key = length(var.app_kms_key)>0 ? var.app_kms_key : awscc_kms_key.this[0].id
  create_kms_key = length(var.app_kms_key) > 0  && var.enable_encryption ? false : true
}
