class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.integer :amount_in_cents
      t.string :body
      t.string :status

      t.timestamps
    end
  end
end
