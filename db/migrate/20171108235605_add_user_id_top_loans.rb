class AddUserIdTopLoans < ActiveRecord::Migration[5.1]
  def change
  	add_reference :loans, :user, foregin_key: true
  end
end
