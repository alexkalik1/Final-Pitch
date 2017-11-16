require 'dwolla_v2'
# Navigate to https://www.dwolla.com/applications (production) or https://dashboard-sandbox.dwolla.com/applications (Sandbox) for your application key and secret.
  app_key = "NiiFPz8PAl9XoiATiDLRFVSPRbYxZyO2Dcqq0C7vjYFr9p1eQv"
	app_secret = "GvqTXPrHEitdprtmMyanLCSA4jCPeVRx9Q3ZWYpnz9JphHfi8s"
  $dwolla = DwollaV2::Client.new(key: app_key, secret: app_secret) do |config|
    config.environment = :sandbox # optional - defaults to production
  end
# create an application token --- AUTHORIZATION
  app_token = $dwolla.auths.client
