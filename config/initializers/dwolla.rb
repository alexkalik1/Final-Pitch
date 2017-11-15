require 'dwolla_v2'
# Navigate to https://www.dwolla.com/applications (production) or https://dashboard-sandbox.dwolla.com/applications (Sandbox) for your application key and secret.
    app_key = "gOKm8Kfea1OWqnpIotdd356tpvX0t9qYId7mbbMXox311spVsl"
	app_secret = "ynT2HW8KRYWrFgJcim9DtE1vLOVSOctJlUmqtz2FxE60C6NhHj"
    $dwolla = DwollaV2::Client.new(key: app_key, secret: app_secret) do |config|
      config.environment = :sandbox # optional - defaults to production
    end
# create an application token --- AUTHORIZATION
    app_token = $dwolla.auths.client
