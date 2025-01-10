# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
# Your global account subdomain
globalaccount        = "youraccount"
region               = "us10"
subaccount_name      = "SAP Discovery Center Mission 4038"
cf_environment_label = "cf-us10"
cf_space_name        = "dev"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
# Don't add the user, that is executing the TF script to subaccount_admins or subaccount_service_admins!

service_plan__sap_integration_suite = "trial"
