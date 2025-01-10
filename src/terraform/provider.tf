terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = ">= 1.5.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = ">= 1.0.0"
    } 
  }
}

provider "btp" {
  globalaccount  = var.globalaccount
  cli_server_url = var.cli_server_url
}

provider "cloudfoundry" {
  api_url = "https://api.cf.${var.region}-001.hana.ondemand.com"
}
