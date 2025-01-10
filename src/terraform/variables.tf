# subaccount
variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain."
  default     = "yourglobalaccount"
}

# subaccount name
variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "Systems Integration"
}

# Region
variable "region" {
  type        = string
  description = "The region where the project account shall be created in."
  default     = "us10"
}

# CLI server
variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cli.btp.cloud.sap"
}
#
# Cloudfoundry environment label
variable "cf_environment_label" {
  type        = string
  description = "The Cloudfoundry environment label"
  default     = "cf-us10"
}

# Cloudfoundry space name
variable "cf_space_name" {
  type        = string
  description = "The Cloudfoundry space name"
  default     = "dev"
}

# Integration Suite
variable "service_plan__sap_integration_suite" {
  type        = string
  description = "The plan for SAP Integration Suite"
  default     = "trial"
  validation {
    condition     = contains(["trial", "free", "enterprise_agreement"], var.service_plan__sap_integration_suite)
    error_message = "Invalid value for service_plan__sap_integration_suite. Only 'free' and 'enterprise_agreement' are allowed for production plan and 'trial' for the trial plan."
  }
}
