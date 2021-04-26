terraform {
  required_version = "=  0.14.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "1.1.1"
    }

    fortios = {
      source = "fortinetdev/fortios"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "fortios" {
  hostname = local.fortigate_ipaddress
  token    = local.fortigate_apikey
  insecure = "true"
}