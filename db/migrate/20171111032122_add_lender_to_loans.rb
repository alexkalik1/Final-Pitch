class AddLenderToLoans < ActiveRecord::Migration[5.1]
  def change
  	  	add_column :loans, :lender_id, :integer
  end
end
