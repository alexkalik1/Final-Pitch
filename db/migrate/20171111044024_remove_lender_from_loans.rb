class RemoveLenderFromLoans < ActiveRecord::Migration[5.1]
  def change
  	remove_column :loans, :lender, :integer
  end
end
