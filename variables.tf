# TODO

##### General #####

variable "prefix" {
  type        = string
  description = "prefix to be used for the Qbusiness application components"
  default = "test"
}

##### Application #####
variable "app_kms_key" {
  type        = string
  description = "KMS key for the app encryption configuration"
  default     = ""
}

variable "enable_encryption" {
  type = bool
  description = "Should encryption be enabled ?"
  default = true
}

variable "app_role_arn" {
  type        = string
  description = "Role arn to assume for the app"
  default     = ""
}

variable "app_identity_center_arn" {
  type        = string
  description = "Identity Center arn for the app"
  default     = ""
}
