# ------------------------------------------------------------------------------------------------------
# Setup of names in accordance to naming convention
# ------------------------------------------------------------------------------------------------------
resource "random_uuid" "uuid" {}

locals {
  random_uuid       = random_uuid.uuid.result
  subaccount_domain = lower(replace("integration-suite-${local.random_uuid}", "_", "-"))
}

data "btp_whoami" "me" {}

# ------------------------------------------------------------------------------------------------------
# Creation of subaccount
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount" "integration_suite" {
  count     = 1
  subdomain = local.subaccount_domain
  name      = var.subaccount_name
  region    = lower(var.region)
}

data "btp_subaccount" "integration_suite" {
  id = btp_subaccount.integration_suite[0].id
}

resource "btp_subaccount_role_collection_assignment" "subaccount-admins" {
  subaccount_id        = data.btp_subaccount.integration_suite.id
  role_collection_name = "Subaccount Administrator"
  user_name            = data.btp_whoami.me.email
}

# ------------------------------------------------------------------------------------------------------
# Add some entitlements we need 
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "xsuaa" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "xsuaa"
  plan_name     = "application"
}

resource "btp_subaccount_entitlement" "credstore" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "credstore"
  plan_name     = "proxy"
}
# ------------------------------------------------------------------------------------------------------
# Creation of Cloud Foundry environment
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "cf_application_runtime" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "APPLICATION_RUNTIME"
  plan_name     = "MEMORY"
  amount        = 2
}
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = data.btp_subaccount.integration_suite.id
  name             = "my-cf-environment"
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "trial"

  parameters = jsonencode({
    instance_name = local.subaccount_domain
    memory = 2048
  })

  timeouts = {
    create = "1h"
    update = "35m"
    delete = "30m"
  }
}

# ------------------------------------------------------------------------------------------------------
# Create Cloudfoundry space
# ------------------------------------------------------------------------------------------------------
# Create Space
resource "cloudfoundry_space" "my_space" {
  name       = var.cf_space_name
  org        = btp_subaccount_environment_instance.cloudfoundry.platform_id
}

resource "cloudfoundry_space_role" "space_manager" {
  username = data.btp_whoami.me.email
  type       = "space_manager"
  space      = cloudfoundry_space.my_space.id
}

resource "cloudfoundry_space_role" "space_developer" {
  username = data.btp_whoami.me.email
  type       = "space_developer"
  space      = cloudfoundry_space.my_space.id
}

# ------------------------------------------------------------------------------------------------------
# Add entitlement for BAS, Subscribe BAS and add roles
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "bas" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "sapappstudiotrial"
  plan_name     = "trial"
}

resource "btp_subaccount_subscription" "bas-subscribe" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  app_name      = "sapappstudiotrial"
  plan_name     = "trial"
  depends_on    = [btp_subaccount_entitlement.bas]
}

resource "btp_subaccount_role_collection_assignment" "Business_Application_Studio_Administrator" {
  subaccount_id        = data.btp_subaccount.integration_suite.id
  role_collection_name = "Business_Application_Studio_Administrator"
  user_name            = data.btp_whoami.me.email
  depends_on           = [btp_subaccount_subscription.bas-subscribe]
}

resource "btp_subaccount_role_collection_assignment" "Business_Application_Studio_Developer" {
  subaccount_id        = data.btp_subaccount.integration_suite.id
  role_collection_name = "Business_Application_Studio_Developer"
  user_name            = data.btp_whoami.me.email
  depends_on           = [btp_subaccount_subscription.bas-subscribe]
}

# ------------------------------------------------------------------------------------------------------
# Create HANA entitlement subscription
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "hana-cloud" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "hana-cloud-trial"
  plan_name     = "hana"
}
# Enable HANA Cloud Tools
resource "btp_subaccount_entitlement" "hana-cloud-tools" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "hana-cloud-tools-trial"
  plan_name     = "tools"
}
resource "btp_subaccount_subscription" "hana-cloud-tools" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  app_name      = "hana-cloud-tools-trial"
  plan_name     = "tools"
  depends_on    = [btp_subaccount_entitlement.hana-cloud-tools]
}
resource "btp_subaccount_entitlement" "hana-hdi-shared" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "hana"
  plan_name     = "hdi-shared"
}

resource "btp_subaccount_role_collection_assignment" "hana-admin-role" {
  depends_on           = [btp_subaccount_subscription.hana-cloud-tools]
  subaccount_id        = data.btp_subaccount.integration_suite.id
  role_collection_name = "SAP HANA Cloud Administrator"
  user_name             = data.btp_whoami.me.email
}

# ------------------------------------------------------------------------------------------------------
# Prepare and setup app: SAP Build Workzone, standard edition
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "build_workzone" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "SAPLaunchpad"
  plan_name     = "standard"
}

resource "btp_subaccount_subscription" "build_workzone" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  app_name      = "SAPLaunchpad"
  plan_name     = "standard"
  depends_on    = [btp_subaccount_entitlement.build_workzone]
}

resource "btp_subaccount_role_collection_assignment" "launchpad_admin" {
  subaccount_id        = data.btp_subaccount.integration_suite.id
  role_collection_name = "Launchpad_Admin"
  user_name            = data.btp_whoami.me.email
  depends_on           = [btp_subaccount_subscription.build_workzone]
}

# ------------------------------------------------------------------------------------------------------
# Create app subscription to SAP Integration Suite Trial
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "sap_integration_suite" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "integrationsuite-trial"
  plan_name     = var.service_plan__sap_integration_suite
  amount        = 1
}

data "btp_subaccount_subscriptions" "all" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  depends_on    = [btp_subaccount_entitlement.sap_integration_suite]
}

resource "btp_subaccount_subscription" "sap_integration_suite" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  app_name = [
    for subscription in data.btp_subaccount_subscriptions.all.values :
    subscription
    if subscription.commercial_app_name == "integrationsuite-trial"
  ][0].app_name
  plan_name  = var.service_plan__sap_integration_suite
  depends_on = [data.btp_subaccount_subscriptions.all]
}

resource "btp_subaccount_role_collection_assignment" "int_prov" {
  depends_on           = [btp_subaccount_subscription.sap_integration_suite]
  subaccount_id        = data.btp_subaccount.integration_suite.id
  role_collection_name = "Integration_Provisioner"
  user_name             = data.btp_whoami.me.email
}
  
# ------------------------------------------------------------------------------------------------------
# Create SAP Process Integration runtime
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_entitlement" "sap_integration_rt_flow" {
  subaccount_id = data.btp_subaccount.integration_suite.id
  service_name  = "it-rt"
  plan_name     = "integration-flow"
}
