#### Upload certificate to be used by SAML SSO configuration ####

# This resource type doesn't currently work. Using generic_api instead
# resource "fortios_vpncertificate_remote" "cert" {
#     name = "terracert"
#     remote = local.sso_certificate
#     range = "global"
#     source = "user"
# }

resource "fortios_json_generic_api" "genericapicall" {
  path   = "/api/v2/monitor/vpn-certificate/remote/import"
  method = "POST"
  json   = <<EOF
{
    "type": "regular",
    "certname": "testcert",
    "password": "",
    "file_content": "${local.sso_certificate}"
}
EOF
}


#### Configure SAML SSO ####

# Fortinet example SSO config
# resource "fortios_system_saml" "examplesaml" {
#   default_login_page = "normal"
#   default_profile    = "admin_no_access"
#   life               = 30
#   role               = "service-provider"
#   status             = "disable"
#   tolerance          = 5
# }

# Customer SSO config
resource "fortios_system_saml" "tegrasaml" {
  depends_on = [fortios_json_generic_api.genericapicall]
  default_login_page = "normal"
  default_profile    = "super_admin"
  life               = 30
  role               = "service-provider"
  status             = "enable"
  tolerance          = 5
  server_address     = "fortigateatnnt01eus2.fortigateeus2.trusted" # DNS hostname of primary Fortigate firewall
  idp_entity_id      = "https://sts.windows.net/${var.tenantid}/"
  idp_single_sign_on_url = "https://sts.windows.net/${var.tenantid}/"
  idp_single_logout_url  = "https://login.microsoftonline.com/${var.tenantid}/saml2"
  idp_cert               = "REMOTE_Cert_1"
}


#### Configure SSO admins ####
resource "fortios_system_ssoadmin" "admin1" {
  accprofile = "super_admin"
  name       = "andrew.kelleher@adomain.com"
  
  vdom {
    name = "root"
  }
}

resource "fortios_system_ssoadmin" "admin2" {
  accprofile = "super_admin"
  name       = "pradeep.toluganti@adomain.com"
  
  vdom {
    name = "root"
  }
}