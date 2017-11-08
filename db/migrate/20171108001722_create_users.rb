class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :user_type
      t.string :routing_number
      t.string :account_number
      t.string :type
      t.string :account_name

      t.timestamps
    end
  end
end
