json.extract! user, :id, :first_name, :last_name, :email, :type_of_user, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)
