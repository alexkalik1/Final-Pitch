class Loan < ApplicationRecord
  validates :status, inclusion: { in: %w(pending filled repaid) }
  belongs_to :user
end
