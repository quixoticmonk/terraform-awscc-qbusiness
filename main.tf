resource "awscc_qbusiness_application" "this" {
  display_name                 = "${var.prefix}_q_app"
  description                  = "${var.prefix} QBusiness Application"
  encryption_configuration     = local.encryption_config
  identity_center_instance_arn = data.aws_ssoadmin_instances.this.arns[0]
  # role_arn                     = var.app_role_arn ? var.app_role_arn : ""
  attachments_configuration = {
    attachments_control_mode = "ENABLED"
  }

  tags = var.tags

}


resource "awscc_kms_key" "this" {
  count                  = local.create_kms_key ? 1 : 0
  description            = "KMS Key for root"
  enabled                = "true"
  enable_key_rotation    = "false"
  pending_window_in_days = 30
  key_policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "KMS-Key-Policy-For-Root",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
    ],
    },
  )
  tags = var.tags
}


resource "awscc_qbusiness_index" "this" {
  application_id = awscc_qbusiness_application.this.application_id
  display_name   = "${var.prefix}_q_index"
  description    = "${var.prefix} QBusiness Index"
  type           = var.index_type
  capacity_configuration = {
    units = var.storage_units
  }
  document_attribute_configurations = var.attribute_config
  tags                              = var.tags

}

resource "awscc_qbusiness_retriever" "this" {
  application_id = awscc_qbusiness_application.this.application_id
  display_name   = "${var.prefix}_q_retriever"
  type           = "NATIVE_INDEX"
  # role_arn = ""

  configuration = {
    native_index_configuration = {
      index_id = awscc_qbusiness_index.this.index_id
    }
  }
  tags = var.tags

}

resource "awscc_qbusiness_web_experience" "this" {
  application_id              = awscc_qbusiness_application.this.application_id
  role_arn                    = awscc_iam_role.this.arn
  sample_prompts_control_mode = "ENABLED"
  subtitle                    = var.web_exp_subtitle
  title                       = var.web_exp_title
  welcome_message             = var.welcome_message

  tags = var.tags
}

resource "awscc_iam_role" "this" {
  role_name   = "Amazon-QBusiness-WebExperience-Role-${var.prefix}"
  description = "Grants permissions to AWS Services and Resources used or managed by Amazon Q Business"
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "QBusinessTrustPolicy"
        Effect = "Allow"
        Principal = {
          Service = "application.qbusiness.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:SetContext"
        ]
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
          ArnEquals = {
            "aws:SourceArn" = awscc_qbusiness_application.this.application_arn
          }
        }
      }
    ]
  })
  policies = [{
    policy_name = "qbusiness_policy"
    policy_document = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "QBusinessConversationPermission"
          Effect = "Allow"
          Action = [
            "qbusiness:Chat",
            "qbusiness:ChatSync",
            "qbusiness:ListMessages",
            "qbusiness:ListConversations",
            "qbusiness:DeleteConversation",
            "qbusiness:PutFeedback",
            "qbusiness:GetWebExperience",
            "qbusiness:GetApplication",
            "qbusiness:ListPlugins",
            "qbusiness:GetChatControlsConfiguration"
          ]
          Resource = awscc_qbusiness_application.this.application_arn
        }
      ]
    })
  }]
  tags = var.tags
}

# resource "awscc_qbusiness_data_source" "exaple" {
#   application_id = awscc_qbusiness_application.this.application_id
#   display_name   = "${var.prefix}_q_data_source"
#   index_id       = awscc_qbusiness_index.this.index_id
#   role_arn       = awscc_iam_role.ds.arn
#   configuration = jsonencode(
#     {
#       type     = "S3"
#       version  = "1.0.0"
#       syncMode = "FORCED_FULL_CRAWL"
#       connectionConfiguration = {
#         repositoryEndpointMetadata = {
#           BucketName = var.bucket_name
#         }
#       }
#       additionalProperties = {
#         inclusionPrefixes = ["docs/"]
#       }
#       repositoryConfigurations = {
#         document = {
#           fieldMappings = [
#             {
#               dataSourceFieldName = "s3_document_id"
#               indexFieldType      = "STRING"
#               indexFieldName      = "s3_document_id"
#             }
#           ]
#         }
#       }
#     }
#   )
#   tags = [{
#     key   = "Modified By"
#     value = "AWSCC"
#   }]
# }

# resource "awscc_iam_role" "this" {
#   role_name   = "QBusiness-DataSource-Role"
#   description = "QBusiness Data source role"
#   assume_role_policy_document = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid    = "AllowsAmazonQToAssumeRoleForServicePrincipal"
#         Effect = "Allow"
#         Principal = {
#           Service = "qbusiness.amazonaws.com"
#         }
#         Action = [
#           "sts:AssumeRole"
#         ]
#         Condition = {
#           StringEquals = {
#             "aws:SourceAccount" = data.aws_caller_identity.current.account_id
#           }
#         }
#       }
#     ]
#   })

#   tags = [{
#     key   = "Modified By"
#     value = "AWSCC"
#   }]
# }

# resource "awscc_iam_role_policy" "this" {
#   policy_name = "sample_iam_role_policy"
#   role_name   = awscc_iam_role.ds.id

#   policy_document = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = "s3:GetObject"
#         Resource = "arn:aws:s3:::${var.bucket_name}/*"
#       },
#       {
#         Effect   = "Allow"
#         Action   = "s3:ListBucket"
#         Resource = "arn:aws:s3:::${var.bucket_name}"
#       },
#       {
#         Effect = "Allow"
#         Action = [
#           "qbusiness:BatchPutDocument",
#           "qbusiness:BatchDeleteDocument"
#         ]
#         Resource = "arn:aws:qbusiness:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:application/${awscc_qbusiness_application.this.id}/index/${awscc_qbusiness_index.this.id}"
#       },
#       {
#         Effect = "Allow"
#         Action = ["qbusiness:PutGroup",
#           "qbusiness:CreateUser",
#           "qbusiness:DeleteGroup",
#           "qbusiness:UpdateUser",
#         "qbusiness:ListGroups"]
#         Resource = [
#           "arn:aws:qbusiness:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:application/${awscc_qbusiness_application.this.id}",
#           "arn:aws:qbusiness:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:application/${awscc_qbusiness_application.this.id}/index/${awscc_qbusiness_index.this.id}",
#           "arn:aws:qbusiness:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:application/${awscc_qbusiness_application.this.id}/index/${awscc_qbusiness_index.this.id}/data-source/*"
#         ]
#       }
#     ]
#   })
# }

# variable "bucket_name" {
#   type        = string
#   description = "Name of the bucket to be used as the data source input"
# }
