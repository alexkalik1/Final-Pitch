class Loan < ApplicationRecord
  validates :status, inclusion: { in: %w(pending filled repaid) }
end
