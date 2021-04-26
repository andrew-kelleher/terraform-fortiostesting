locals {
  
  fortigate_ipaddress = "<removed>" # IP address of primary FortiGate firewall
  fortigate_apikey    = "<removed>" # API key for REST API admin user

  sso_certificate = filebase64("${path.module}/fortigateeus2.cer") # example certificate to be used for SAML config
}

# define Azure AD tenant id - becomes part of SAML URL's
variable "tenantid" {
  type  = string
  default = "tenantid"
  description = "(Required) "
}