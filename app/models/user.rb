class User < ApplicationRecord
	# has_many :borrowings, class_name: "Loan", foreign_key: "borrower_id"
	# has_many :lendings, class_name: "Loan", foreign_key: "lender_id"

  has_secure_password
  enum role: [:Lender, :Borrower, :Admin]
  has_many :loans
  # has_many :users, :source => :lender, :through => :loans
  # has_many :borrowers, class_name: "User", foreign_key: "lender_id"
  # belongs_to :lender, class_name: "User"

end
