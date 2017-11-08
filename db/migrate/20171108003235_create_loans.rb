class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.integer :borrower_id
      t.integer :lender_id
      t.string :amount
      t.string :body
      t.string :status
      t.date :term

      t.timestamps
    end
  end
end
