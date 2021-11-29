class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.jsonb :data
      t.string :accounting_entry
      t.uuid :public_id, default: 'gen_random_uuid()', null: false
      t.integer :amount
      t.references :billing_cycle, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
