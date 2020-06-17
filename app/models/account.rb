class Account < ApplicationRecord
  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "http://localhost:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    settings.issuer                         = url_base + "/saml/metadata"
    settings.assertion_consumer_service_url = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    onelogin_app_id = "<onelogin-app-id>"

    # IdP section
    settings.idp_entity_id                  = "urn:auth0-sso.us.auth0.com"
    settings.idp_cert_fingerprint           = "E1:80:DF:EA:4E:C4:0A:0D:58:6D:3C:97:A7:04:9E:F7:3B:18:8F:CB"
    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1
    settings.idp_cert                       = <<-CERT
-----BEGIN CERTIFICATE-----
MIIDBzCCAe+gAwIBAgIJOzwLHwOhMT8iMA0GCSqGSIb3DQEBCwUAMCExHzAdBgNV
BAMTFmF1dGgwLXNzby51cy5hdXRoMC5jb20wHhcNMjAwNjE2MTQyNDA4WhcNMzQw
MjIzMTQyNDA4WjAhMR8wHQYDVQQDExZhdXRoMC1zc28udXMuYXV0aDAuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv816fBJRXWvWBw+V9U0FwwiX
4M901/ZZ0XW45QVOUqhm/BQzOJ/MKJG1Ky1uCbPBRnaKeJz+AaMX/AIEmZQ3Xm7W
GY5SkollS+BB3RjiQw5CpL0viNNHr41EiClFllJ0MQ95jRyssKGPx5CDWcWwIs64
g7KL6IC8PlFTepvBU1gnHcjdfJr2Hykdo+Sbek7R57RgPwxOGFV2F8skTpVKBgGg
P5Ck3kGzmD0guhgNybAs9E+n1SpY5oB6LOXOyzPL04eOtTgPORQ0YNK9meBNC1vI
Oh1ZAuWDova706aBQbzbZfZtjsEvHxXTywB51zheDcn2sPArVtcfELflmocytQID
AQABo0IwQDAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBR7BunSAdAOeoa27GcC
Yfs+KBEuEzAOBgNVHQ8BAf8EBAMCAoQwDQYJKoZIhvcNAQELBQADggEBAL9PfWO5
2X/Djlj89bS/AKObwYHQRz9GBOC+y7d+AOpB1NPvPDZpCO0sT1t3DLdrpa8uPnCL
P4aAWeFiasGknTfYMnvvSAadgcR4LS2mr9aKsNE9uQLIE51Hn30KpnRZlUuzwNqT
MLcIoy5kDNChXHz44/2LBqhYpZ7cjavZj9dCZ9WgcqnLPbpn03hxcDIe1dqsmcQN
kY678L7XGqY7HMkNJNc2njlq18/oq/RFBa2qPV5e+FWOu8Hx9pN3vPr7CxJNKQxN
DlrM37fD0XF1jHHK2I4SxWc0eFYEnb6LaEE8CYv0ILeVUOly7I6UU8lhli6UKpnc
YuSV1M7pwWjXk+c=
-----END CERTIFICATE-----
CERT

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed] = false
    settings.security[:logout_requests_signed] = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed] = false
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1

    settings
  end
end
