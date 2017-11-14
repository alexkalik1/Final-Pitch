class RemoveColumnsFromLoans < ActiveRecord::Migration[5.1]
  def change
    remove_column :loans, :borrower_id, :integer
    remove_column :loans, :lender_id, :integer
  end
end
