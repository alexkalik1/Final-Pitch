require 'dwolla_v2'

class Dwolla

  def initialize
    app_key = "kq61IRSbsZTNARRHFx4ClXeChJPiPpbRNvz54rHYhfJcUQy3kl"
    app_secret = "qlpR2k85I5IFT0K5FMw7trj1xAF4oDnBE3aF9a2QNDni9CoX3O"
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

  def create_customer(first_name, last_name, email, type, address, city, state, postal_code, date_of_birth, last_four_of_ssn)
    request_body = {
      :firstName => first_name,
      :lastName => last_name,
      :email => email,
      :type => type,
      :address1 => address,
      :city => city,
      :state => state,
      :postalCode => postal_code,
      :dateOfBirth => date_of_birth,
      :ssn => last_four_of_ssn
    }
    customer = @dwolla.auths.client.post "customers", request_body
  end


end


# create an application token --- AUTHORIZATION
