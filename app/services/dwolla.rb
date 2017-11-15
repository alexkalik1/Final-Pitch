require 'dwolla_v2'

class Dwolla

  def initialize
    app_key = "Ip5J5CeMF4bxgtmK9Kh8jbyUjbZzBzSuHBv21L5SUlkGrUPAT9"
    app_secret = "DOxILUSfnrmZMtvVe6tf8i9ZCoHRRxNg33NwsfAlVeQlbJmTdG"
    @dwolla = DwollaV2::Client.new(key: app_key, secret: app_secret) do |config|
      config.environment = :sandbox # optional - defaults to production
    end
    @app_token = @dwolla.auths.client
    get_customers
  end

  def get_customers
    @customers = @dwolla.auths.client.get("customers")._embedded.customers
  end

  def find_funding_source_url(email)
    @customers.each do |transfer|
      if transfer.email == email
        this_href = transfer._links.self.href

        customer_url = "#{this_href}/funding-sources"
        funding_source = @dwolla.auths.client.get customer_url
        return funding_source._embedded['funding-sources'][0]._links.self.href
      end
    end
  end

  def find_url(email)
    @customers.each do |transfer|
      if transfer.email == email
        return transfer._links.self.href
      end
    end
  end

  def send_money(from, to, amount)
    request_body = {
      :_links => {
        :source => {
          :href => from
        },
        :destination => {
          :href => to
        }
      },
      :amount => {
        :currency => "USD",
        :value => amount
      },
      :metadata => {
        :paymentId => "12345678",
        :note => "ITS WORKINNGGGGGGG"
      },
      :clearing => {
        :destination => "next-available"
      },
      :correlationId => "8a2cdc8d-629d-4a24-98ac-40b735229fe2"
    }

    transfer = @dwolla.auths.client.post "transfers", request_body
  end

end


# create an application token --- AUTHORIZATION
