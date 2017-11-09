class User < ApplicationRecord
	has_many :borrowings, class_name: "Loan", foreign_key: "borrower_id"
	has_many :lendings, class_name: "Loan", foreign_key: "lender_id"

  has_secure_password
  enum role: [:Lender, :Borrower, :Admin]
end
