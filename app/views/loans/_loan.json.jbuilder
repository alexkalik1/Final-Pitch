json.extract! loan, :id, :amount_in_cents, :body, :status, :created_at, :updated_at
json.url loan_url(loan, format: :json)
