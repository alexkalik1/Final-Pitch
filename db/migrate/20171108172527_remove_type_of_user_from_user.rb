class RemoveTypeOfUserFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :type_of_user, :string
  end
end
