class AddColumnToLoans < ActiveRecord::Migration[5.1]
  def change
  	add_column :loans, :lender, :integer
  end
end
