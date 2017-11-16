class AddTipInCentsToLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :tip_in_cents, :integer
  end
end
