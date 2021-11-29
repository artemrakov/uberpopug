class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :amount
      t.string :status
      t.references :transaction, null: false, foreign_key: true
      t.references :billing_cycle, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
