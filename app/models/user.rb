class User < ApplicationRecord
	has_many :loans, class_name: "Loan", foreign_key: "borrower_id"
	has_many :investments, class_name: "Loan", foreign_key: "lender_id"

  has_secure_password
  enum role: [:Lender, :Borrower, :Admin]
end
