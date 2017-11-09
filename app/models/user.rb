class User < ApplicationRecord
  has_secure_password
  enum role: [:Lender, :Borrower, :Admin]
  has_many :loans
end
