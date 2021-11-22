class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.jsonb :data
      t.string :accounting_entry
      t.uuid :public_id, default: 'gen_random_uuid()', null: false
      t.integer :amount

      t.timestamps
    end
  end
end
