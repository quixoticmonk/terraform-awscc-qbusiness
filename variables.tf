# TODO

##### General #####

variable "prefix" {
  type        = string
  description = "prefix to be used for the Qbusiness application components"
  default     = "test"
}

variable "tags" {
  type        = list(object({ key = string, value = string }))
  description = "Tags to be attached to the Qbusiness resources"
  default = [{
    key   = "Modified By"
    value = "AWSCC"
  }]

}

##### Application #####
variable "app_kms_key" {
  type        = string
  description = "KMS key for the app encryption configuration"
  default     = ""
}

variable "enable_encryption" {
  type        = bool
  description = "Should encryption be enabled ?"
  default     = false
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

# QBusiness Index

variable "index_type" {
  type        = string
  description = "The type of index. The valid options are `ENTERPRISE` and `STARTER`"
  default     = "ENTERPRISE"
  validation {
    condition     = contains(["ENTERPRISE", "STARTER"], var.index_type)
    error_message = "The provided index type is not valid. Valid options are ENTERPRISE and STARTER."
  }

}

variable "storage_units" {
  type        = string
  description = "The number of storage units configured for an Amazon Q Business index."
  default     = 1
}

variable "attribute_config" {
  type = list(object({
    Name   = string,
    Search = string,
    Type   = string
  }))
  description = "Configuration information for document attributes"
  default     = null
}

# QBusiness Web Experience

variable "web_exp_subtitle" {
  type        = string
  default     = "Drop a file and ask questions"
  description = "Value for the QBusiness web experience subtitle"
}

variable "web_exp_title" {
  type        = string
  default     = "Sample Amazon Q Business App"
  description = "Value for the QBusiness web experience title"
}

variable "welcome_message" {
  type        = string
  default     = "Welcome, please enter your questions"
  description = "Value for the QBusiness web experience welcome message."
}
