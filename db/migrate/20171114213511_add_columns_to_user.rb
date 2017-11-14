class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :postal_code, :string
    add_column :users, :date_of_birth, :string
    add_column :users, :last_four_of_ssn, :string
  end
end
