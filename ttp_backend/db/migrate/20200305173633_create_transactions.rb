class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :ticker
      t.integer :shares
      t.float :cost_purchased
      t.integer :user_id
    end
  end
end
