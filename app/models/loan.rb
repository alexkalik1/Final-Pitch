class Loan < ApplicationRecord
	belongs_to :lender, class_name: "User", foreign_key: "lender_id"
	belongs_to :borrower, class_name: "User", foreign_key: "borrower_id"

  validates :status, inclusion: { in: %w(pending filled repaid) }
  belongs_to :user
end
