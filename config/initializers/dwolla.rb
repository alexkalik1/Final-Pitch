require 'dwolla_v2'
# Navigate to https://www.dwolla.com/applications (production) or https://dashboard-sandbox.dwolla.com/applications (Sandbox) for your application key and secret.
    app_key = "Ip5J5CeMF4bxgtmK9Kh8jbyUjbZzBzSuHBv21L5SUlkGrUPAT9"
    app_secret = "DOxILUSfnrmZMtvVe6tf8i9ZCoHRRxNg33NwsfAlVeQlbJmTdG"
    $dwolla = DwollaV2::Client.new(key: app_key, secret: app_secret) do |config|
      config.environment = :sandbox # optional - defaults to production
    end
# create an application token --- AUTHORIZATION
    app_token = $dwolla.auths.client
