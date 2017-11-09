class AddUsersToLoans < ActiveRecord::Migration[5.1]
  def change
  	add_column :loans, :borrower_id, :integer
  	add_column :loans, :lender_id, :integer
  end


end
